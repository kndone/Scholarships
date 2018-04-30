//
//  SignUpViewController.swift
//  Unitravel
//
//  Created by Abraham Rubio on 5/25/17.
//  Copyright © 2017 UPQ. All rights reserved.
//

import UIKit
import Parse
import MBProgressHUD
import Fusuma

class SignUpViewController: UIViewController, FusumaDelegate, UITextFieldDelegate{

    @IBOutlet weak var profilePhoto: UIImageView!
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPasword: UITextField!
    
    @IBOutlet weak var txtCountry: UITextField!
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var btnSignUp: UIButton!
    
    var imagePath: String = ""
    
    var photo = false

    
    @IBAction func signUp(_ sender: Any) {
        signUp()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        fusumaTintColor = UIColor(red:0.25, green:0.32, blue:0.71, alpha:1.0)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.snapShot(_sender:)))
        
        self.profilePhoto.isUserInteractionEnabled = true
        self.profilePhoto.addGestureRecognizer(tapGesture)
        
        btnSignUp.layer.cornerRadius = 10
        
        self.profilePhoto.layer.cornerRadius = self.profilePhoto.frame.size.width / 2;
        self.profilePhoto.clipsToBounds = true;
        
        
        UINavigationBar.appearance().tintColor = UIColor.white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func snapShot(_sender: UITapGestureRecognizer){
        
        let loader = MBProgressHUD.showAdded(to: self.view, animated: true)
        loader.mode = MBProgressHUDMode.indeterminate
        loader.label.text = "Cargando"
        
        let fusuma = FusumaViewController()
        fusuma.delegate = self
        self.present(fusuma, animated: true, completion: nil)
        
        loader.hide(animated: true)
        
    }
    
    func fusumaImageSelected(_ image: UIImage, source: FusumaMode) {
        switch source {
        case .camera:
            print("Image captured from Camera")
        case .library:
            print("Image selected from Camera Roll")
        default:
            print("Image selected")
        }
        
        self.profilePhoto.image = image
        self.profilePhoto.layer.cornerRadius = self.profilePhoto.frame.size.width / 2;
        self.profilePhoto.clipsToBounds = true;
        self.photo = true
    }
    
    func fusumaVideoCompleted(withFileURL fileURL: URL) {
        print("video completed and output to file: \(fileURL)")
    }
    
    func fusumaDismissedWithImage(_ image: UIImage, source: FusumaMode) {
        switch source {
        case .camera:
            print("Called just after dismissed FusumaViewController using Camera")
        case .library:
            print("Called just after dismissed FusumaViewController using Camera Roll")
        default:
            print("Called just after dismissed FusumaViewController")
        }
        self.profilePhoto.image = image
        self.profilePhoto.layer.cornerRadius = self.profilePhoto.frame.size.width / 2;
        self.profilePhoto.clipsToBounds = true;
        
        self.photo = true
    }
    
    func fusumaCameraRollUnauthorized() {
        print("Camera roll unauthorized")
    }
    
    func fusumaClosed() {
        
        print("Called when the close button is pressed")
    }
    
    func dismissKeyboard(){
        
        view.endEditing(true)
    }
    
    func isValidEmail(testStr:String) -> Bool {
        /*let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"*/
        let emailRegEx = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@"
            + "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return emailTest.evaluate(with: testStr)
    }
    
    func loadImage(urlString:String)
    {
        
        let imgURL: NSURL = NSURL(string: urlString)!
        let request: NSURLRequest = NSURLRequest(url: imgURL as URL)
        
        NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main) { (response,data,error) in
            if error == nil {
                self.profilePhoto.image = UIImage(data: data!)
            }
        }
    }
    
    func signUp(){
        let loader = MBProgressHUD.showAdded(to: self.view, animated: true)
        loader.mode = MBProgressHUDMode.indeterminate
        loader.label.text = "Cargando"
        
        
        let nameStr = txtName.text
        let emailStr = txtEmail.text
        let passwordStr = txtPasword.text
        let phone = txtPhone.text
        let country = txtCountry.text
        
        
        if(!photo){
            loader.hide(animated: true)
            let alert = UIAlertController(title: "Error", message: "Seleccione una foto para registrarse.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            if(nameStr == "" || emailStr == "" || passwordStr == ""
                || country  == "" || phone == ""){
                
                loader.hide(animated: true)
                let alert = UIAlertController(title: "Error", message: "Llene todos los campos.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }else{
                if !isValidEmail(testStr: emailStr!){
                    loader.hide(animated: true)
                    let alert = UIAlertController(title: "Error", message: "Formato de correo inválido.", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                }else{
                        
                        loader.hide(animated: true)
                        let alert = UIAlertController(title: "Error", message: "Las contraseñas no coinciden.", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        let user = PFUser()
                        user.username = emailStr?.lowercased()
                        user.password = passwordStr
                        user.email = emailStr?.lowercased()
                        user.setValue(nameStr!, forKey: "institutionName")
                        user.setValue(phone, forKey: "telephone")
                        user.setValue("Institution", forKey: "rol")
                        user.setValue(country, forKey: "country")
                        
                        if photo{
                            let imageFile = PFFile(name: "photo.png", data: UIImageJPEGRepresentation(self.profilePhoto.image!, 0.4)!)
                            user.setValue(imageFile, forKey: "image")
                        }
                        user.signUpInBackground(block: { (success, error) -> Void in
                            loader.hide(animated: true)
                            
                            print("\(success)")
                            if (success){
                                
                                print("Email \(String(describing: PFUser.current()?.email))")
                                let currentInstallation = PFInstallation.current()
                                currentInstallation!.addUniqueObject("user_"+user.objectId!, forKey: "channels")
                                currentInstallation!.saveInBackground()
                                
                                self.performSegue(withIdentifier: "signUpSegue", sender: self)
                                
                                /*let signUp = (self.storyboard?.instantiateViewController(withIdentifier: "album"))! as  UIViewController
                                self.present(signUp, animated: true, completion: nil)*/
                            }
                            else{
                                let alert = UIAlertController(title: "Error", message: "Error al registrarse, \(error.debugDescription) intente mas tarde \(String(describing: error?.localizedDescription))", preferredStyle: UIAlertControllerStyle.alert)
                                
                                let okAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default, handler: nil)
                                alert.addAction(okAction)
                                self.present(alert, animated: true, completion: nil)
                            }
                        })
                }
            }
        }
    }
}

