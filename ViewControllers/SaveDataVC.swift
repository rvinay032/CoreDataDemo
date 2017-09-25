//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by appinventiv on 20/09/17.
//  Copyright © 2017 appinventiv. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITextFieldDelegate {
    // Variable Dclaration....................
    
    var users: Users?
    var enterData = [String:String]()
    
    @IBAction func backBtnTap(_ sender: UIButton) {
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBOutlet weak var saveBtnOut: UIButton!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var contactNoTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var passwordErrorLabel: UILabel!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    // %%%%%%%%%%%%%%%%%%%%%%%% Save Button %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    var isDataValid : Bool {
        
        guard let email = self.emailTextField.text else {
            
            return false
        }
        guard let password = self.passwordTextField.text else {
            
            return false
        }
        guard let phone = self.contactNoTextField.text else {
            
            return false
        }
        
        if email.isEmpty {
            alertBox(title: "Error", message: "Email is empty")
            return false
        }else if !email.isValidEmail {
            alertBox(title: "Error", message: "Email is wrong")
            shakeBtn(emailTextField)
            return false
        }else if password.isEmpty {
            alertBox(title: "Error", message: "password is empty")
            return false
        }else if !password.isPwdLenth {
            alertBox(title: "Error", message: "password is wrong")
            shakeBtn(passwordTextField)
            return false
        }else if phone.isEmpty {
            alertBox(title: "Error", message: "phone is empty")
            return false
        }else if !phone.validate {
            alertBox(title: "Error", message: "phone number is wrong")
            shakeBtn(contactNoTextField)
            return false
        }
        return true
    }
    
    
    @IBAction func saveBtntap(_ sender: UIButton) {
        
        let temp = self.isDataValid
        if temp {
            
            enterData["email"] = emailTextField.text
            enterData["password"] = passwordTextField.text
            enterData["contactNo"] = contactNoTextField.text
            
            CoreDataManager.save(entityName: "Users", enterData: enterData)
            
            let alert = UIAlertController(title: "Yipee!!", message: "Data is saved..", preferredStyle: UIAlertControllerStyle.actionSheet)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler:
                {
                    action -> Void in
                    self.emailTextField.text = ""
                    self.passwordTextField.text = ""
                    self.contactNoTextField.text = ""
                    self.emailTextField.becomeFirstResponder()
            }
            ))
            
            self.present(alert, animated: true, completion: nil)
        }
        
        
        
    }
    
    ////////////View Methods %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.saveBtnOut.layer.cornerRadius =  self.saveBtnOut.frame.height/3
        self.saveBtnOut.clipsToBounds = true
        
        saveBtnOut.isEnabled = false
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        contactNoTextField.delegate = self
        errorLabel.isHidden = true
        passwordErrorLabel.isHidden = true
        
        if let s = users
        {
            emailTextField.text = s.email
            passwordTextField.text = s.password
            //dobTextField.text = s.dob
            contactNoTextField.text = s.contactNo
            
        }
        
        emailTextField.addTarget(self, action: #selector(textFieldDidEnd(textField:)), for: .editingDidEnd)
        passwordTextField.addTarget(self, action: #selector(textFieldDidEnd(textField:)), for: .editingDidEnd)
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
}

extension ViewController {    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.saveBtnOut.isEnabled = true
        
        return true
    }
    
    @objc func textFieldDidEnd(textField:UITextField) {
        
        if textField === self.emailTextField {
            
            if !(emailTextField.text?.isValidEmail)! {
                errorLabel.text = "Invalid email adress"
                print("email is wrong")
                errorLabel.isHidden = false
                shakeBtn(emailTextField)
                
            }
                
            else {
                errorLabel.isHidden = true
            }
        }
            
        else if textField === self.passwordTextField {
            
            if !(Validations.isPwdLenth(password: passwordTextField.text!)) {
                
                print("password lenght should be greater than 7")
                
                passwordErrorLabel.text = "password lenght should be greater than 7 "
                passwordErrorLabel.isHidden = false
                shakeBtn(passwordTextField)
            }
            else {
                passwordErrorLabel.isHidden = true
            }
            
        }
        
    }
    
    func alertBox (title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func shakeBtn(_ textField: UITextField) {
        textField.transform = CGAffineTransform(translationX: -5, y:0 )
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.0,
                       initialSpringVelocity: 6.0,
                       options: .curveLinear,
                       animations: {
                        
                        textField.transform = .identity
                        
        },completion: nil)
    }
    
}

