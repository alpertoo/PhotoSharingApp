//
//  ViewController.swift
//  PhotoSharingApp
//
//  Created by Alper Koçer on 28.12.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginTapped(_ sender: Any) {
    }
    
    @IBAction func signinTapped(_ sender: Any) {
        if emailTextField.text != "" && passwordTextField.text != "" {
            // Sign in the user
        }else{
            errorMessage(titleInput: "Error!", messageInput:"E-mail or Password can't be empty")
        }
    }
    
    func errorMessage(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
}

