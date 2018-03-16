//
//  ResetPasswordViewController.swift
//  HackatonApp
//
//  Created by ido talmor on 18/02/2018.
//  Copyright © 2018 idotalmor. All rights reserved.
//

import UIKit

class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var resetPhoneNumber: UITextField!
    let image = UIImage(named: "icons8-google_alerts")!

    
    
    @IBAction func resetPassword(_ sender: DesignableButton) {
        misAlert(Title: "הסיסמא אופסה בהצלחה!", Message: "בדוק את תיבת הדואר הנכנס שלך", image: image)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        
    }
    
    

}
