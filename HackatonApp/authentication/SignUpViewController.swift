import UIKit
import FCAlertView

class SignUpViewController: UIViewController {
    
    //must
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var password: UITextField!
    //optional
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var mail: UITextField!
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    var parameters : [String:Any]?
    var permision =  "1"
    var warehouse = "1"
    
    
  
    
    var user: User? {
        didSet {
            delegate.currentUser = user
            switch(delegate.currentUser?.permission ?? "5"){
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
            let passwordstr = password.text,
            //let adrressstr = address.text,
            let mailstr = mail.text else {return}
    
     
        
        if phoneNumberstr != "" && passwordstr != "" &&  fullnamestr != ""{
            
            permision = "2"
        }else if(passwordstr == "4" && phoneNumberstr != ""){
            
            permision = "4"
            parameters!["warehouse"] = "1"
            
        }else if(passwordstr == "3" && phoneNumberstr != ""){
            permision = "3"
            parameters!["warehouse"] = "1"

        }
        
        
        print(parameters)
        signup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                    self.user = try JSONDecoder().decode(User.self, from: data)
                    
                   
                } catch {
                    print(error)
                }
            }
            
            }.resume()}

}
