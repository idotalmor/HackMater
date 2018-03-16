//done
import UIKit
import FCAlertView

class ManagerWaitingProductViewController: UIViewController, FCAlertViewDelegate {
    
    var transaction: Transaction?
    var product : ProductID?
    
    @IBOutlet weak var prodimg: UIImageView!
    @IBOutlet weak var prodNameLabel: UILabel!
    @IBOutlet weak var inOutLabel: UILabel!
    @IBOutlet weak var clientNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    @IBAction func btnSend(_ sender: UIButton) {
        
        let alert = FCAlertView();
        let image = UIImage(named: "mail")
        alert.addTextField(withPlaceholder: "תרשום הודעה לשליחים") { (textField) in
            print(textField)
        }
        alert.dismissOnOutsideTouch = true
        alert.blurBackground = true
        alert.hideDoneButton = false
        alert.colorScheme = UIColor(red: 0/255, green: 79/255, blue: 150/255, alpha: 1)
        alert.delegate = self
        
        alert.showAlert(inView: self,
                        withTitle:"תרשום הודעה",
                        withSubtitle:" ",
                        withCustomImage:image,
                        withDoneButtonTitle:"אישור",
                        andButtons:["ביטול"]) // Set your button titles here
    }
    
    
    
    func alertView(alertView: FCAlertView, clickedButtonIndex index: Int, buttonTitle title: String) {
        if title == "ביטול" {
            // Perform Action for Button 1
            print("ביטול")
        }else{
            print("אישור")
            // Perform Action for Button 2
        }
    }
    
    func FCAlertDoneButtonClicked(alertView: FCAlertView){
        // Done Button was Pressed, Perform the Action you'd like here.
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let transaction = transaction else{self.dismiss(animated: true, completion: nil)
            return}
        
        guard let product = Products().search(forBarcode: transaction.product)
            else{return}
        
        prodimg.image = product.prodImage
        prodNameLabel.text = product.prodName
        
        if(transaction.status == "0"){
            inOutLabel.text = "נכנס"
            clientNameLabel.text = transaction.sendername
        locationLabel.text = transaction.locationAString
            dateLabel.text = SecToDate(timeStamp: transaction.locationAtime)
        } else if(transaction.status == "3"){
            clientNameLabel.text = transaction.receivername
            locationLabel.text = transaction.locationBString
            dateLabel.text = SecToDate(timeStamp: transaction.locationBtime)
            
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        self.navigationController?.popToRootViewController(animated: true)
    }
}





