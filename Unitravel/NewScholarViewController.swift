//
//  NewScholarViewController.swift
//  Unitravel
//
//  Created by Abraham Rubio on 5/26/17.
//  Copyright © 2017 UPQ. All rights reserved.
//

import UIKit
import Parse
import MBProgressHUD
import DatePickerDialog

class NewScholarViewController: UIViewController {

     var initial : Date = Date()
     var end : Date = Date()
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtFinal: UITextField!
    @IBOutlet weak var txtInitial: UITextField!
    @IBAction func setEndInitial(_ sender: Any) {
        
        let currentDate = Date()
        var dateComponents = DateComponents()
        dateComponents.year = +100
        let after = Calendar.current.date(byAdding: dateComponents, to: currentDate)
        
        DatePickerDialog().show(title: "Select a Date", doneButtonTitle: "Accept", cancelButtonTitle: "Cancel", minimumDate: currentDate, maximumDate: after , datePickerMode: .date) { (date) in
            if let dt = date {
                self.end = dt
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: "en_US")
                dateFormatter.dateFormat = "MMM d, yyyy"
                
                let date = dateFormatter.string(from: dt)
                self.txtFinal.text = date
            }
        }
    }
    @IBOutlet weak var btnSave: UIButton!
    
    @IBAction func setInitialDate(_ sender: Any) {
        let currentDate = Date()
        var dateComponents = DateComponents()
        dateComponents.year = +100
        let after = Calendar.current.date(byAdding: dateComponents, to: currentDate)
        
        DatePickerDialog().show(title: "Select a Date", doneButtonTitle: "Acept", cancelButtonTitle: "Cancel", minimumDate: currentDate, maximumDate: after, datePickerMode: .date) { (date) in
            if let dt = date {
                self.initial = dt
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: "en_US")
                dateFormatter.dateFormat = "MMM d, yyyy"
                
                let date = dateFormatter.string(from: dt)
                self.txtInitial.text = date
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        btnSave.layer.cornerRadius = 10
        
        UINavigationBar.appearance().tintColor = UIColor.white
        
        UIApplication.shared.statusBarStyle = .lightContent
        // Do any additional setup after loading the view.
    }
    @IBAction func saveNewScholar(_ sender: Any) {
        self.newScholarship()
        }

    func newScholarship(){
        let loader = MBProgressHUD.showAdded(to: self.view, animated: true)
        loader.mode = MBProgressHUDMode.indeterminate
        loader.label.text = "Cargando"
        
        if(txtName.text! == "" || txtInitial.text! == "" || txtFinal.text! == ""){
            
            loader.hide(animated: true)
            let alert = UIAlertController(title: "Atention", message: "Fill all fields.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }else{
            let scholarship = PFObject(className:"Scholarship")
            scholarship["name"] = txtName.text!
            scholarship["idUser"] = PFUser.current()!
            scholarship["initDate"] = self.initial
            scholarship["endDate"] = self.end
            scholarship.saveInBackground { (success, error) in
                if(success){
                    let alert = UIAlertController(title: "Atention", message: "Saving scholarship succesfull.", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    loader.hide(animated: true)
                }else{
                    loader.hide(animated: true)
                    let alert = UIAlertController(title: "Atention", message: "Saving scholarship fail, Please try again.", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
  
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
