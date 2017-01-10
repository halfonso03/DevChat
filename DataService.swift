//
//  DataService.swift
//  DevChat
//
//  Created by Alfonso, Hector I. on 12/30/16.
//  Copyright © 2016 Alfonso, Hector I. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

class DataService {
    
    private static let _instance = DataService()
    
    var usersRef: FIRDatabaseReference {
        return mainRef.child("users")
    }

    var mainStorageRef: FIRStorageReference {
        return FIRStorage.storage().reference(forURL: "gs://devchat-c46ad.appspot.com")
    }
    
    var imageStorageRef: FIRStorageReference {
        return mainStorageRef.child("images")
    }
    
    var videoStorageRef: FIRStorageReference {
        return mainStorageRef.child("videos")
    }
    
    static var instance: DataService {
        return _instance
    }
    
    var mainRef: FIRDatabaseReference {
        return FIRDatabase.database().reference()
    }
    
    func saveUser(uid: String) {
        let profile: [String: Any] = ["firstName": "", "lastName": ""]
        
        mainRef.child("users").child(uid).child("profile").setValue(profile)
    }
    
    
    func sendMediaPullRequests(senderUID: String, sendToUser users: [String: User], mediaUrl: URL, textSnippet: String? = nil) {
        
        var keys: [String] = users.map { (key, user) -> String in
            return key
        }
        
        var pr: [String: Any] = ["mediaUrl" : mediaUrl.absoluteString, "userUID": senderUID, "openCount": 0, "recipients": keys]
        
        
        
        mainRef.child("pullRequests").childByAutoId().setValue(pr)
        
        
        
    }
    
}
