//
//  HistoryTableViewCell.swift
//  HackatonApp
//
//  Created by Omer Cohen on 08/03/2018.
//  Copyright © 2018 idotalmor. All rights reserved.
//done

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateProdLabel: UILabel!
    @IBOutlet weak var nameProdLabel: UILabel!
    @IBOutlet weak var imageviewProd: DesignableImageView!
    @IBOutlet weak var progressLabel: UILabel!
    
    var transaction: Transaction? {
        didSet{
            var product = Products().search(forBarcode: transaction?.product)
            imageviewProd.image = product?.prodImage
            nameProdLabel.text = product?.prodName
            switch (Int((transaction?.status)!)!) {
            case 5:
                dateProdLabel.text = SecToDate(timeStamp: (transaction?.locationBtime)!)
            default:
                if(transaction?.senderuid == User.current?.id){
                    progressLabel.text = "יוצא"
                }else{
                    progressLabel.text = "נכנס"
                }
                dateProdLabel.text = SecToDate(timeStamp: (transaction?.locationAtime)!)
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
