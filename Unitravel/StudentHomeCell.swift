//
//  StudentHomeCell.swift
//  Unitravel
//
//  Created by Misael Garay on 09/11/17.
//  Copyright © 2017 UPQ. All rights reserved.
//

import UIKit

class StudentHomeCell: UITableViewCell {

    @IBOutlet weak var scholarImage: UIImageView!
    @IBOutlet weak var scholarName: UILabel!
    @IBOutlet weak var sholarInstitution: UILabel!
    @IBOutlet weak var scholarCountry: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
