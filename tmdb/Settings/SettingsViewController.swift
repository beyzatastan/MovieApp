//
//  SettingsViewController.swift
//  tmdb
//
//  Created by beyza nur on 25.10.2023.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func logOutButton(_ sender: Any) {
        do {
            //kullanıcı cıksın
            try Auth.auth().signOut()
            let logoutVVc=storyboard?.instantiateViewController(withIdentifier: "giris") as! SigninViewController
            navigationController?.pushViewController(logoutVVc, animated: false)
        } catch {
            print("error")
        }
    }
    
   
    @IBAction func homeButton(_ sender: Any) {
        let homesVc=storyboard?.instantiateViewController(identifier: "MPC")  as! ViewController
        navigationController?.pushViewController(homesVc, animated: false)
   
       
    }
    
    @IBAction func favButton(_ sender: Any) {
        let favVc=storyboard?.instantiateViewController(identifier: "fav") as! FavViewController
        navigationController?.pushViewController(favVc, animated: false)
   
    }
    
}
