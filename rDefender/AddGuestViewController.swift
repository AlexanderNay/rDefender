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
    
    //Constraints
    //Rasskazovo Label
    @IBOutlet weak var rasskazovoLabelHighConstraint: NSLayoutConstraint!
    @IBOutlet weak var rasskazovoLabelWidthConstraint: NSLayoutConstraint!
    
    //Sign a Pass Label
    //@IBOutlet weak var signPassLabelTopConstraint: NSLayoutConstraint!
    
    //Guest Buttons Stack
    @IBOutlet weak var guestTextFieldsStackTopConstraint: NSLayoutConstraint!
    
    //Stack of Text Fields
    @IBOutlet weak var textFieldsStack: UIStackView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        notificateKeyboardposition()
        setConstraintsForSmallScreens()
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
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
 
    }
    
    //TODO: Cose keyboard when tap out of text field!
    //TODO: Move content up when keyboard appears, and down when keyboard disappears
    fileprivate func notificateKeyboardposition() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    fileprivate func setConstraintsForSmallScreens() {
        
        //TODO: I don't like it
        switch UIDevice().type {
        case .iPhoneSE, .iPhone5, .iPhone5S, .iPhone6, .iPhone7, .iPhone8, .iPhone6S:
            rasskazovoLabelHighConstraint.constant = 150/1.5
            rasskazovoLabelWidthConstraint.constant = 200/1.5
            //signPassLabelTopConstraint.constant = 16
            guestTextFieldsStackTopConstraint.constant = 16
            textFieldsStack.spacing = 8
        default: break
        }
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


//Hide keyboard
extension AddGuestViewController {
    
    @objc func keyboardWillShow(notification: NSNotification) {
        print("keyboard will show")
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            print("keyboaedSize = \(keyboardSize)")
            print("view.frame.origin = ", view.frame.origin)
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        print("keyboard will hide")
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}




