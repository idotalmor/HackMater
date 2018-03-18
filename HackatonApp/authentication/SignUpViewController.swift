//done
import UIKit
import FCAlertView

class SignUpViewController: UIViewController {
    
    //must
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var password: UITextField!
    //optional
    @IBOutlet weak var mail: UITextField!
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    var parameters : [String:Any]?
    var permision =  "2"
    var warehouse = "1"
    
    
  
    
    var json: Any = "" {
        didSet {
            
            guard let json = json as? Json else{return}
            let UserDefault = User(json: json)
            UserDefault.save()
            
            switch(User.current?.permission ?? "5"){
            case "1","2" :
                self.GoToMainSegue()
            case "3" :
                self.GoToDeliverySegue()
             case "4" :
                self.GoToManagerSegue()
            default:
                misAlert(Title: "could not sign you up", Message: "please try later", image: delegate.pictures[0])
            }
        }
    }
    
    func GoToMainSegue(){
        DispatchQueue.main.async {
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
    
    
    @IBAction func signupBtn(_ sender: DesignableButton) {
        
        guard let fullnamestr = fullName.text,
            let phoneNumberstr = phoneNumber.text,
            let passwordstr = password.text
            else {return}
    let mailstr = mail.text
    
        if(passwordstr == "4"){permision = "4"}
        else if(passwordstr == "3"){permision = "3"}

        parameters = [
            "Password": passwordstr,
            "permission": permision,
            "phonenumber": phoneNumberstr,
            "name": fullnamestr,
            "partneruid": "",
            "mail": mailstr,
            "warehouse":"1"
        ]
     
        
        signup()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        
    }}



extension SignUpViewController{
    
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
                    self.json = try JSONSerialization.jsonObject(with: data, options: [])
                    
                   
                } catch {
                    print(error)
                }
            }
            
            }.resume()}

}
