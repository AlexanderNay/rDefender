//
//  DBManager.swift
//  rDefender
//
//  Created by AlexanderN on 01/09/2019.
//  Copyright © 2019 AlexanderN. All rights reserved.
//

import Foundation
import Firebase

class DBManager {
    
    static let shared = DBManager()
    private let db = Firestore.firestore()
    private var ref: DocumentReference? = nil
    
    func seveGuest(guest: Guest, completion: @escaping (DocumentReference?, Error?) -> Void) {
        
        guard let user = Auth.auth().currentUser else { return }
        
        ref = db.collection("users").document(user.uid).collection("guests").document()
       
        guard let ref = ref else {
            print("ERROR: document == nil")
            return
        }
        
        ref.setData([
            "id" : ref.documentID,
            "name" : guest.name ?? "",
            "carModel" : guest.carModel ?? "",
            "carNumber" : guest.carNumber ?? ""
        ]) { error in
            if let error = error {
                print("Error adding document: \(error)")
                completion(nil, error)
            } else {
                print("Document added with ID: \(self.ref!.documentID)")
                completion(self.ref!, nil)
            }
            
        }
    }
    
    func getGuests(completion: @escaping (QuerySnapshot?, Error?) -> Void) {
        
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        db.collection("users").document(userId).collection("guests").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                completion(nil, error)
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
                completion(querySnapshot, nil)
            }
        }
        
        
    }
    
    func deleteGuest(guest: Guest, completion: @escaping (Error?) -> Void) {
        
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        db.collection("users").document(userId).collection("guests").document(guest.id).delete() { error in
            if let error = error {
                print("Error removing document: \(error)")
                completion(error)
            } else {
                print("Document successfully removed!")
                completion(nil)
            }
        }
        
    }
    
    func getCurrentUser() -> User? {
        return Auth.auth().currentUser
    }
    
    
    
    
    private init() {}
    
}
