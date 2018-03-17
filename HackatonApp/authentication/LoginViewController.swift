//background color - #C3E5FC
//button - #004F96

import UIKit
import FCAlertView
import BluemixAppID

class LoginViewController: UIViewController {
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    let AuthenticationToMainAppSegue : String = "AuthenticationToMainAppSegue"
    let AuthenticationToDeliverySegue : String = "AuthenticationToDeliverySegue"
    let AuthenticationToManagersSegue : String = "AuthenticationToManagersSegue"
    
    let image = UIImage(named: "icons8-google_alerts")!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var userPhoneNumber: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    
    var parameters: [String:String] = [:]
    
    @IBAction func TestPassToMain(_ sender: UIButton) {
        
     parameters = [
        "Password": "",
        "permission": "1",
        "phonenumber": "phonenumber",
        "name": "name",
        "partneruid": "partneruid",
        "mail": "mail",
        "warehouse":"1"]
        
        signup()

    }
    
    var user: Any = ""{
        didSet {
            guard let json = self.user as? [Json] else{return}
            
            var UserDefault = User(json: json[0])
            UserDefault.save()
            
            getPermissionToSegue()
        }
    }
    
    func GoToMainSegue(){
        DispatchQueue.main.async{
            self.navigationController?.performSegue(withIdentifier: "AuthenticationToMainAppSegue", sender: nil)
        }
    }
    func GoToDeliverySegue(){
        DispatchQueue.main.async{
            self.navigationController?.performSegue(withIdentifier: "AuthenticationToDeliverySegue", sender: nil)
        }
    }
    func GoToManagerSegue(){
        DispatchQueue.main.async{
            self.navigationController?.performSegue(withIdentifier: "AuthenticationToManagersSegue", sender: nil)
        }
    }
    
    
    @IBAction func login(_ sender: Any) {
        
    
        guard let phoneNumber = userPhoneNumber.text, phoneNumber != "" else {misAlert(Title: "כניסה נכשלה!",Message:"הזן מספר טלפון", image: delegate.pictures[0])
            return}
        guard let password = userPassword.text, password != "" else {misAlert(Title: "כניסה נכשלה!",Message: "הזן סיסמא", image: delegate.pictures[0])
            return}
        
        
        
        parameters =
            ["phonenumber": phoneNumber, "Password": password]
        
        signin()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        
        if let user = User.current {
            activityIndicator.startAnimating()
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now(), execute: {
                
                self.getPermissionToSegue()
                
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let backgroundImg:UIImage = UIImage(named: "maternabgpng")!
        let backgroundImgView = UIImageView(image: backgroundImg)
        backgroundImgView.contentMode = .scaleAspectFit
        self.view.insertSubview(backgroundImgView, at: 0)
        
        

    
    }
    
    func getPermissionToSegue() {
        
        DispatchQueue.main.async {
            
            switch(User.current?.permission ?? "5"){
            case "1","2" :
                self.GoToMainSegue()
            case "3" :
                self.GoToDeliverySegue()
            case "4" :
                self.GoToManagerSegue()
            default:
                print("default switch case from login")
            }
        }
        
    }
    
    
}

extension LoginViewController{
    
    func signin(){
        guard let url = URL(string: "https://maternaApp.mybluemix.net/api/v1/users/login") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse {
                print(response)
            }
            
            if let data = data {
                do {
                    self.user = try JSONSerialization.jsonObject(with: data, options: [])
                } catch {
                    print(error)
                }
                
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                }
            }
            }.resume()
    }
    
    func signup(){
        guard let url = URL(string: "https://maternaApp.mybluemix.net/api/v1/users/signup") else { return }
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
                   self.user = try JSONSerialization.jsonObject(with: data, options: [])
                  
                } catch {
                    print(error)
                }
            }

            }.resume()}

}







