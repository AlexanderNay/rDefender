//
//  AddGuestViewController.swift
//  rDefender
//
//  Created by AlexanderN on 23/08/2019.
//  Copyright © 2019 AlexanderN. All rights reserved.
//

import UIKit

enum GuestType: Int {
    case person
    case car
    case truck
}

class AddGuestViewController: UIViewController {
    
    var guestType: GuestType!

    override func viewDidLoad() {
        super.viewDidLoad()
        //
        guard let guestType = guestType else { return }
        switch guestType {
        case .person:
            print("person")
        case .car:
            print("car")
        case .truck:
            print("truck")
        }

        // Do any additional setup after loading the view.
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
