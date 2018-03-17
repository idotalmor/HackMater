//
//  ReceiverFormViewController.swift
//  HackatonApp
//
//  Created by ido talmor on 17/03/2018.
//  Copyright © 2018 idotalmor. All rights reserved.
//done
import CoreLocation
import UIKit

class ReceiverFormViewController: UIViewController {
    
    @IBOutlet weak var prodImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var streetTextField: UITextField!
    @IBOutlet weak var houseNumTextField: UITextField!
    
    
    var transaction :Transaction?
    var parameters : [String:String] = [:]
    
    var locationString:String?
    var coordinateString = ""{
        didSet{
            var receiverPhone = phoneNumberTextField.text
            var name = nameTextField.text
            parameters = ["id":transaction!.id,"status":"3","receiverphonenumber":receiverPhone!,"receiveruid":(User.current?.id)!,"receivername":name!,"locationBtime":currentToSeconds(),"locationBString":locationString!,"locationB":coordinateString]
            claimTransaction()
            
            
        }
    }
    
    var json : Any = ""{
        didSet{
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "PopupToMain", sender: nil)
                
            }
        }
        
    }
    
    @IBAction func closeBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func demandProduct(_ sender: UIButton) {
        
        guard let name = nameTextField.text, name != "",
            let phoneNumber = phoneNumberTextField.text, phoneNumber != ""
            else{return}
        
        let city = cityTextField.text
        let street = streetTextField.text
        let houseNum = houseNumTextField.text
        locationString(street: street!, houseNum: houseNum!, city: city!)
        
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
        })
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var product = Products().search(forBarcode: (transaction?.product)!)
        prodImageView.image = product?.prodImage
        nameTextField.text = User.current?.name
        phoneNumberTextField.text = User.current?.phonenumber
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
}

extension ReceiverFormViewController {
    
    func claimTransaction(){
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


