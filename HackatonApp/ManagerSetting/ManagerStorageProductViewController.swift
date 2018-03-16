//done
import UIKit

class ManagerStorageProductViewController: UIViewController {
    
    var transaction:Transaction?
    var product: ProductID?


    
    @IBOutlet weak var imageProd: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var deliveryGuyLabel: UILabel!
    @IBOutlet weak var senderNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var expirationDateLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        product = Products().search(forBarcode: (transaction?.product)!)
        imageProd.image = product?.prodImage
        productNameLabel.text = product?.prodName
        deliveryGuyLabel.text = transaction!.locationAdeliveryguy
        senderNameLabel.text = transaction!.sendername
        locationLabel.text = transaction!.locationAString
        dateLabel.text = SecToDate(timeStamp: transaction!.locationAtime)
        expirationDateLabel.text = SecToDate(timeStamp: transaction!.expirationdate)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    
}
