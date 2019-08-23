//
//  ViewController.swift
//  rDefender
//
//  Created by AlexanderN on 20/08/2019.
//  Copyright © 2019 AlexanderN. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    
    @IBOutlet var guestButton: UIButton!
    @IBOutlet var carButton: UIButton!
    @IBOutlet var truckButton: UIButton!
    
    @IBOutlet var listOfGuestButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    func setupUI() {
        //Set background colors
        guestButton.setGradientBackground(colorTop: UIColor.lightBrown, colorBottom: UIColor.darkBrown)
        carButton.setGradientBackground(colorTop: UIColor.lightBrown, colorBottom: UIColor.darkBrown)
        truckButton.setGradientBackground(colorTop: UIColor.lightBrown, colorBottom: UIColor.darkBrown)
        
        listOfGuestButton.setGradientBackground(colorTop: UIColor.lightGreen, colorBottom: UIColor.darkGreen)
        
        //Set corner radius
        guestButton.layer.cornerRadius = 8
        guestButton.layer.masksToBounds = true
        
        carButton.layer.cornerRadius = 8
        carButton.layer.masksToBounds = true
        
        truckButton.layer.cornerRadius = 8
        truckButton.layer.masksToBounds = true
        
        listOfGuestButton.layer.cornerRadius = 8
        listOfGuestButton.layer.masksToBounds = true
    }


}

