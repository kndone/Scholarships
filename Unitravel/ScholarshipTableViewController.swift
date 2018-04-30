//
//  ScholarshipTableViewController.swift
//  Unitravel
//
//  Created by Abraham Rubio on 5/26/17.
//  Copyright © 2017 UPQ. All rights reserved.
//

import UIKit
import SDWebImage
import MBProgressHUD
import Parse


class ScholarshipTableViewController: UITableViewController {

    var scholarship : [PFObject] = [PFObject]()
    var scholar : PFObject!
    var selectedScholar : Scholarship?
    
    var scholarships : [Scholarship]!
    
    @IBAction func logOut(_ sender: Any) {
        
        
        let alert = UIAlertController(title: "", message: "Are you sure you want to logout?", preferredStyle: UIAlertControllerStyle.alert)
        
        let correct = UIAlertAction(title: "YES", style: .default) { (_) in
            PFUser.logOut()
            self.navigationController?.present((self.storyboard?.instantiateInitialViewController())!, animated: true, completion: nil)
        
        }
        
        let okAction = UIAlertAction(title: "NO", style: UIAlertActionStyle.cancel, handler: nil)
        
       
        alert.addAction(correct)
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //self.getScholar()
        GetScholarships()
    }
    
    func GetScholarships(){
        scholarships = [Scholarship]()
        let loader = MBProgressHUD.showAdded(to: self.view, animated: true)
        loader.mode = .indeterminate
        loader.label.text = "Cargando becas"
        ScholarshipService.GetScholarships { (sholars) in
            self.scholarships = sholars
            self.tableView.reloadData()
            loader.hide(animated: true)
        }
        
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scholarships.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // let object = self.scholarship[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "scholarCell", for: indexPath)  as! ScholarTableViewCell
        
        let currentScholar = scholarships[indexPath.row]
        cell.lblNAme.text = currentScholar.name
        cell.lblCountry.text = currentScholar.country
        cell.lblInstitute.text = currentScholar.institution
        cell.imgInstitute.image = #imageLiteral(resourceName: "splash_back")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedScholar = scholarships[indexPath.row]
        performSegue(withIdentifier: "profileSegue", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "profileSegue"){
            
            let segueController  = segue.destination as! ProfileScholarViewController
            segueController.scholarship = selectedScholar
        }
    }
    
    func getScholar(){
        
        let loader = MBProgressHUD.showAdded(to: self.view, animated: true)
        loader.mode = MBProgressHUDMode.indeterminate
        loader.label.text = "Cargando"
        
        let query = PFQuery(className:"Scholarship")
        //query.order(byAscending: "name")
        query.includeKey("idUser")
        query.limit = 1000
        query.findObjectsInBackground { (objects:[PFObject]?, error:Error?) in
            if error == nil {
                loader.hide(animated: true)
                self.scholarship = objects!
                self.tableView.reloadData()
            }
        }
        
    }
}
