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
        notificateKeyboardposition()
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
    
    fileprivate func notificateKeyboardposition() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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



extension AuthViewController {
    
    //TODO: Keyboard BUG!!!
    
    @objc func keyboardWillShow(notification: NSNotification) {
        print("keyboard will show")
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            print("keyboaedSize = \(keyboardSize), heigh = ", keyboardSize.height)
            print("view.frame.origin = ", view.frame.origin)
            //print("view.frame.origin.y = \(view.frame.origin.y), viewOriginYPosirion = \(viewOriginYPosition)")
            if self.view.frame.origin.y < 90 {
                switch UIDevice().type {
                case .iPhoneSE, .iPhone5, .iPhone5S:
                    self.view.frame.origin.y -= keyboardSize.height - 135
                case .iPhone6, .iPhone7, .iPhone8, .iPhone6S:
                    self.view.frame.origin.y -= keyboardSize.height - 155
                case .iPhone6Plus, .iPhone6SPlus, .iPhone7Plus, .iPhone8Plus:
                    self.view.frame.origin.y -= keyboardSize.height - 110
                default:
                    self.view.frame.origin.y -= keyboardSize.height - 175
                }
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        print("keyboard will hide")
        switch UIDevice().type {
        case .iPhoneSE, .iPhone5, .iPhone5S, .iPhone6, .iPhone7, .iPhone8, .iPhone6S, .iPhone6Plus, .iPhone6SPlus, .iPhone7Plus, .iPhone8Plus:
            self.view.frame.origin.y = 64
        default:
            self.view.frame.origin.y = 88
        }
        
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
}



