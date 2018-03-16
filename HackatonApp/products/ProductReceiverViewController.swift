import UIKit
import CoreLocation
import FCAlertView


class ProductReceiverViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource, UIGestureRecognizerDelegate{
    
    
    @IBOutlet weak var expirationMonthTF: UITextField!
    @IBOutlet weak var expirationYearTF: UITextField!
    @IBOutlet weak var seriesBtn: UIButton!
    @IBOutlet weak var levelBtn: UIButton!
    @IBOutlet weak var fullNameTF: UITextField!
    @IBOutlet weak var phoneNumTF: UITextField!
    @IBOutlet weak var streetTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var homeNumTF: UITextField!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    var series: String = ""
    var level: String?
    var vaildDate: String = ""
    var fullnameTF: String = ""
    var phoneNumberTF: String = ""
    var adressTF: String = ""
    var cityT: String = ""
    var streetT: String = ""
    var streetNumTF: String = ""
    var coordinatesLatitude:String = ""
    var coordinatesLongitude:String = ""
    var coordinatesAsString:String = ""
    var validYearTF:String = ""
    var validMonthTF:String = ""
    var validAsString:String = ""
    
    let spaces = String(repeating: " ", count: 1)
    var products :[ProductID]?
    
    var seriesRow: String = ""
    var levelRow: String?
    var parameters: [String: Any] = ["":""]
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBAction func saveFormBtn(_ sender: UIButton) {
        
        cityT = cityTF.text!
        streetT = streetTF.text!
        streetNumTF = homeNumTF.text!
        validYearTF = expirationYearTF.text!.description
        validMonthTF = expirationMonthTF.text!.description
        
        let geocoder = CLGeocoder()
        
        adressTF = streetT+spaces+streetNumTF+spaces+cityT
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
        
        
        if (cityT != "" && streetT != "" && streetNumTF != "" && validYearTF != "" && validMonthTF != "" && adressTF != "" && validAsString != "" ){
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
            
            sendDetailsMainReceiver(urlstr: "https://maternaApp.mybluemix.net/api/v1/transactions/add")
            
        }else{
            
            misAlert(Title: "חסרים", Message: "נא למלא את כל שדות החובה", image: delegate.pictures[0])
        }
        
    }
    
    var json : Any = "hh"{
        didSet{
            print(json)
            guard let user = json as? Json else {return}
            
            misAlert(Title: "הבקשה התקבלה בהצלחה במערכת", Message: "מוצר בבדיקה", image: delegate.pictures[1])
            
            
        }
    }
    
    @IBAction func seriesSelected(_ sender: UIButton) {
        if pickerView.isHidden {
            pickerView.isHidden = false
        }
        
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    @IBAction func levelSelected(_ sender: UIButton) {
        if pickerView.isHidden {
            pickerView.isHidden = false
        }
        
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    @IBAction func validSelected(_ sender: UIButton) {
    }
    @IBAction func openDateSelected(_ sender: UIButton) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        products = Products().products
        pickerView.isHidden = true
        
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        
    }
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return products!.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return products![row].prodName
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        levelBtn.setTitle(products![row].prodName, for: .normal)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        
    }
}


extension ProductReceiverViewController{
    
    func sendDetailsMainReceiver (urlstr:String){
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


