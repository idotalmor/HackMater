//add 2 locations - warehouse client
//alert did set json
//done

import UIKit
import CoreLocation
import FCAlertView
import Foundation

class DeliveryConfirmViewController: UIViewController, FCAlertViewDelegate {
    
    
    var transaction: Transaction?
    var parameters: [String:String] = [:]
   
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
                        withTitle:"איסוף תרומה",
                        withSubtitle:"האם ברצונך לאסוף תרומה זו?",
                        withCustomImage:nil,
                        withDoneButtonTitle:"ביטול",
                        andButtons:["אשר איסוף","אשר איסוף ופתח וייז"])
    }
    
    func fcAlertView(_ alertView: FCAlertView, clickedButtonIndex index: Int, buttonTitle title: String) {
        if title == "ביטול" {
            return
        }
            var intStatus = Int(transaction!.status)
        var locationguy = (intStatus == 0) ? "locationAdeliveryguy" :"locationBdeliveryguy"
        
            parameters = ["id": (transaction?.id)!, "status": String(intStatus!+1), locationguy: (User.current?.name)!]
            updateDeliveryTransaction()

        if (title == "אשר איסוף ופתח וייז"){
            switch(intStatus!){
            case 0:do {

                viewWaze(locationstr: (transaction?.locationA)!)
                }
            case 3:do {
                viewWaze(locationstr: ("32.015542/34.781488"))

                }
            default: do {
                print("sdf")}
                
            }
            
        }

    }
    
    private func FCAlertDoneButtonClicked(alertView: FCAlertView){
    }
    
    
    
    

    var json : Any = ""{
        didSet{
//            print(json)
//            print("updateDelivery")

        }}

    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let transaction = transaction else{self.dismiss(animated: true, completion: nil)
            return}

        guard let product = Products().search(forBarcode: transaction.product)
            else{self.dismiss(animated: true, completion: nil)
                return}

        imgProduct.image = product.prodImage
        productLabel.text = product.prodName

        if(transaction.status == "0"){
            inOutLabel.text = "איסוף למחסן"
            clientNameLabel.text = transaction.sendername
            LocationLabel.text = transaction.locationAString
            dateLabel.text = SecToDate(timeStamp: transaction.locationAtime)
        } else if(transaction.status == "3"){
            clientNameLabel.text = transaction.receivername
            LocationLabel.text = transaction.locationBString
            dateLabel.text = SecToDate(timeStamp: transaction.locationBtime)

        }

        
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.popToRootViewController(animated: true)
        
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


