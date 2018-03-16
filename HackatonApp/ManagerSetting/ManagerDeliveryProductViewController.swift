//done
import UIKit
import FCAlertView


class ManagerDeliveryProductViewController: UIViewController, FCAlertViewDelegate {
    
    var transaction:Transaction?
    var product : ProductID?


    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var inOut: UILabel!
    @IBOutlet weak var deliveryGuyName: UILabel!
    @IBOutlet weak var clientName: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    @IBAction func sendMsgBtn(_ sender: UIButton) {
        
        let alert = FCAlertView();
        var image = UIImage(named: "formIcon")
        alert.dismissOnOutsideTouch = true
        alert.blurBackground = true
        alert.hideDoneButton = false
        alert.colorScheme = UIColor(red: 0/255, green: 79/255, blue: 150/255, alpha: 1)
        alert.delegate = self
        alert.showAlert(inView: self,
                        withTitle:"אישור בקשה",
                        withSubtitle:"הנהג הזה?",
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get nameProduct from barcode func
        product = Products().search(forBarcode: (transaction?.product)!)
        imageProduct.image = product?.prodImage
        productName.text = product?.prodName
        if(transaction?.status == "1"){
            inOut.text = "נכנס"
            deliveryGuyName.text = transaction?.locationAdeliveryguy
            clientName.text = transaction?.sendername
            address.text = transaction?.locationAString
            dateLabel.text = SecToDate(timeStamp: (transaction?.locationAtime)!)
        }else if(transaction?.status == "4"){
            deliveryGuyName.text = transaction?.locationBdeliveryguy
            clientName.text = transaction?.receivername
            address.text = transaction?.locationBString
            dateLabel.text = SecToDate(timeStamp: (transaction?.locationBtime)!)
            
        }

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    


}
