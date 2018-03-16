import UIKit
import CoreLocation
import FCAlertView
import AVFoundation



class ProductSenderFormViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIGestureRecognizerDelegate
{
    var seriesRow: String = ""
    var levelRow: String?
    var parameters: [String: Any] = ["":""]
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
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
    
    @IBOutlet weak var cameraLabel: UILabel!
    
    @IBAction func getQRBtn(_ sender: UIButton) {
        cameraLabel.isHidden = false
        
        getQRCamera()
        
    }
    
    
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
    //   var cameraLabel:UILabel?
    
    
    let spaces = String(repeating: " ", count: 1)
    var products :[ProductID]?
    
    // BarCode code:
    var prod: ProductID?
    var captureSession = AVCaptureSession()
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView: UIView?
    
    private let supportedCodeTypes = [AVMetadataObject.ObjectType.upce,
                                      AVMetadataObject.ObjectType.code39,
                                      AVMetadataObject.ObjectType.code39Mod43,
                                      AVMetadataObject.ObjectType.code93,
                                      AVMetadataObject.ObjectType.code128,
                                      AVMetadataObject.ObjectType.ean8,
                                      AVMetadataObject.ObjectType.ean13,
                                      AVMetadataObject.ObjectType.aztec,
                                      AVMetadataObject.ObjectType.pdf417,
                                      AVMetadataObject.ObjectType.itf14,
                                      AVMetadataObject.ObjectType.dataMatrix,
                                      AVMetadataObject.ObjectType.interleaved2of5,
                                      AVMetadataObject.ObjectType.qr]
    
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
            
            
            //sendDetailsMain(urlstr: "https://maternaApp.mybluemix.net/api/v1/transactions/add")
        }else{
            
            misAlert(Title: "חסרים", Message: "נא למלא את כל שדות החובה", image: delegate.pictures[0])
        }
        
    }
    
    var json : Any = "hh"{
        didSet{
            print(json)
            guard let user = json as? Json else {return}
            
            misAlert(Title: "התרומה התקבלה בהצלחה במערכת", Message: "ניצור איתך קשר בהקדם", image: delegate.pictures[1])
            
            
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        products = Products().products
        pickerView.isHidden = true
        cameraLabel?.isHidden = true
        
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
        pickerView.isHidden = true
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func getQRCamera() {
        
        cameraLabel?.isHidden = false
        
        
        // Get the back-facing camera for capturing videos
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back)
        guard let captureDevice = deviceDiscoverySession.devices.first else {
            print("Failed to get the camera device")
            return
        }
        
        do {
            
            print("omerrrr111111")
            
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            // Set the input device on the capture session.
            captureSession.addInput(input)
            
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = supportedCodeTypes
            //            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            print(error)
            return
        }
        
        // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer!)
        
        // Start video capture.
        captureSession.startRunning()
        
        // Move the message label and top bar to the front
        view.bringSubview(toFront: cameraLabel)
        //view.bringSubview(toFront: topbar)
        
        // Initialize QR Code Frame to highlight the QR code
        qrCodeFrameView = UIView()
        
        if let qrCodeFrameView = qrCodeFrameView {
            qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
            qrCodeFrameView.layer.borderWidth = 2
            view.addSubview(qrCodeFrameView)
            view.bringSubview(toFront: qrCodeFrameView)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    func launchApp(decodedURL: String) {
        
        if presentedViewController != nil {
            
            print("omerrrr")
            return
        }
        
        let alertPrompt = UIAlertController(title: "Open App", message: "You're going to open \(decodedURL)", preferredStyle: .actionSheet)
        let confirmAction = UIAlertAction(title: "Confirm", style: UIAlertActionStyle.default, handler: { (action) -> Void in
            
            if let url = URL(string: decodedURL) {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        
        alertPrompt.addAction(confirmAction)
        alertPrompt.addAction(cancelAction)
        
        present(alertPrompt, animated: true, completion: nil)
    }
    
    
    
    //
    //
    //    override func viewWillAppear(_ animated: Bool) {
    //        super.viewWillAppear(animated)
    //        self.navigationController?.isNavigationBarHidden = false
    //
    //    }
    //    override func viewWillDisappear(_ animated: Bool) {
    //        super.viewWillDisappear(animated)
    //        self.navigationController?.popToRootViewController(animated: true)
    //
    //    }
    
}





extension ProductSenderFormViewController : AVCaptureMetadataOutputObjectsDelegate {
    
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            cameraLabel.text = "No QR code is detected"
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if supportedCodeTypes.contains(metadataObj.type) {
            // If the found metadata is equal to the QR code metadata (or barcode) then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            
            if metadataObj.stringValue != nil {
                launchApp(decodedURL: metadataObj.stringValue!)
                var str = metadataObj.stringValue
                prod = Products().search(forBarcode: str!)
                //   performSegue(withIdentifier: "DeliveryScannerToQRFromSegue", sender: self)
                print("1111111",prod?.barcode)
                print("222222",prod?.prodLink)
                if prod?.prodLink != nil{
                    
                    connection.isEnabled = false
                    captureSession.stopRunning()
                    print("problem camera")
                    return
                    
                }
                
                
                
                
                
                
            }
        }
    }
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if(segue.identifier == "DeliveryScannerToQRFromSegue"){
    //            guard let dest = segue.destination as? DeliveryQrFormViewController else {return}
    //            dest.prodseg = prod
    //
    //
    //
    //        }
    //    }
    
}




