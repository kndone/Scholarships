//
//  HomeStudentViewController.swift
//  Unitravel
//
//  Created by Misael Garay on 09/11/17.
//  Copyright © 2017 UPQ. All rights reserved.
//

import UIKit
import Parse
import MBProgressHUD

class HomeStudentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var studentId: UILabel!
    @IBOutlet weak var becasTable: UITableView!
    
    @IBOutlet weak var sideMenuConstraint: NSLayoutConstraint!
    private var isMenuVisible : Bool!
    
    private var scholarships : [Scholarship]!
    
    private var findBar : UIView = {
       let view = UIView()
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = 50
        SetupSidemenu()
        SetupUserInfo()
        self.scholarships = [Scholarship]()
        let loader = MBProgressHUD.showAdded(to: self.view, animated: true)
        loader.mode = .indeterminate
        loader.label.text = "Cargando becas"
        ScholarshipService.GetScholarships { (scholars) in
            self.scholarships = scholars
            self.becasTable.reloadData()
            loader.hide(animated: true)
        }
    }
    @IBAction func OnLogOut(_ sender: Any) {
        logout()
    }
    @IBAction func OnLogoutIcon(_ sender: Any) {
        logout()
    }
    @IBAction func OnShowProfile(_ sender: Any) {
        OnActiveMenu()
    }
    
    @IBAction func OnShowProfileIcon(_ sender: Any) {
        OnActiveMenu()
    }
    
    private func logout(){
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
    
    func SetupUserInfo(){
        let currentUser = PFUser.current()
        guard let firstName = currentUser?["firstName"] as? String, let lastName = currentUser?["lastName"] as? String, let id = currentUser?["idStudent"] as? String, let pfImage = currentUser?["image"] as? PFFile else {
            print("no current session innitialized")
            return
        }
        username.text = firstName + " " + lastName
        studentId.text = id
        pfImage.getDataInBackground { (data, error) in
            if error != nil {
                print("no image gotten")
                return
            }
            self.profileImage.image = UIImage(data: data!)
        }
    }
    
    func SetupSidemenu(){
        sideMenuConstraint.constant = -240
        isMenuVisible = false
        let sideBtn = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(OnActiveMenu))
        let sideMenu = UIBarButtonItem(image: #imageLiteral(resourceName: "menuBtn"), style: .plain, target: self, action: #selector(OnActiveMenu))
        self.navigationItem.leftBarButtonItem = sideMenu
    }
    
    func OnActiveMenu(){
        var fixedConstrain : CGFloat = 0
        if isMenuVisible {
            fixedConstrain = -240
        }else{
            fixedConstrain = 0
        }
        isMenuVisible = !isMenuVisible
        sideMenuConstraint.constant = fixedConstrain
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scholarships.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StudentHomeCell
        let currentScholarship = scholarships[indexPath.row]
        cell.scholarName.text = currentScholarship.name
        cell.scholarCountry.text = currentScholarship.country
        cell.sholarInstitution.text = currentScholarship.institution
        return cell
    }
}
