//
//  User.swift
//  myInstagram
//
//  Created by Shumba Brown on 3/17/17.
//  Copyright © 2017 Shumba Brown. All rights reserved.
//

import UIKit
import Parse

class User: NSObject {
    
    var id: String?
    var username: String?
    var password: String?
    var fullName: String?
    var profilePhoto: PFFile?
    var bio: String?
    var media: Int?
    var follows: Int?
    var followedBy: Int?
    
    
    override init () {
        
        self.id = ""
        self.username = ""
        self.fullName = ""
        self.profilePhoto = nil
        self.bio = ""
        self.media = 0
        self.follows = 0
        self.followedBy = 0
        self.password = nil
    }
    
    
    func setupFrom(userDictionary: PFUser) {
        print(userDictionary)
        self.id = userDictionary["_id"] as? String
        self.username = userDictionary.username
        self.fullName = userDictionary["fullName"] as! String
        self.profilePhoto = userDictionary["profilePhoto"] as! PFFile
        self.bio = userDictionary["bio"] as! String
        self.media = userDictionary["media"] as! Int
        self.follows = userDictionary["follows"] as! Int
        self.followedBy = userDictionary["followedBy"] as! Int
        self.password = nil
    }
 
    
    
}
