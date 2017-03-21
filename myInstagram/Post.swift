//
//  Post.swift
//  myInstagram
//
//  Created by Shumba Brown on 3/14/17.
//  Copyright © 2017 Shumba Brown. All rights reserved.
//

import UIKit
import Parse
import ParseUI

struct Likes {
    var count: Int?
    var likedBy: [User?]
    
    init () {
        count = 0
        likedBy = []
    }
}

struct TheComment {
    var text: String?
    var commentBy: User?
    
    init () {
        text = ""
        commentBy = nil
    }
}

struct Comments {
    var count: Int?
    var comment: [TheComment?]
    
    init () {
        count = 0
        comment = []
    }
}

class Post: NSObject {
    var id: String?
    var user: User?
    var image: PFFile?
    var caption: String?
    var likes: Likes?
    var comments: Comments?
    
    override init() {
        self.id = ""
        self.user = User()
        //self.image
        self.caption = ""
        self.likes?.count = 0
        self.likes?.likedBy = []
        
    }
}
