
import UIKit
import FCAlertView

class DeliverySettingsViewController: UIViewController, FCAlertViewDelegate {

    //MARK: Constants
    let delegate = UIApplication.shared.delegate as! AppDelegate
    let DeliveryToAuthenticationSegue : String = "DeliveryToAuthenticationSegue"

    
    var parameters : [String:String] = [:]
    var product = [Transaction]()
   // var currentUser = User()
    
    var json : Any = ""{
        didSet{
            print(json)
            guard let transaction = json as? Json else {return}
            product = [Transaction(json: transaction)]
        }
    }
    
    @IBAction func logoutBtn(_ sender: Any) {
  
        //delegate.currentUser = nil
        User.remove()
        self.tabBarController?.performSegue(withIdentifier: self.DeliveryToAuthenticationSegue, sender: nil)

    }
    @IBAction func SaveBtn(_ sender: UIBarButtonItem) {
        let alert = FCAlertView();
        
        alert.delegate = self
        alert.showAlert(inView: self,
                        withTitle:"הודעת מערכת",
                        withSubtitle:"האם לשמור את השינויים?",
                        withCustomImage:nil,
                        withDoneButtonTitle:"ביטול",
                        andButtons:["אישור"]) // Set your button titles here
    }
    
    func FCAlertDoneButtonClicked(alertView: FCAlertView){
        // Done Button was Pressed, Perform the Action you'd like here.
    }
    
    func alertView(alertView: FCAlertView, clickedButtonIndex index: Int, buttonTitle title: String) {
        
        if title == "אישור" {
            // Perform Action for Button 1
        }else if title == "ביטול"{
            // Perform Action for Button 2
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}


extension DeliverySettingsViewController {
    
    func getDeliveryTransaction(){
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
                    
                } catch {
                    print(error)
                }
            }
            
            }.resume()
    }
}

