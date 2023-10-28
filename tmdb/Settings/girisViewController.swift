//
//  girisViewController.swift
//  tmdb
//
//  Created by beyza nur on 25.10.2023.
//

import UIKit
import Firebase
import  FirebaseAuth

class girisViewController: UIViewController {
    
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        if emailText.text != " " && passwordText.text != " "{
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { authData, error in
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
        if emailText.text != "" && passwordText.text != ""{
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { authData, error in
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
    
   


