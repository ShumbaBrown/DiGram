//
//  ServerClient.swift
//  myInstagram
//
//  Created by Shumba Brown on 3/18/17.
//  Copyright © 2017 Shumba Brown. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ServerClient: NSObject {
    
    var success = false
    
    func AddUser(user: User, successful: @escaping () -> (), failure: @escaping(Error) -> ()) {
        self.success = false
        let newUser = PFUser()
        
        newUser.username = user.username
        newUser.password = user.password
        newUser["fullName"] = "default"
        let profilePhoto = #imageLiteral(resourceName: "profile-photo")
        newUser["profilePhoto"] = getPFFileFromImage(image: profilePhoto)
        newUser["bio"] = "default"
        newUser["media"] = 0
        newUser["follows"] = 0
        newUser["followedBy"] = 0
        
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if success {
                print("Account Created!")
                successful()
            }
            else {
                print(error?.localizedDescription)
                failure(error!)
            }
        }
        
        
    }
    
    func createPost(post: Post, successful: @escaping () -> (), failure: @escaping(Error) -> ()) {
        
        let newPost = PFObject(className: "Post")
        
        
        
        //newPost["userid"] = post.user?.id
        newPost["useruserName"] = post.user?.username
        newPost["userfullName"] = post.user?.fullName
        newPost["userprofilePhoto"] = post.user?.profilePhoto
        newPost["userbio"] = post.user?.bio
        newPost["usermedia"] = post.user?.media
        newPost["userfollows"] = post.user?.follows
        newPost["userfollowedBy"] = post.user?.followedBy
        
        
        newPost["image"] = post.image
        newPost["caption"] = post.caption
        newPost["likescount"] = 0
        newPost["likeslikedBy"] = []
        newPost.saveInBackground { (success: Bool, error: Error?) in
            if success {
                print("Image uploaded!")
                successful()
            }
            else {
                failure(error!)
            }
        }
    }
    
    func getTimeLineWithBlock(success: @escaping ([Post]) -> (), failure: @escaping(Error) -> ()) -> [Post] {
        var posts: [Post] = []
        var query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        //query.limit = limit
        query.findObjectsInBackground { (response: [PFObject]?, error: Error?) in
            if error != nil {
                print(error?.localizedDescription)
            }
            else {
                print("In getTimeline")
                print(response)
                if let response = response {
                    for thing in response {
                        let post = Post()
                        //post.id = thing["_id"] as! String?
                        post.user?.username = thing["useruserName"] as! String
                        post.user?.id = thing["userid"] as? String
                        post.user?.fullName = thing["userfullName"] as! String
                        post.user?.profilePhoto = thing["userprofilePhoto"] as! PFFile
                        post.user?.bio = thing["userbio"] as! String
                        post.user?.media = thing["usermedia"] as! Int
                        post.user?.follows = thing["userfollows"] as! Int
                        post.user?.followedBy = thing["userfollowedBy"] as! Int
                        
                        post.image = thing["image"] as! PFFile
                        post.caption = thing["caption"] as! String?
                        post.likes?.count = thing["likescount"] as! Int
                        post.likes?.likedBy = thing["likeslikedBy"] as! [User]
                        
                        posts.append(post)
                        print("In getTimeline")
                        print(thing)
                    }
                }
                success(posts)
            }
            
        }
        
        return posts
    }
    
    func getTimeLine(limit: Int) -> [Post] {
        var posts: [Post] = []
        var query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.limit = limit
        query.findObjectsInBackground { (response: [PFObject]?, error: Error?) in
            if error != nil {
                print(error?.localizedDescription)
            }
            else {
                print("In getTimeline")
                print(response)
                if let response = response {
                    for thing in response {
                        let post = Post()
                        //post.id = thing["_id"] as! String?
                        post.user?.id = thing["userid"] as? String
                        post.user?.fullName = thing["userfullName"] as! String
                        post.user?.profilePhoto = thing["userprofilePhoto"] as! PFFile
                        post.user?.bio = thing["userbio"] as! String
                        post.user?.media = thing["usermedia"] as! Int
                        post.user?.follows = thing["userfollows"] as! Int
                        post.user?.followedBy = thing["userfollowedBy"] as! Int
                        
                        post.image = thing["image"] as! PFFile
                        post.caption = thing["caption"] as! String?
                        post.likes?.count = thing["likescount"] as! Int
                        post.likes?.likedBy = thing["likeslikedBy"] as! [User]
                        
                        posts.append(post)
                        print("In getTimeline")
                        print(thing)
                    }
                }
                
            }
        }
        return posts
        
    }
    
    
    
    
    
    
    //
    // Helper Functions
    //
    
    func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
}
