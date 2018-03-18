
//done
import UIKit
import CoreLocation
import FCAlertView


class DeliveryFormViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource, UIGestureRecognizerDelegate, FCAlertViewDelegate{
    
    var productId: String = ""
    var parameters: [String: Any] = ["":""]
    var expirationdate: String?
    
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    var products :[ProductID]?
    var namestr:String = ""
    var phoneNumberstr:String = ""
    var citystr:String = ""
    var streetstr:String = ""
    var houseNumstr:String = ""
    
    
    
    var locationString:String?
    var coordinateString = ""{
        didSet{
            DispatchQueue.main.async {
                self.parameters = ["status": "1",
                                   "locationA": self.coordinateString,
                                   "locationAString": self.locationString,
                                   "locationAtime": self.currentToSeconds(),
                                   "locationAdeliveryguy": User.current?.name,
                                   "warehouse": "1",
                                   "locationB": "",
                                   "locationBString": "",
                                   "locationBtime": "",
                                   "locationBdeliveryguy": "",
                                   "product": self.productId,
                                   "expirationdate": self.expirationdate!,
                                   "warehouseguy": "",
                                   "senderuid":(User.current?.id)!,
                                   "senderphonenumber":self.phoneNumberstr,
                                   "sendername":self.namestr,
                                   "receiveruid":"",
                                   "receiverphonenumber":"",
                                   "receivername":""]
                self.addTransaction(urlstr: "https://maternaApp.mybluemix.net/api/v1/transactions/add")
            }
            
            
        }
    }
    
    var json : Any = ""{
        didSet{
            guard let user = json as? Json else {return}
            DispatchQueue.main.async {
                let alert = FCAlertView();
                alert.colorScheme = UIColor(red: 0/255, green: 79/255, blue: 150/255, alpha: 1)
                alert.dismissOnOutsideTouch = true
                alert.bounceAnimations = true
                
                alert.delegate = self
                let image = UIImage(named: "icons8-checkmark")
                alert.showAlert(inView: self,
                                withTitle:"התרומה התקבלה בהצלחה במערכת",
                                withSubtitle:"ניצור איתך קשר בהקדם",
                                withCustomImage:image,
                                withDoneButtonTitle:"אישור",
                                andButtons:["ביטול"])
            }
            
            
        }
    }
    
    
    
    
    func fcAlertView(_ alertView: FCAlertView, clickedButtonIndex index: Int, buttonTitle title: String) {
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    func fcAlertDoneButtonClicked(_ alertView: FCAlertView){
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var seriesBtn: UIButton!
    @IBOutlet weak var fullNameTF: UITextField!
    @IBOutlet weak var phoneNumTF: UITextField!
    @IBOutlet weak var streetTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var homeNumTF: UITextField!
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var pickerViewContainer: UIView!
    
    
    @IBAction func seriesSelected(_ sender: UIButton) {
        if pickerViewContainer.isHidden {
            pickerViewContainer.isHidden = false
        }
        self.view.endEditing(true)
    }
    
    @IBOutlet weak var expirationDateTF: UITextField!
    @IBOutlet weak var datePickerTF: UIDatePicker!
    @IBOutlet weak var doneDateBtn: DesignableButton!
    @IBOutlet weak var backDateView: UIView!
    
    @IBAction func doneDate(_ sender: Any) {
        
        datePickerTF.isHidden = !datePickerTF.isHidden
        doneDateBtn.isHidden = !doneDateBtn.isHidden
        backDateView.isHidden = !backDateView.isHidden
        
    }
    @IBAction func expirationDateBtn(_ sender: Any) {
        datePickerTF.isHidden = !datePickerTF.isHidden
        doneDateBtn.isHidden = !doneDateBtn.isHidden
        backDateView.isHidden = !backDateView.isHidden
        self.view.endEditing(true)
        
    }
    
    @IBAction func datePickerBtn(_ sender: UIDatePicker) {
        expirationDateTF.text = stringFrom(date: datePickerTF.date)
        expirationdate = String(sender.date.timeIntervalSince1970)
    }
    
    
    
    
    @IBAction func saveFormBtn(_ sender: UIButton) {
        
        guard let name = fullNameTF.text,
            let phoneNumber = phoneNumTF.text,
            let city = cityTF.text,
            let street = streetTF.text,
            let houseNum = homeNumTF.text
            else {misAlert(Title: "חסרים", Message: "נא למלא את כל שדות החובה", image: delegate.pictures[0])
                return}
        namestr = name
        phoneNumberstr = phoneNumber
        citystr = city
        streetstr = street
        houseNumstr = houseNum
        
        locationString(street: street, houseNum: houseNum, city: city)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        products = Products().products
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        
    }
    
    func locationString(street:String,houseNum:String,city:String){
        
        let geocoder = CLGeocoder()
        locationString = street+" "+houseNum+" "+city
        
        
        geocoder.geocodeAddressString(locationString!, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil){
                print("Error", error ?? "")
            }
            if let placemark = placemarks?.first {
                let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                
                let coordinatesLongitude = coordinates.longitude.description
                let coordinatesLatitude = coordinates.latitude.description
                self.coordinateString =  coordinatesLatitude+"/"+coordinatesLongitude
                
            }
        })}
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
        
        imageView.image = products![row].prodImage
        seriesBtn.setTitle(products![row].prodName, for: .normal)
        productId = products![row].barcode
        pickerViewContainer.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
}
extension DeliveryFormViewController{
    
    func addTransaction (urlstr:String){
        guard let url = URL(string: urlstr) else { return }
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



