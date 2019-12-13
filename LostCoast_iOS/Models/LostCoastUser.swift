//
//  LostCoastUser.swift
//  LostCoast_iOS
//
//  Created by Derek Nguyen on 8/17/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class LostCoastUser: Object {
    
    /// User's first name
    dynamic var firstName: String = ""
    
    /// User's last name
    dynamic var lastName: String = ""
    
    /// User's unique username
    dynamic var username: String = ""
    
    /// User's email address associated with Firebase
    dynamic var email: String = ""
    
    /// User's date of birth
    dynamic var birthday: TimeInterval = 0
    
    /// User's gender
    dynamic var gender: String = ""
    
    /// User's Firebase UID
    dynamic var uid: String = ""
    
    /// URL to download user profile image
    dynamic var imageURL: String = ""
    
    /// User's profile image
    var image: Data?
    
    /// User's self describing bio
    dynamic var biography: String = ""
    
    /// User's country
    dynamic var country: String = ""
    
    /// User's state if they are from United States
    dynamic var state: String = ""
}

extension LostCoastUser {
    
    func toDict() -> [String : Any] {
        let dictionary: [String : Any] = [
            "firstName" : self.firstName,
            "lastName" : self.lastName,
            "username" : self.username,
            "email" : self.email,
            "gender": self.gender,
            "birthday" : self.birthday,
            "uid" : self.uid,
            "imageURL" : self.imageURL,
            "biography" : self.biography,
            "country" : self.country,
            "state" : self.state
        ]
        
        return dictionary
    }
    
    static func parse(dictionary: [String : Any]) -> LostCoastUser {
        let user = LostCoastUser()
        user.firstName = (dictionary["firstName"] as? String) ?? ""
        user.lastName = (dictionary["lastName"] as? String) ?? ""
        user.username = (dictionary["username"] as? String) ?? ""
        user.email = (dictionary["email"] as? String) ?? ""
        user.birthday = (dictionary["birthday"] as? TimeInterval) ?? 0.0
        user.gender = (dictionary["gender"] as? String) ?? ""
        user.uid = (dictionary["uid"] as? String) ?? ""
        user.imageURL = (dictionary["imageURL"] as? String) ?? ""
        user.biography = (dictionary["biography"] as? String) ?? ""
        user.country = (dictionary["country"] as? String) ?? ""
        user.state = (dictionary["state"] as? String) ?? ""
        return user
    }
    
}

