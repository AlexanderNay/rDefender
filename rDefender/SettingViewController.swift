//
//  SettingViewController.swift
//  rDefender
//
//  Created by AlexanderN on 03/09/2019.
//  Copyright © 2019 AlexanderN. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    
    @IBOutlet weak var houseNumber: UILabel!
    @IBOutlet weak var apartmentNumber: UILabel!
    
    @IBOutlet weak var accountEmail: UILabel!
    @IBOutlet weak var signOutAccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("**INIT: ", String(describing: self.description))

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    private func setupUI() {
        let userEmail = DBManager.shared.getCurrentUser()?.email ?? "error"
        accountEmail.text = "e-mail: \(userEmail)"
        houseNumber.text = "13"
        apartmentNumber.text = "313"
    }
    
    
    
    @IBAction func signOutAccountButtonPressed(_ sender: UIButton) {
            navigationController?.popToRootViewController(animated: false)
        
        AuthManager.shared.signOut()

//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "startVC")
//        guard let startVC = vc else { return }
//        self.present(startVC, animated: true) {
//            self.navigationController?.viewControllers = []
//        }
    }
    
    
    deinit {
        print("**DEINIT: ", String(describing: self.description))
    }
}


