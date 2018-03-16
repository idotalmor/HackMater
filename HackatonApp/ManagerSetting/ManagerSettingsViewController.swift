
import UIKit
import FCAlertView

class ManagerSettingsViewController: UIViewController, FCAlertViewDelegate {
    
    //MARK: Constants
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    let ManagerToAuthenticationSegue : String = "ManagerToAuthenticationSegue"
 
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBAction func confirmBtn(_ sender: UIBarButtonItem ) {
        let alert = FCAlertView();
        
        alert.delegate = self
        alert.showAlert(inView: self,
                        withTitle:"הודעת מערכת",
                        withSubtitle:"האם לשמור את השינויים?",
                        withCustomImage:nil,
                        withDoneButtonTitle:nil,
                        andButtons:["אישור"]) // Set your button titles here
    }
    
    func FCAlertDoneButtonClicked(alertView: FCAlertView){
        // Done Button was Pressed, Perform the Action you'd like here.
    }

    func alertView(alertView: FCAlertView, clickedButtonIndex index: Int, buttonTitle title: String) {
        
        if title == "Button 1" {
            // Perform Action for Button 1
        }else if title == "Button 2"{
            // Perform Action for Button 2
        }
    }
    @IBAction func logoutBtn(_ sender: UIBarButtonItem) {
        User.remove()
        self.tabBarController?.performSegue(withIdentifier: self.ManagerToAuthenticationSegue, sender: nil)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let currentuser = delegate.currentUser else {return}
        
        nameLabel.text = currentuser.name
        // uPassLabel = currentuser.pass
        numberLabel.text = currentuser.phonenumber
        mailLabel.text = currentuser.mail
    }
}
