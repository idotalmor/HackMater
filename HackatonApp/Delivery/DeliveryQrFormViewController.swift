import CoreLocation
import UIKit
import FCAlertView

class DeliveryQrFormViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var validYearTxt: UITextField!
    @IBOutlet weak var validMonthTxt: UITextField!
    @IBOutlet weak var sec2Btn: UIButton!
    @IBOutlet weak var sec1Btn: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var fullNameTxt: UITextField!
    @IBOutlet weak var numberTxt: UITextField!

    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    var series: String = ""
    var level: String?
    var vaildDate: String = ""
    var fullnameTF: String = ""
    var phoneNumberTF: String = ""
    var adressTF: String = ""
    var cityTF: String = ""
    var streetTF: String = ""
    var streetNumTF: String = ""
    var coordinatesLatitude:String = ""
    var coordinatesLongitude:String = ""
    var coordinatesAsString:String = ""
    var validYearTF:String = ""
    var validMonthTF:String = ""
    var validAsString:String = ""
    
    let spaces = String(repeating: " ", count: 1)
    
    var productsLevel = [LevelProduct]()
    
    var parameters : [String:String] = ["":""]
    
    var product: [ProductID]?
    var prodseg : ProductID?
    @IBAction func sendDetailsBtn(_ sender: Any) {
        
       
   
        validYearTF = validYearTxt.text!.description
        validMonthTF = validMonthTxt.text!.description
        
        let geocoder = CLGeocoder()
        
        adressTF = streetTF+spaces+streetNumTF+spaces+cityTF
        validAsString = validMonthTF+"/"+validYearTF
        print(adressTF)
        
        geocoder.geocodeAddressString(adressTF, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil){
                print("Error", error ?? "")
            }
            if let placemark = placemarks?.first {
                let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                print("Lat: \(coordinates.latitude) -- Long: \(coordinates.longitude)")
                self.coordinatesLongitude = coordinates.longitude.description
                self.coordinatesLatitude = coordinates.latitude.description
                self.coordinatesAsString = self.coordinatesLongitude+"/"+self.coordinatesLatitude
                
            }
        })
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        if (cityTF != "" && streetTF != "" && streetNumTF != "" && validYearTF != "" && validMonthTF != "" && adressTF != "" && validAsString != "" ){
            parameters = ["product": series,
                          "locationAdeliveryguy": "locationAdeliveryguy",
                          "warehouseguy": "warehouseguy",
                          "warehouse": "warehouse",
                          "locationBtime": "locationBtime",
                          "locationBString": adressTF,
                          "locationA": "locationA",
                          "locationAString": "locationAString",
                          "id": "d490d5ab6f5090630009115301c848e2",
                          "locationBdeliveryguy": "locationBdeliveryguy",
                          "status": "status",
                          "locationAtime": "locationAtime",
                          "locationB": coordinatesAsString,
                          "expirationdate": validAsString]
            
            
            sendDetails(urlstr: "https://maternaApp.mybluemix.net/api/v1/transactions/add")
        }else{
            
            misAlert(Title: "חסרים", Message: "נא למלא את כל שדות החובה", image: delegate.pictures[0])
        }
    }
    

    var json : Any = ""{
        didSet{
            print(json)
            guard let transaction = json as? Json else {return}
            // product = [Test(json: transaction)]
            
            misAlert(Title: "המוצר התקבל בהצלחה במערכת", Message: "ניצור איתך קשר בהקדם", image: delegate.pictures[1])
            
            
        }
    }
    
    @IBAction func wazeBtn(_ sender: UIButton) {
        
        
//        let geocoder = CLGeocoder()
//
//
//        let address = "רחוב הזוהר 6, תל אביב"
//
//        geocoder.geocodeAddressString(address, completionHandler: {(placemarks, error) -> Void in
//            if((error) != nil){
//                print("Error", error ?? "")
//            }
//            if let placemark = placemarks?.first {
//                let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
//                print("Lat: \(coordinates.latitude) -- Long: \(coordinates.longitude)")
//            }
//        })
        
        var clocation:CLLocation = CLLocation(latitude: 32.082216, longitude: 34.78146)
        viewWaze(location: clocation)

        
        
    }
    @IBAction func sec1Sellect(_ sender: UIButton) {
        
        if pickerView.isHidden {
            pickerView.isHidden = false
        }
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    @IBAction func sec2Level(_ sender: Any) {
        
        if pickerView.isHidden {
            pickerView.isHidden = false
        }
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        product = Products().products
        
        sec2Btn.setTitle(prodseg?.prodName, for: .normal)
        fullnameTF = fullNameTxt.text!
        phoneNumberTF = numberTxt.text!
        
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(back(uibar:)))
        
        
        
        pickerView.isHidden = true
    }
    @objc func back(uibar:UIBarButtonItem){

        self.navigationController?.popToRootViewController(animated: true)
    }
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return product!.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return product![row].prodName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        sec2Btn.setTitle(product![row].prodName, for: .normal)
        pickerView.isHidden = true
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    
    
    
}

extension DeliveryQrFormViewController{
    
    func sendDetails (urlstr:String){
        guard let url = URL(string: urlstr) else { return }
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
            
            }.resume()}
    
    
    
}
