//
//  ScholarTableViewCell.swift
//  
//
//  Created by Abraham Rubio on 5/26/17.
//
//

import UIKit

class ScholarTableViewCell: UITableViewCell {

    @IBOutlet weak var lblNAme: UILabel!
    
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var lblInstitute: UILabel!
    @IBOutlet weak var imgInstitute: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
