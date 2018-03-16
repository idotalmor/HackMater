
import UIKit

class ManagerWaitingTableViewCell: UITableViewCell {

    @IBOutlet weak var imageProd: DesignableImageView!
    @IBOutlet weak var nameprod: UILabel!
    @IBOutlet weak var locationProd: UILabel!
    @IBOutlet weak var inOutprod: UILabel!
    @IBOutlet weak var dateProd: UILabel!

    var status: Int = 1{
        didSet{
            switch(status){
            case 0: do {
                self.inOutprod.text = "נכנס"
                self.inOutprod.textColor = UIColor.blue
                }
            case 3: do {
                self.inOutprod.text = "יוצא"
                self.inOutprod.textColor = UIColor.black
                }
                
            default:self.inOutprod.text = "אין סטטוס"

            }
        }
        
    }
}
