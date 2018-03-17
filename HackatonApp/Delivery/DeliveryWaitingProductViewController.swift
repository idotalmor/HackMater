
import UIKit
import FCAlertView
import CoreLocation

class DeliveryWaitingProductViewController: UIViewController, FCAlertViewDelegate {
    
    var transaction: Transaction?
    var product : ProductID?

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loactionLabel: UILabel!
    
    @IBOutlet weak var inOutLabel: UILabel!
    @IBAction func SendProduct(_ sender: UIButton) {
        
        let alert = FCAlertView();
        
        alert.delegate = self
        alert.showAlert(inView: self,
                        withTitle:"שליח",
                        withSubtitle:"אישור בקשה?",
                        withCustomImage:nil,
                        withDoneButtonTitle:nil,
                        andButtons:["Button 2"]) // Set your button titles here
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
    

    @IBAction func toWarehouseWaze(_ sender: Any) {
        viewWaze(locationstr: ("32.015542/34.781488"))
    }
    
    @IBAction func toClientLocationWaze(_ sender: Any) {
        var intStatus = Int((transaction?.status)!)!
        switch intStatus {
        case 1:
            viewWaze(locationstr: (transaction?.locationA)!)
        case 4 :
            viewWaze(locationstr: (transaction?.locationB)!)
        default:
            print("error deliverywaitingproduct")
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        guard let transactions = transaction else{self.dismiss(animated: true, completion: nil)
            return}
        
        guard let product = Products().search(forBarcode: transactions.product)
            else{return}
        
        imageView.image = product.prodImage
        productNameLabel.text = product.prodName
        
        if(transactions.status == "0"){
            inOutLabel.text = "נכנס"
            nameLabel.text = transactions.sendername
            loactionLabel.text = transactions.locationAString
            dateLabel.text = SecToDate(timeStamp: transactions.locationAtime)
        } else if(transactions.status == "3"){
            nameLabel.text = transactions.receivername
            loactionLabel.text = transactions.locationBString
            dateLabel.text = SecToDate(timeStamp: transactions.locationBtime)
            
        }
        
   

        }

 
    
    func viewWaze(locationstr : String) {
        
        var strArr = locationstr.components(separatedBy: "/")
        
        guard let latitude = Double(strArr[0]),
            let longitude = Double(strArr[1]) else {return}
        
        
        
        var link:String = "waze://"
        let url:NSURL = NSURL(string: link)!
        
        if UIApplication.shared.canOpenURL(url as URL) {
            
            let urlStr:NSString = NSString(format: "waze://?ll=%f,%f&navigate=yes",latitude, longitude)
            
            UIApplication.shared.openURL(NSURL(string: urlStr as String)! as URL)
            UIApplication.shared.isIdleTimerDisabled = true
            
            
        } else {
            link = "http://itunes.apple.com/us/app/id323229106"
            UIApplication.shared.openURL(NSURL(string: link)! as URL)
            UIApplication.shared.isIdleTimerDisabled = true
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.popToRootViewController(animated: true)
        
    }

}
