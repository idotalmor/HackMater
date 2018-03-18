//done
import UIKit
import FCAlertView
import CoreLocation

class DeliveryWaitingProductViewController: UIViewController, FCAlertViewDelegate {
    
    var transaction: Transaction?
    var product : ProductID?
    var parameters: [String:String] = [:]
    
    var json : Any = ""{
        didSet{
            DispatchQueue.main.sync {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }}
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loactionLabel: UILabel!
    @IBOutlet weak var inOutLabel: UILabel!
    @IBAction func SendProduct(_ sender: UIButton) {
        
        let alert = FCAlertView();
        alert.colorScheme = UIColor(red: 0/255, green: 79/255, blue: 150/255, alpha: 1)
        alert.dismissOnOutsideTouch = true
        alert.bounceAnimations = true
        
        alert.delegate = self
        let image = UIImage(named: "icons8-checkmark")
        alert.showAlert(inView: self,
                        withTitle:"סיום העברה",
                        withSubtitle:"האם אתה מאשר כי העברת את המוצר ליעד הסופי?",
                        withCustomImage:image,
                        withDoneButtonTitle:"ביטול",
                        andButtons:["אישור"]) // Set your button titles here
    }
    
    func fcAlertView(_ alertView: FCAlertView, clickedButtonIndex index: Int, buttonTitle title: String) {
        let intStatus = Int(transaction!.status)
        parameters = ["id": (transaction?.id)!, "status": String(intStatus!+1)]
        updateDeliveryTransaction()
        
    }
    
    func fcAlertDoneButtonClicked(_ alertView: FCAlertView){
        // Done Button was Pressed, Perform the Action you'd like here.
    }
    
    
    
    
    @IBAction func toWarehouseWaze(_ sender: Any) {
        viewWaze(locationstr: ("32.015542/34.781488"))
    }
    
    @IBAction func toClientLocationWaze(_ sender: Any) {
        let intStatus = Int((transaction?.status)!)!
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
        
        if(transactions.status == "1"){
            inOutLabel.text = "איסוף למחסן"
            nameLabel.text = transactions.sendername
            loactionLabel.text = transactions.locationAString
            dateLabel.text = SecToDate(timeStamp: transactions.locationAtime)
        } else if(transactions.status == "4"){
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

extension DeliveryWaitingProductViewController{
    
    func updateDeliveryTransaction(){
        guard let url = URL(string: "https://maternaApp.mybluemix.net/api/v1/transactions/update") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
            }
            
            if let data = data {
                do {
                    
                    self.json = try JSONSerialization.jsonObject(with: data, options: [])
                } catch {
                    print(error)
                }
            }
            
            }.resume()
    }
}
