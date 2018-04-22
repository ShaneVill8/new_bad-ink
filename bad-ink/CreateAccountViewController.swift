//
//  CreateAccountViewController.swift
//  bad-ink
//
//  Created by User on 3/6/18.
//  Copyright © 2018 bad-ink. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications

class CreateAccountViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var firstNameTxtField: UITextField!
    @IBOutlet weak var lastNameTxtField: UITextField!
    @IBOutlet weak var usernameTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var confirmPasswordTxtField: UITextField!
    var ref : DatabaseReference?
    var key : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
            if error != nil{
                print("Account was not created")
            }else{
                print("Account created")
            }
        }
        
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
            blankLabel(inSeconds: 0.1) { (success) in
                if success{
                    print("Successfully Notified")
                }
            }
        }
    }
    
    func timedNotifications(inSeconds: TimeInterval, completion: @escaping (_ Seccess: Bool
        ) -> ()){
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        let content = UNMutableNotificationContent()
        content.title = "Your account has been created!"
        let request = UNNotificationRequest(identifier: "customNotification", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request){(error) in
            if error != nil{
                completion(false)
            }
            else{
                completion(true)
            }
        }
    }
    
    func blankLabel(inSeconds: TimeInterval, completion: @escaping (_ Seccess: Bool
        ) -> ()){
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        let content = UNMutableNotificationContent()
        content.title = "Blank Textfield"
        content.subtitle = "Please fill in all textfields"
        let request = UNNotificationRequest(identifier: "customNotification", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request){(error) in
            if error != nil{
                completion(false)
            }
            else{
                completion(true)
            }
        }
    }
    
    func verifypw(inSeconds: TimeInterval, completion: @escaping (_ Seccess: Bool
        ) -> ()){
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        let content = UNMutableNotificationContent()
        content.title = "Passwords do not match"
        content.subtitle = "Please confirm your password"
        let request = UNNotificationRequest(identifier: "customNotification", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request){(error) in
            if error != nil{
                completion(false)
            }
            else{
                completion(true)
            }
        }
    }
    
    func usernameNotAvailable(inSeconds: TimeInterval, completion: @escaping (_ Seccess: Bool
        ) -> ()){
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        let content = UNMutableNotificationContent()
        content.title = "Username not Available"
        content.subtitle = "Please choose a different username"
        let request = UNNotificationRequest(identifier: "customNotification", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request){(error) in
            if error != nil{
                completion(false)
            }
            else{
                completion(true)
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
                    self.usernameNotAvailable(inSeconds: 0.1) { (success) in
                        if success{
                            print("Successfully Notified")
                        }
                    }
                }
                else{
                    let user = ["username": self.usernameTxtField.text,
                                "first name": self.firstNameTxtField.text,
                                "last name": self.lastNameTxtField.text,
                                "password": self.passwordTxtField.text,
                                "email": self.emailTxtField.text, ]
                    
                    self.ref?.child(self.usernameTxtField.text!).setValue(user)
                    
                    self.timedNotifications(inSeconds: 0.1) { (success) in
                        if success{
                            print("Successfully Notified")
                        }
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
            self.verifypw(inSeconds: 0.1) { (success) in
                if success{
                    print("Successfully Notified")
                }
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

