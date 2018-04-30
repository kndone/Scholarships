//
//  ChooseViewController.swift
//  Unitravel
//
//  Created by Abraham Rubio on 6/30/17.
//  Copyright © 2017 UPQ. All rights reserved.
//

import UIKit

class ChooseViewController: UIViewController {

    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var student: UISegmentedControl!
    
    var type = String()
    
    @IBAction func setTypeUser(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            self.type = "student"
        case 1:
            self.type = "school"
        default :
            self.type = "student"
        }
    }
    @IBAction func OnBackLogin(_ sender: Any) {
        self.present((self.storyboard?.instantiateInitialViewController()!)!, animated: true, completion: nil)
    }
    
    @IBAction func goSignUp(_ sender: Any) {
        self.performSegue(withIdentifier: self.type, sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "STUDENT"
        
        self.btnNext.layer.cornerRadius = 5
        
        self.student.layer.cornerRadius = 5
        
        if(self.student.selectedSegmentIndex == 0){
            self.type = "student"
            
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
