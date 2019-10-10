//
//  AuthManager.swift
//  rDefender
//
//  Created by AlexanderN on 01/09/2019.
//  Copyright © 2019 AlexanderN. All rights reserved.
//

import Foundation
import Firebase

class AuthManager {
    static let shared = AuthManager()
    private let db = Firestore.firestore()
    
    func isCurrentUserExist() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    func getCurrentUser() -> User? {
        return Auth.auth().currentUser
    }
    
    func registerUser(userEmail: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        
        
        Auth.auth().createUser(withEmail: userEmail, password: password) { (result, error) in
            //
            guard error == nil else {
                //TODO: describe 'error' in a good way in all the progeject
                print(error!)
                completion(nil, error)
                return
            }
            
            guard let result = result else { return }
            //TODO: describe 'success' in a good way in all the progeject
            
            let ref = self.db.collection("users").document(result.user.uid)
            
            ref.setData([
                "email" : result.user.email ?? "",
                "name" : "",
                "aprtmentNumber" : "",
                "houseNumber" : ""
            ]) { error in
                if let error = error {
                    print("Error adding document: \(error)")
                    //completion(nil, error)
                } else {
                    print("Document added with ID: \(ref.documentID)")
                    //completion(ref, nil)
                }
                
            }
            print(result)
            completion(result, nil)
        }
    }
    
    func confirmUser(userEmail: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        
        //weak self doesn't make sence here becouse it's a singeltone
        
        Auth.auth().signIn(withEmail: userEmail, password: password) { /*[weak self]*/ result, error in
            //guard let strongSelf = self else { return }
            // ...
            guard error == nil else {
                //TODO: describe 'error' in a good way in all the progeject
                print(error!)
                completion(nil, error)
                return
            }
            
            guard let result = result else { return } // do you realy need the guard?
            //TODO: describe 'success' in a good way in all the progeject
            print(result)
            completion(result, nil)
        }
    }
    
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print("signOut error: \(error)")
        }
    }
    
    
    //
    private init() {}
}
