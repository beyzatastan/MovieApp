//
//  SigninViewController.swift
//  tmdb
//
//  Created by beyza nur on 26.10.2023.
//

import UIKit
import Firebase

class SigninViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentUser=Auth.auth().currentUser
          
          if currentUser != nil{
              let baslangic = storyboard?.instantiateViewController(identifier: "MPC") as! ViewController// "AnaSayfaViewController" burada sizin ana sayfa ekranınızın kimliği olmalı
              navigationController?.pushViewController(baslangic, animated: false)
          }
        
    }
    
    @IBAction func signupButton(_ sender: Any) {
        if emailTextField.text != " " && passwordTextField.text != " "{
                    Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { authData, error in
                        if error != nil{
                            self.makeAlert(title: "Error", message: error!.localizedDescription)
                        }else{
                            let girisVc=self.storyboard?.instantiateViewController(withIdentifier: "MPC") as! ViewController
                            self.navigationController?.pushViewController(girisVc, animated: false)
                        }
                    }
                }  else{
                    makeAlert(title: "Error", message: "Username/Password")
                }
    }
    
    @IBAction func signinButton(_ sender: Any) {
        if emailTextField.text != "" && passwordTextField.text != ""{
                    Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { authData, error in
                        if error != nil {
                            self.makeAlert(title: "Error", message: error!.localizedDescription)
                        }else{
                            let girissVc=self.storyboard?.instantiateViewController(withIdentifier: "MPC") as! ViewController
                            self.navigationController?.pushViewController(girissVc, animated: false)
                        }
                    }
                }else{
                    self.makeAlert(title: "Error", message: "username/password error" )
                }
    }
    
    func makeAlert(title:String,message:String){
           let alert=UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
           let okButton=UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
           alert.addAction(okButton)
           self.present(alert,animated: true,completion: nil)
           
       }
    
}
