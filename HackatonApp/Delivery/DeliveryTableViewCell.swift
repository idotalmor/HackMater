//done
import UIKit

class DeliveryTableViewCell: UITableViewCell {

    @IBOutlet weak var inOutLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    
    var status: Int = 1{
        didSet{
            switch(status){
            case 0: do {
                self.inOutLabel.text = "למחסן"
                self.inOutLabel.textColor = UIColor.blue
                }
            case 3: do {
                self.inOutLabel.text = "ללקוח"
                self.inOutLabel.textColor = UIColor.black
                }
                
            default:self.inOutLabel.text = "אין סטטוס"
                
            }
        }
        
    }
}
