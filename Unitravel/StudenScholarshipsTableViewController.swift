//
//  StudenScholarshipsTableViewController.swift
//  Unitravel
//
//  Created by Misael Garay on 14/11/17.
//  Copyright © 2017 UPQ. All rights reserved.
//

import UIKit
import MBProgressHUD

class StudenScholarshipsTableViewController: UITableViewController {
    
    var scholarships : [Scholarship]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadData()
    }
    
    private func LoadData(){
        scholarships = [Scholarship]()
        
        let progress = MBProgressHUD.showAdded(to: self.view, animated: true)
        progress.mode = .indeterminate
        progress.label.text = "Cargando Becas"
        
        ScholarshipService.GetScholarships { (scholars) in
            self.scholarships = scholars
            self.tableView.reloadData()
            progress.hide(animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return scholarships.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ScholarTableViewCell
        let scholarship = scholarships[indexPath.row]
        cell.lblNAme.text = scholarship.name
        cell.lblCountry.text = scholarship.country
        cell.lblInstitute.text = scholarship.institution
        return cell
    }
}
