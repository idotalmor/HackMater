//
//  RssCell.swift
//  HackatonApp
//
//  Created by ido talmor on 19/02/2018.
//  Copyright © 2018 idotalmor. All rights reserved.
//

import UIKit
import SDWebImage

class RssCell: UITableViewCell {

    @IBOutlet weak var postImage: UIImageView!
    
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postDescription: UILabel!
    
    var photoURL : String = ""{
        didSet{

            var urlString = photoURL.components(separatedBy: ".jpg")[0]

           var url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!+".jpg")
            
            postImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder.png"))
        }

    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
