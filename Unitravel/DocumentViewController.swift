//
//  DocumentViewController.swift
//  Unitravel
//
//  Created by Abraham Rubio on 5/29/17.
//  Copyright © 2017 UPQ. All rights reserved.
//

import UIKit
import Parse
import SDWebImage
import MBProgressHUD
import SafariServices

class DocumentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SFSafariViewControllerDelegate {
    
    var doc : PFObject!
    var student : PFObject!
    var docs: [PFObject] = [PFObject]()

    @IBOutlet weak var imgStudent: UIImageView!
    
    @IBOutlet weak var archives: UITableView!
    @IBOutlet weak var lblName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "DOCUMENTS"

        if let name = self.student.value(forKey: "name") as? String{
            self.lblName.text = name
        }
        
        
        if let imageFile = self.student.object(forKey: "image") as? PFFile{
            if imageFile.url != nil{
                if let urlString = imageFile.url as? String?{
                    let urlNsstring = NSString(string: urlString!)
                    let urlEscapedString = urlNsstring.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
                    let urlFinal = URL(string: urlEscapedString!)
                    self.imgStudent.sd_setImage(with: urlFinal)
                    self.imgStudent.clipsToBounds = true
                    self.imgStudent.layer.cornerRadius = self.imgStudent.frame.size.width / 2
                    
                    self.imgStudent.layer.borderColor = UIColor.white.cgColor
                    
                    self.imgStudent.layer.borderWidth = 2
                    
                }
            }
        }
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
         self.getDocuments()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return docs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let docu = docs[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "docCell", for: indexPath)  as! DocumentTableViewCell
        
        if let name = docu.value(forKey: "name") as? String{
            cell.lblName.text = name
        }
      
        if let status = docu.value(forKey: "status") as? Bool{
            if(status){
                cell.imgStatus.image = UIImage(named: "verde")
            }else{
                cell.imgStatus.image = UIImage(named: "rojo")
            }
        }
        return cell
    }
    
    func getDocuments(){
        
        let loader = MBProgressHUD.showAdded(to: self.view, animated: true)
        loader.mode = MBProgressHUDMode.indeterminate
        loader.label.text = "Cargando"
        
        let query = PFQuery(className:"Document")
        query.limit = 1000
        query.findObjectsInBackground { (objects:[PFObject]?, error:Error?) in
            if error == nil {
                loader.hide(animated: true)
                self.docs = objects!
                self.archives.reloadData()
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let docu = self.docs[indexPath.row]
        
        let alert = UIAlertController(title: "Hey!", message: "Is this the right document?", preferredStyle: UIAlertControllerStyle.alert)
        
        
        let review = UIAlertAction(title: "REVIEW", style: .default) { (_) in
            
            if let pdfPrivacyPolicy = docu.object(forKey: "paper") as? PFFile{
                
                let urlPrivacyPolicy: String = pdfPrivacyPolicy.url!
                
                let requestUrl = NSURL(string: urlPrivacyPolicy)!
                let sfc = SFSafariViewController(url: requestUrl as URL)
                sfc.delegate = self
                self.present(sfc, animated: true, completion: nil)
            }
        }
        
        let wrong = UIAlertAction(title: "IT'S WRONG", style: .default) { (_) in
            
            docu.setValue(false, forKey: "status")
            docu.saveInBackground()
            
            self.getDocuments()
        }
        
        let correct = UIAlertAction(title: "IT'S CORRECT", style: .default) { (_) in
            docu.setValue(true, forKey: "status")
            docu.saveInBackground()
            
            self.getDocuments()
        }
        
        let okAction = UIAlertAction(title: "CANCEL", style: UIAlertActionStyle.cancel, handler: nil)
        
        alert.addAction(review)
        alert.addAction(wrong)
        alert.addAction(correct)
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
