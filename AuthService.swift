//
//  AuthService.swift
//  DevChat
//
//  Created by Alfonso, Hector I. on 12/29/16.
//  Copyright © 2016 Alfonso, Hector I. All rights reserved.
//

import Foundation
import FirebaseAuth


typealias
    Completion = (_ errorMessage: String?, _ data: Any?) -> ()

class AuthService {
    
    private static let _instance = AuthService()
    
    
    static var instance: AuthService {
        return _instance
    }
    
    
    func login(withEmail email: String, password: String, completion: Completion?) {
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            
            if error != nil {
                if let errorCode = FIRAuthErrorCode(rawValue: (error as! NSError).code) {
                    if errorCode == .errorCodeUserNotFound {
                        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                            if error != nil {
                                self.handleFirebaseError(error: error as! NSError, onComplete: completion!)
                            }
                            else {
                                if user?.uid != nil {
                                    DataService.instance.saveUser(uid: user!.uid)
                                    FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                                        if error != nil {
                                            self.handleFirebaseError(error: error as! NSError, onComplete: completion!)
                                        }
                                        else {
                                            completion?(nil, user)
                                            
                                        }
                                    })
                                }
                            }
                        })
                    }
                }
                else {
                    self.handleFirebaseError(error: error as! NSError, onComplete: completion!)
                }
            }
            else {
                // successfully logged in
                completion?(nil, user)
            }
        })
        
    }
    
    
    func handleFirebaseError(error: NSError, onComplete: Completion) {
        print (error.debugDescription)
        
        if let errorCode = FIRAuthErrorCode(rawValue: error.code) {
            switch errorCode {
            case .errorCodeInvalidEmail:
                onComplete("Invalid email address", nil)
                break
            case .errorCodeWrongPassword:
                onComplete("Invalid password", nil)
                break
            case .errorCodeEmailAlreadyInUse, .errorCodeAccountExistsWithDifferentCredential:
                onComplete("Could not create account. Email already in use", nil)
                break
            default:
                onComplete("There was a problem, try again", nil)
            }
        }
    }
    
}
