import CoreLocation
import UIKit
import FCAlertView


class DeliveryFormViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var validYearTxt: UITextField!
    @IBOutlet weak var validMonthTxt: UITextField!
    @IBOutlet weak var sec2Btn: UIButton!
    @IBOutlet weak var sec1Btn: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var fullNameTxt: UITextField!
    @IBOutlet weak var numberTxt: UITextField!
    @IBOutlet weak var cityTxt: UITextField!
    @IBOutlet weak var streetTxt: UITextField!
    @IBOutlet weak var streetnumTxt: UITextField!
    
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
    var locationAtime:String = ""
    var warehouse:String = "1"
    
    let spaces = String(repeating: " ", count: 1)
    
    var prod : ProductID?
    
    var productsLevel = [LevelProduct]()
    
    var parameters : [String:String] = [:]
    var str2: String = ""
    //var product = [Test]()
    var product: [ProductID]?
    
    
    @IBAction func sendDetailsBtn(_ sender: Any) {
        
        
        // Time
        var millisecondsSince1970:Int {
            return Int((Date().timeIntervalSince1970).rounded())
        }
        // 1
        let str1 = "\(millisecondsSince1970)"
        print(str1)
        // 2
        str2 = String(millisecondsSince1970)
        print(str2)

        cityTF = cityTxt.text!
        streetTF = streetTxt.text!
        streetNumTF = streetnumTxt.text!
        validYearTF = validYearTxt.text!.description
        validMonthTF = validMonthTxt.text!.description
        fullnameTF = fullNameTxt.text!
        phoneNumberTF = numberTxt.text!
        
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
                self.coordinatesAsString = self.coordinatesLatitude+"/"+self.coordinatesLongitude
                
            }
        })
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        if (cityTF != "" && streetTF != "" && streetNumTF != "" && validYearTF != "" && validMonthTF != "" && adressTF != "" && validAsString != "" ){
            parameters =
                ["id": "0",
                 "status": "0",
                 "locationA": coordinatesAsString,
                 "locationAString": adressTF,
                 "locationAtime": str2,
                 "warehouse": warehouse,
                 "locationB": "coordinate",
                 "locationBString": "adressTF",
                 "locationBtime": "1970",
                 "todeliveryguy": "deliveryguyuid",
                 "fromdeliveryguy": "deliveryguyuid",
                 "product": series,
                 "experationdate": validAsString,
                 "warehouseguy": "warehouseguyuid",
                 "senderuid": phoneNumberTF,
                 "senderphonenumber":phoneNumberTF,
                 "sendername":fullnameTF,
                 "recieveruid":"uid",
                 "recieverphonenumber":"phonenumber"]
            
            
            sendDetails()
        }else{
            
            misAlert(Title: "חסרים", Message: "נא למלא את כל שדות החובה", image: delegate.pictures[0])
        }
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
    
    
    var json : Any = ""{
        didSet{
            print(json)
            guard let transaction = json as? Json else {return}
            // product = [Test(json: transaction)]
            
            DispatchQueue.main.async {

                self.misAlert(Title: "המוצר התקבל בהצלחה במערכת", Message: "ניצור איתך קשר בהקדם", image: self.delegate.pictures[1])
            
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        product = Products().products
        
        pickerView.isHidden = true
        
        fullNameTxt.text = User.current?.name
        numberTxt.text = User.current?.phonenumber
        
//        cityTxt.text!
//        streetTxt.text!
//        streetnumTxt.text!
        
        
       
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
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
        series = product![row].barcode
        pickerView.isHidden = true
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.popToRootViewController(animated: true)
        
    }
}

extension DeliveryFormViewController{
    
    func sendDetails (){
        guard let url = URL(string: "https://maternaApp.mybluemix.net/api/v1/transactions/add") else { return }
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
                    //  self.json = try JSONDecoder().decode([[Products]].self, from: data)
                    
                    print(self.json)
                    
                } catch {
                    print(error)
                }
            }
            
            }.resume()
        
        
    }
    
   
}


