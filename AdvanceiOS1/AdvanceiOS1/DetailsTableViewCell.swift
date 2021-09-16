//
//  DetailsTableViewCell.swift
//  AdvanceiOS1
//
//  Created by user203962 on 9/16/21.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var tbllblstartdate: UILabel!
    @IBOutlet weak var tbllbltution: UILabel!
    @IBOutlet weak var tbllblage: UILabel!
    @IBOutlet weak var tbllblname: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
