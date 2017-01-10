//
//  User.swift
//  DevChat
//
//  Created by Alfonso, Hector I. on 12/30/16.
//  Copyright © 2016 Alfonso, Hector I. All rights reserved.
//

import Foundation


struct User {
    
    private var _firstName: String!
    private var _uid: String!
    
    
    var uid: String {
        return self._uid ?? ""
    }
    
    var firstName: String {
        return self._firstName ?? ""
    }
    
    init(uid: String, firstName: String) {
        self._uid = uid
        self._firstName = firstName
    }
    
}
