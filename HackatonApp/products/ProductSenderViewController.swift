
import UIKit
import CoreLocation
import FCAlertView


class ProductSenderViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource, UIGestureRecognizerDelegate{
    
    var productId: String = ""
    var parameters: [String: Any] = ["":""]
    var bqStr: String?
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    var products :[ProductID]?
    

    
    var locationString:String?
    var coordinateString = ""{
        didSet{
//            var receiverPhone = phoneNumberTextField.text
//            var name = nameTextField.text
//            parameters = ["id":transaction!.id,"status":"3","receiverphonenumber":receiverPhone!,"receiveruid":(User.current?.id)!,"receivername":name!,"locationBtime":currentToSeconds(),"locationBString":locationString!,"locationB":coordinateString]
//            claimTransaction()
            
            
        }
    }
    
    var json : Any = ""{
        didSet{
            guard let user = json as? Json else {return}
            
            misAlert(Title: "התרומה התקבלה בהצלחה במערכת", Message: "ניצור איתך קשר בהקדם", image: delegate.pictures[1])
            
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var seriesBtn: UIButton!
    @IBOutlet weak var fullNameTF: UITextField!
    @IBOutlet weak var phoneNumTF: UITextField!
    @IBOutlet weak var streetTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var homeNumTF: UITextField!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBAction func getQRBtn(_ sender: UIButton) {
        
     //   getQRCamera()
        performSegue(withIdentifier: "senderFormToQrSegue", sender: nil)
    }
    
    @IBAction func seriesSelected(_ sender: UIButton) {
        if pickerView.isHidden {
            pickerView.isHidden = false
        }
        
        pickerView.dataSource = self
        pickerView.delegate = self
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

    }
    
    @IBAction func datePickerBtn(_ sender: UIDatePicker) {
        expirationDateTF.text = stringFrom(date: datePickerTF.date)
        
    }
    
    
    
    
    @IBAction func saveFormBtn(_ sender: UIButton) {
        
//        cityT = cityTF.text!
//        streetT = streetTF.text!
//        streetNumTF = homeNumTF.text!
//        validMonthTF = expirationDateTF.text!.description
//
//        let geocoder = CLGeocoder()
//
//        adressTF = streetT+spaces+streetNumTF+spaces+cityT
//        validAsString = validMonthTF+"/"+validYearTF
//        print(adressTF)
//
//        geocoder.geocodeAddressString(adressTF, completionHandler: {(placemarks, error) -> Void in
//            if((error) != nil){
//                print("Error", error ?? "")
//            }
//            if let placemark = placemarks?.first {
//                let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
//                print("Lat: \(coordinates.latitude) -- Long: \(coordinates.longitude)")
//                self.coordinatesLongitude = coordinates.longitude.description
//                self.coordinatesLatitude = coordinates.latitude.description
//                self.coordinatesAsString = self.coordinatesLongitude+"/"+self.coordinatesLatitude
//
//            }
//        })
//
//
//
//        if (cityT != "" && streetT != "" && streetNumTF != "" && validYearTF != "" && validMonthTF != "" && adressTF != "" && validAsString != "" ){
//            parameters = ["product": series,
//                          "locationAdeliveryguy": "locationAdeliveryguy",
//                          "warehouseguy": "warehouseguy",
//                          "warehouse": "warehouse",
//                          "locationBtime": "locationBtime",
//                          "locationBString": adressTF,
//                          "locationA": "locationA",
//                          "locationAString": "locationAString",
//                          "id": "d490d5ab6f5090630009115301c848e2",
//                          "locationBdeliveryguy": "locationBdeliveryguy",
//                          "status": "status",
//                          "locationAtime": "locationAtime",
//                          "locationB": coordinatesAsString,
//                          "expirationdate": validAsString]
//
//
//            sendDetailsMain(urlstr: "https://maternaApp.mybluemix.net/api/v1/transactions/add")
//        }else{
//
//            misAlert(Title: "חסרים", Message: "נא למלא את כל שדות החובה", image: delegate.pictures[0])
//        }
        
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        products = Products().products
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        
        var prod = Products().search(forBarcode: delegate.barcode)
        
        seriesBtn.setTitle(prod?.prodName, for: .normal)
        if prod?.prodImage != nil {
            imageView.image = prod?.prodImage}
        
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
        pickerView.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
}
extension ProductSenderViewController{
    
    func sendDetailsMain (urlstr:String){
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
    
    private func stringFrom(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: datePickerTF.date)
    }

}
