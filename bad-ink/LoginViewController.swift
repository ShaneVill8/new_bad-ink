//
//  LoginViewController.swift
//  bad-ink
//
//  Created by User on 3/5/18.
//  Copyright © 2018 bad-ink. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {
   
    @IBOutlet weak var InvalidLabel: UILabel!
    @IBOutlet weak var usernameTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var BlankLabel: UILabel!
    var ref : DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BlankLabel.isHidden = true
        InvalidLabel.isHidden = true
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "newBackground.png")!)
        usernameTxtField.delegate = self
        passwordTxtField.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        usernameTxtField.resignFirstResponder()
        passwordTxtField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameTxtField.resignFirstResponder()
        passwordTxtField.resignFirstResponder()
       
        return true
    }
    
    @IBAction func loginButton(_ sender: Any) {
        if usernameTxtField.text != "" && passwordTxtField.text != "" {
            login()
        }
        else{
            self.BlankLabel.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                self.BlankLabel.isHidden = true
            }
        }
    }

    func login() {
        ref = Database.database().reference().child("users")
        
        ref?.child(usernameTxtField.text!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let password = value?["password"] as? String ?? ""
            let textfield = String(self.passwordTxtField.text!)
            
            if password == textfield{
                print("here") ///segue back to home
            }
            else{
                self.InvalidLabel.isHidden = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                    self.InvalidLabel.isHidden = true
                }
                self.usernameTxtField.text = ""
                self.passwordTxtField.text = ""
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
        
        //DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
        //    self.UsernameNotAvailable.isHidden = false
        //}
        
        //DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
        //    self.UsernameNotAvailable.isHidden = true
        //}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
