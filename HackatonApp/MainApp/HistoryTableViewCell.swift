//
//  HistoryTableViewCell.swift
//  HackatonApp
//
//  Created by Omer Cohen on 08/03/2018.
//  Copyright © 2018 idotalmor. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var dateProdLabel: UILabel!
    @IBOutlet weak var nameProdLabel: UILabel!
    @IBOutlet weak var imageviewProd: DesignableImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
