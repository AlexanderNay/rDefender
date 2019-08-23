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
    
    
    //Properties
    
    var guestType: GuestType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        setNavigationBar()
        
    }
    
    
    func setNavigationBar() {
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = UIColor.mainBackground
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = false
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
    
    
    @IBAction func guestButtonPressed(_ sender: UIButton) {
        if sender.tag == 1 {
            guestType = .person
        }
        if sender.tag == 2 {
            guestType = .car
        }
        if sender.tag == 3 {
            guestType = .truck
        }
        
        performSegue(withIdentifier: "guest", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? AddGuestViewController {
            vc.guestType = guestType
        }
    }


}

