//
//  ReceiverTableViewCell.swift
//  HackatonApp
//
//  Created by ido talmor on 17/03/2018.
//  Copyright © 2018 idotalmor. All rights reserved.
//done

import UIKit

class ReceiverTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productExpirationDateLabel: UILabel!
    
    
    
    var transaction : Transaction? {
        didSet{
            guard let product = Products().search(forBarcode: (transaction?.product)!)else {return}
            productImageView.image = product.prodImage
            productNameLabel.text = product.prodName
            productExpirationDateLabel.text = SecToDate(timeStamp: (transaction?.expirationdate)!)
        }
    }
    
}
