//
//  DocumentTableViewCell.swift
//  Unitravel
//
//  Created by Abraham Rubio on 5/29/17.
//  Copyright © 2017 UPQ. All rights reserved.
//

import UIKit

class DocumentTableViewCell: UITableViewCell {
    @IBOutlet weak var imgStatus: UIImageView!

    @IBOutlet weak var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
