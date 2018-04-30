//
//  ProfileScholarViewController.swift
//  Unitravel
//
//  Created by Abraham Rubio on 5/26/17.
//  Copyright © 2017 UPQ. All rights reserved.
//

import UIKit
import Parse
import MBProgressHUD

class ProfileScholarViewController: UIViewController {

    var scholar : PFObject!
    var scholarship : Scholarship?
    
    @IBOutlet weak var imgInstitute: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblCountry: UILabel!
    
    @IBOutlet weak var lblExpireDate: UILabel!
    
    @IBOutlet weak var txtDesciption: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      SetupInfo()
        
        UINavigationBar.appearance().tintColor = UIColor.white
        
        UIApplication.shared.statusBarStyle = .lightContent

        // Do any additional setup after loading the view.
    }
    
    private func SetupInfo(){
        guard let cleanScholarship = scholarship else {
            print("Scholarship is nil")
            return
        }
        imgInstitute.image = #imageLiteral(resourceName: "splash_back")
        lblName.text = cleanScholarship.name
        lblCountry.text = cleanScholarship.country
        let formattedDate = DateFormatter()
        formattedDate.dateStyle = .long
        let stringDate = formattedDate.string(from: cleanScholarship.endDate!)
        lblExpireDate.text = "Expira el : " + stringDate
        txtDesciption.text = cleanScholarship.description
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
