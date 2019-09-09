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
    // Пользователь региструется по заявке
    // Обучалка при первом запуске??
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    var handle: AuthStateDidChangeListenerHandle! // Do I need it?
    var isCurrentUserExist: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("**INIT: ", String(describing: self.description))
        isCurrentUserExist = AuthManager.shared.isCurrentUserExist()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        handle  = Auth.auth().addStateDidChangeListener { (auth, user) in
            //code  - if user was changed (how it's gonna happen)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
        
        
        super.viewWillDisappear(true)
    }
    
    private func setupUI() {
        
        if isCurrentUserExist {
            
        } else {
            
        }
        
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        //registrateUser()
        performSegue(withIdentifier: "goToRegistration", sender: self)
    }
    
    
    @IBAction func confirmUserButtonPressed(_ sender: UIButton) {
       
        let userEmail = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        AuthManager.shared.confirmUser(userEmail: userEmail, password: password) { (result, error) in
            guard error == nil else {
                //TODO: Show alert about the error here
                
                return
            }
            self.showTheMainScreen()
        }
    }
    
    private func showTheMainScreen() {
        self.performSegue(withIdentifier: "fromAuthToMainVC", sender: self)
    }
    
    private func registrateUser() {
        
        
        //TODO: Handel if the fields are empry (maybe something else too)
        let userEmail = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        AuthManager.shared.registerUser(userEmail: userEmail, password: password) { (result, error) in
            //
            guard error == nil else {
                //TODO: Show alert about the error here
                
                return
            }
            self.showTheMainScreen()
        }
    }
    
    private func continueWithCurrentUser() {
        
    }
    
    deinit {
        print("**DEINIT: ", String(describing: self.description))
    }
}
