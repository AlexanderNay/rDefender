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
    
    var viewOriginYPosition: CGFloat = 0
    
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
        viewOriginYPosition = view.frame.origin.y
        print("viewOriginPosition = ", viewOriginYPosition)
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
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            print("keyboaedSize = \(keyboardSize), heigh = ", keyboardSize.height)
            print("view.frame.origin = ", view.frame.origin)
            print("view.frame.origin.y = \(view.frame.origin.y), viewOriginYPosirion = \(viewOriginYPosition)")
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




