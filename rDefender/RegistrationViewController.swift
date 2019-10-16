//
//  RegistrationViewController.swift
//  rDefender
//
//  Created by AlexanderN on 02/09/2019.
//  Copyright © 2019 AlexanderN. All rights reserved.
//

import UIKit


class RegistrationViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("**INIT: ", String(describing: self.description))
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func confirmRegistrarionButtonPressed(_ sender: UIButton) {
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
    

    
    private func showTheMainScreen() {
        navigationController?.popToRootViewController(animated: true)
    }


    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    deinit {
        print("**DEINIT: ", String(describing: self.description))
    }
    
}
