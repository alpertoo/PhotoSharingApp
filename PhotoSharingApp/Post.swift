//
//  Post.swift
//  PhotoSharingApp
//
//  Created by Alper Koçer on 3.01.2023.
//

import Foundation

class Post {
    
    var email: String
    var comment: String
    var imageURL: String
    
    init(email: String, comment: String, imageURL: String) {
        self.email = email
        self.comment = comment
        self.imageURL = imageURL
    }
    
}
