

import UIKit

class DeliveryWaitingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var inOutLabel: UILabel!
    @IBOutlet weak var loacationProduct: UILabel!
    @IBOutlet weak var dateProduct: UILabel!
    @IBOutlet weak var nameProduct: UILabel!
    @IBOutlet weak var imageProduct: UIImageView!
    
    var status: Int = 1{
        didSet{
            switch(status){
            case 0: do {
                self.inOutLabel.text = "נכנס"
                self.inOutLabel.textColor = UIColor.blue
                }
            case 3: do {
                self.inOutLabel.text = "יוצא"
                self.inOutLabel.textColor = UIColor.black
                }
                
            default:self.inOutLabel.text = "אין סטטוס"
                
            }
        }
        
    }
 
}
