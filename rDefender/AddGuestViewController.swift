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
    
    //Text fields
    @IBOutlet weak var guestNameTextField: UITextField!
    @IBOutlet weak var carModelTextField: UITextField!
    @IBOutlet weak var carNumberTextField: UITextField!
    
    
    //Activity Indicator
    @IBOutlet weak var activityIndicatorContainerView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("**INIT: ", String(describing: self.description))
        carModelTextField.delegate = self
        
        setupUI()
        
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
    
    
    private func setupUI() {
        
        //Activiti Indicator
        activityIndicatorContainerView.isHidden = true
        activityIndicatorContainerView.layer.cornerRadius = 8
        activityIndicatorContainerView.clipsToBounds = true
        activityIndicator.hidesWhenStopped = true
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
    
    
    //MARK: Actions
    
    @IBAction func createPassButtonPressed(_ sender: UIButton) {
        startActivityIndicator()
        //TODO: Save informaton to DataBase from text fields
        //TODO: Show process indictor
        //TODO: If success - back to main screen
        //TODO: If error - show alert
        
        let name = guestNameTextField.text ?? ""
        let carModel = carModelTextField.text ?? ""
        let carNumber = carNumberTextField.text ?? ""
        let typeOfGuest = getTypeOfGuest(name: name, carModel: carModel, carNumber: carNumber)
        
        
        let guest = Guest(id: "", name: name, carModel: carModel, carNumber: carNumber, date: Date(), typeOfGuest: typeOfGuest)
        
        DBManager.shared.seveGuest(guest: guest) { (result, error) in
            
            guard let result = result, error == nil else {
                
                //TODO: Show alert
                return
            }
            self.stopActivityIndicator()
            self.navigationController?.popToRootViewController(animated: true)
        }
 
    }
    
    private func getTypeOfGuest(name: String, carModel: String, carNumber: String) -> TypeOfGuest {
        if carModel == "", carNumber == "" {
            return .person
        } else {
            return .car
        }
    }
    
    
    private func getRandomIconFrom(array: [String]) -> String {
        return array[Int.random(in: 0..<array.count)]
    }
    
    
    //Activity Indicator Methods
    
    private func startActivityIndicator() {
        activityIndicatorContainerView.isHidden = false
        activityIndicator.startAnimating()
    }
    
    private func stopActivityIndicator() {
        activityIndicatorContainerView.isHidden = true
        activityIndicator.stopAnimating()
    }
    
    //Sugue Indentificator - "fromAddGuestVCtoCarListVC"
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "fromAddGuestVCtoCarListVC" {
            let vc = segue.destination as! CarListViewController
            vc.delegate = self
        }
    }
    
    
    deinit {
        print("**DEINIT: ", String(describing: self.description))
    }

}


//Hide keyboard
extension AddGuestViewController {
    
    //TODO: Keyboard BUG!!!
    
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

extension AddGuestViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        performSegue(withIdentifier: "fromAddGuestVCtoCarListVC", sender: self)
        return false
    }
    
}


extension AddGuestViewController: CarListViewControllerDelegate {
    func getCarModel(carModel: String) {
        carModelTextField.text = carModel
    }
}




