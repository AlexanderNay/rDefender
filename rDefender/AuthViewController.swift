//
//  AuthViewController.swift
//  rDefender
//
//  Created by AlexanderN on 29/08/2019.
//  Copyright © 2019 AlexanderN. All rights reserved.
//

import UIKit
import Firebase

class AuthViewController: UIViewController {
    
    // ВАЛИДАЦИЯ ПО НОМЕРУ ТЕЛЕФОНА (только добавленные номера могут регистрироваться)
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    var handle: AuthStateDidChangeListenerHandle!
    var isCurrentUserExist: Bool = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        isCurrentUserExist = Auth.auth().currentUser != nil
        print("current user: ", Auth.auth().currentUser?.email)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        handle  = Auth.auth().addStateDidChangeListener { (auth, user) in
            //
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
        
        
        super.viewWillDisappear(true)
    }
    

    @IBAction func registerButtonPressed(_ sender: UIButton) {
        registrateUser()
        
    }
    
    
    @IBAction func continueAsUserButtonPressed(_ sender: UIButton) {
        
        let guest = Guest(id: "", name: "John Wick", carModel: "Car", carNumber: "J.Wick", date: Date())
        
        DBMandger.shared.seveGuest(guest: guest) { (ref, err) in
            if ref?.documentID != nil {
                print("SUCCESS write document: ", ref!.documentID)
            }
        }
        
        DBMandger.shared.getGuests { (quertySnapshot, error) in
            if error == nil {
                print("SUCCESS get guests")
            }
        }
    }
    
    
    
    
    
    private func registrateUser() {
        
        let userEmail = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        Auth.auth().createUser(withEmail: userEmail, password: password) { (result, error) in
            //
            guard error == nil else {
                print(error!)
                return
            }
            print(result!)
            //self.performSegue(withIdentifier: "mainVC", sender: self)
        }
    }
    
    private func continueWithCurrentUser() {
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
