//
//  SettingsViewController.swift
//  PhotoSharingApp
//
//  Created by Alper Koçer on 30.12.2022.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    

    @IBAction func logoutTapped(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toViewController", sender: nil)
        }catch{
            print("Error while signing out!")
        }
    }
    

}
