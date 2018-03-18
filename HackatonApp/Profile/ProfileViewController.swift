//
//  ProfileViewController.swift
//  HackatonApp
//
//  Created by ido talmor on 18/03/2018.
//  Copyright © 2018 idotalmor. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var phoneNameLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    @IBAction func sign(_ sender: Any) {
        var permission = User.current?.permission
        User.remove()
        switch (Int(permission!)){
        case 1?,2?:
            self.tabBarController?.performSegue(withIdentifier: "MainAppToAuth", sender: nil)
        case 3?:
            self.tabBarController?.performSegue(withIdentifier: "DeliveryToAuth", sender: nil)
        case 4?:            self.tabBarController?.performSegue(withIdentifier: "ManagerToAuth", sender: nil)
        default: break
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
userNameLabel.text = User.current?.name
        phoneNameLabel.text = User.current?.phonenumber
        mailLabel.text = User.current?.mail
    }


}
