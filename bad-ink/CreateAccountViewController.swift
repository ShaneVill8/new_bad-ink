//
//  CreateAccountViewController.swift
//  bad-ink
//
//  Created by User on 3/6/18.
//  Copyright © 2018 bad-ink. All rights reserved.
//

import UIKit
import Firebase

class CreateAccountViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var verifypwLabel: UILabel!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var accountCreateLabel: UILabel!
    @IBOutlet weak var BlankLabel: UILabel!
    @IBOutlet weak var UsernameNotAvailable: UILabel!
    @IBOutlet weak var firstNameTxtField: UITextField!
    @IBOutlet weak var lastNameTxtField: UITextField!
    @IBOutlet weak var usernameTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var confirmPasswordTxtField: UITextField!
    var ref : DatabaseReference?
    var key : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UsernameNotAvailable.isHidden = true
        BlankLabel.isHidden = true
        accountCreateLabel.isHidden = true
        verifypwLabel.isHidden = true
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "newBackground.png")!)
        firstNameTxtField.delegate = self
        lastNameTxtField.delegate = self
        usernameTxtField.delegate = self
        passwordTxtField.delegate = self
        confirmPasswordTxtField.delegate = self
        emailTxtField.delegate = self
        
        ref = Database.database().reference().child("users");
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        firstNameTxtField.resignFirstResponder()
        lastNameTxtField.resignFirstResponder()
        usernameTxtField.resignFirstResponder()
        passwordTxtField.resignFirstResponder()
        confirmPasswordTxtField.resignFirstResponder()
        emailTxtField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        firstNameTxtField.resignFirstResponder()
        lastNameTxtField.resignFirstResponder()
        usernameTxtField.resignFirstResponder()
        passwordTxtField.resignFirstResponder()
        confirmPasswordTxtField.resignFirstResponder()
        emailTxtField.resignFirstResponder()
        
        return true
    }
    
    @IBAction func CreateAccountButton(_ sender: Any) {
        if usernameTxtField.text != "" && firstNameTxtField.text != "" && lastNameTxtField.text != "" && passwordTxtField.text != "" && confirmPasswordTxtField.text != "" && emailTxtField.text != "" {
            addUser()
        }
        else{
            self.BlankLabel.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                self.BlankLabel.isHidden = true
            }
        }
    }

    func addUser() {
        ref = Database.database().reference().child("users")
        if confirmPasswordTxtField.text == passwordTxtField.text{
            ref?.child(usernameTxtField.text!).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let value = snapshot.value as? NSDictionary
                let username = value?["username"] as? String ?? ""
                let textfield = String(self.usernameTxtField.text!)
                
                if username == textfield{
                    self.UsernameNotAvailable.isHidden = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                        self.UsernameNotAvailable.isHidden = true
                    }
                }
                else{
                    let user = ["username": self.usernameTxtField.text,
                                "first name": self.firstNameTxtField.text,
                                "last name": self.lastNameTxtField.text,
                                "password": self.passwordTxtField.text,
                                "email": self.emailTxtField.text, ]
                    
                    self.ref?.child(self.usernameTxtField.text!).setValue(user)
                    
                    self.accountCreateLabel.isHidden = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                        self.accountCreateLabel.isHidden = true
                    }
                    self.usernameTxtField.text = ""
                    self.firstNameTxtField.text = ""
                    self.lastNameTxtField.text = ""
                    self.passwordTxtField.text = ""
                    self.confirmPasswordTxtField.text = ""
                    self.emailTxtField.text = ""
                }
            })
        }else{
            self.verifypwLabel.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                self.verifypwLabel.isHidden = true
            }
            self.passwordTxtField.text = ""
            self.confirmPasswordTxtField.text = ""
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
