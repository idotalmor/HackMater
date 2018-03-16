import UIKit

class ProfileViewController: UIViewController {
    
    
    //MARK: Constants
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var uNameLabel: UILabel!
    @IBOutlet weak var uPassLabel: UILabel!
    @IBOutlet weak var uPhoneLabel: UILabel!
    @IBOutlet weak var uMailLabel: UILabel!

    
    
    let MainAppToAuthenticationSegue : String = "MainAppToAuthenticationSegue"
    
    @IBOutlet weak var profileImg: DesignableImageView!
 
    
    @IBAction func logoutBtn(_ sender: UIBarButtonItem) {
        
            User.remove()
            self.tabBarController?.performSegue(withIdentifier: self.MainAppToAuthenticationSegue, sender: nil)
    }
    
    @IBAction func saveDetails(_ sender: UIBarButtonItem) {
        
        
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let currentuser = delegate.currentUser else {return}
        
        uNameLabel.text = currentuser.name
        // uPassLabel = currentuser.pass
        uPhoneLabel.text = currentuser.phonenumber
        uMailLabel.text = currentuser.mail

  
        
    }
}
