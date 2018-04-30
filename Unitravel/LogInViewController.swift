//
//  LogInViewController.swift
//  Unitravel
//
//  Created by Abraham Rubio on 5/25/17.
//  Copyright © 2017 UPQ. All rights reserved.
//

import UIKit
import Parse
import MBProgressHUD

class LogInViewController: UIViewController {

    @IBOutlet weak var txtUser: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var btnLogIn: UIButton!
    
    @IBAction func logIn(_ sender: Any) {
        self.logIn()
    }
    
    @IBAction func forgetPassword(_ sender: Any) {
        self.popUpforget()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LogInViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        btnLogIn.layer.cornerRadius = 10
        
        UINavigationBar.appearance().tintColor = UIColor.white
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func logIn(){
        let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = NSLocalizedString("submitting", comment: "submitting")
        
        if isValidEmail(testStr: txtUser.text!){
            PFUser.logInWithUsername(inBackground: txtUser.text!, password: txtPassword.text!) { (user, error) -> Void in
                
                loadingNotification.hide(animated: true)
                if user != nil && error == nil {
                    guard let tipoUsuario = user?["rol"] as? String else{
                        self.createAlert(title: "Error de conexión", message: "Por favor revise su conexión de internet")
                        return
                    }
                    
                    if tipoUsuario == UserRol.INSTITUTION.rawValue {
                        self.performSegue(withIdentifier: "logInSegue", sender: self)
                    }else{
                        self.performSegue(withIdentifier: "loginStudent", sender: self)
                    }
                    
                }else {
                    
                    self.createAlert(title: "", message: "Usuario no existe o contraseña incorrecta.")
                }
            }
        }else{
            loadingNotification.hide(animated: true)
            createAlert(title: "Atención", message: "Ingrese un correo electrónico válido para continuar.")
        }
    }
    
    func createAlert(title: String, message: String) {
        
        let alertC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            
        }
        alertC.addAction(OKAction)
        
        self.present(alertC, animated: true) { () -> Void in
            
        }
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@"
            + "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    func popUpforget(){
        let alertController = UIAlertController(title: "Welcome", message: "Enter an Email", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "OK", style: .default) { (_) in
            if let field = alertController.textFields![0] as? UITextField {
                // store your data
                UserDefaults.standard.set(field.text, forKey: "userEmail")
                UserDefaults.standard.synchronize()
                
                if(field.text != ""){
                    if(self.isValidEmail(testStr: field.text!)){
                        self.forget()
                        
                    }else{
                        let alert = UIAlertController(title: "Error", message: "Invalid Email.", preferredStyle: UIAlertControllerStyle.alert)
                        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
                        alert.addAction(okAction)
                        self.present(alert, animated: true, completion: nil)
                    }
                }else {
                    let alert = UIAlertController(title: "Error", message: "Write your email.", preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                }
                
                
            } else {
                let alert = UIAlertController(title: "Error", message: "Write your email.", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            //alertController.dismiss(animated: <#T##Bool#>, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "email"
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    func forget()  {
        if isValidEmail(testStr: txtUser.text!) {
            
            let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
            loadingNotification.mode = MBProgressHUDMode.indeterminate
            loadingNotification.label.text = "Loading"
            
            let userEmail = txtUser.text!
            PFUser.requestPasswordResetForEmail(inBackground: userEmail, block: { (succeded, error) -> Void in
                
                loadingNotification.hide(animated:true)
                if succeded && error == nil {
                    self.createAlert(title: "Hey", message: "Email sent, check your email.")
                    
                } else {
                    self.createAlert(title: "Error", message: "User with that email not registed.")
                }
                
            })
        }else {
            createAlert(title: "Error", message: "Enter a valid email.")
        }
    }

}
