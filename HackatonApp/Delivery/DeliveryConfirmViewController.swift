
import UIKit
import CoreLocation
import FCAlertView
import Foundation

class DeliveryConfirmViewController: UIViewController, FCAlertViewDelegate {
    
    
    var transaction: Transaction?

    
    var fullAddress = ""
    var city = ""
    var numberHome = ""
    var street  = ""
    var product : ProductID?
    let geocoder = CLGeocoder()

    let address = "רחוב פינסקר 40 תל אביב"
    
    var parameters: [String:String] = [:]
    let url = URL(fileURLWithPath: "https://waze.com/ul")
   
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var clientNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var LocationLabel: UILabel!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var inOutLabel: UILabel!
    
    
    
    @IBAction func sendDetailsDelivery(_ sender: UIButton) {
        
        let alert = FCAlertView();
        
        var image = UIImage(named: "icons8-google_alerts")
        alert.dismissOnOutsideTouch = true
        alert.blurBackground = true
        alert.hideDoneButton = false
        alert.colorScheme = UIColor(red: 0/255, green: 79/255, blue: 150/255, alpha: 1)
        
        alert.delegate = self
        alert.showAlert(inView: self,
                        withTitle:"שליח",
                        withSubtitle:"אישור בקשה?",
                        withCustomImage:nil,
                        withDoneButtonTitle:"ביטול",
                        andButtons:["אישור"]) // Set your button titles here
    }
    
    func fcAlertView(_ alertView: FCAlertView, clickedButtonIndex index: Int, buttonTitle title: String) {
        if title == "ביטול" {
            // Perform Action for Button 1
            print("ביטול")
        }else{
          //  parameters = ["id": (transaction?.id)!, "status": "1", "senderuid": (User.current?.name)!]
         
            updateDeliveryTransaction()

            print("אישור")
        }
    }
    
    private func FCAlertDoneButtonClicked(alertView: FCAlertView){
    }
    
    
    
    
    @IBAction func WazeBtn(_ sender: UIButton) {
        
        
       // var coordinates = transaction?.locationA
        
        
    //    guard let result = coordinates?.split(separator: " ") else {return}
       // print("coordinates",result[0])
      //  print("coordinates",result[1])
        
        geocoder.geocodeAddressString(address, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil){
                print("Error", error ?? "")
            }
            if let placemark = placemarks?.first {
                let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                print("Lat: \(coordinates.latitude) -- Long: \(coordinates.longitude)")
                
                let clocation:CLLocation = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
                self.viewWaze(location: clocation)
            }
        })
        
       
        
    }
    var json : Any = ""{
        didSet{
            print(json)
            print("updateDelivery")
            DispatchQueue.main.async {
            
            }
        }}

    
    override func viewDidLoad() {
        super.viewDidLoad()
//
//        guard let transaction = transaction else{self.dismiss(animated: true, completion: nil)
//            return}
//
//        guard let product = Products().search(forBarcode: transaction.product)
//            else{return}
//
//        imgProduct.image = product.prodImage
//        productLabel.text = product.prodName
//
//        if(transaction.status == "0"){
//            inOutLabel.text = "נכנס"
//            clientNameLabel.text = transaction.sendername
//            LocationLabel.text = transaction.locationAString
//            dateLabel.text = SecToDate(timeStamp: transaction.locationAtime)
//        } else if(transaction.status == "3"){
//            clientNameLabel.text = transaction.receivername
//            LocationLabel.text = transaction.locationBString
//            dateLabel.text = SecToDate(timeStamp: transaction.locationBtime)
//
//        }
//
        
    }
    
    
    func viewWaze(location : CLLocation) {
        
        let latitude:Double = location.coordinate.latitude;
        let longitude:Double = location.coordinate.longitude;
        
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
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    
}

extension DeliveryConfirmViewController {
    
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
                print(response)
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


