//
//  CreateAccountViewController.swift
//  bad-ink
//
//  Created by User on 3/6/18.
//  Copyright © 2018 bad-ink. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var firstNameTxtField: UITextField!
    @IBOutlet weak var lastNameTxtField: UITextField!
    @IBOutlet weak var usernameTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var confirmPasswordTxtField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "newBackground.png")!)
        firstNameTxtField.delegate = self
        lastNameTxtField.delegate = self
        usernameTxtField.delegate = self
        passwordTxtField.delegate = self
        confirmPasswordTxtField.delegate = self
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
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        firstNameTxtField.resignFirstResponder()
        lastNameTxtField.resignFirstResponder()
        usernameTxtField.resignFirstResponder()
        passwordTxtField.resignFirstResponder()
        confirmPasswordTxtField.resignFirstResponder()
        
        return true
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
