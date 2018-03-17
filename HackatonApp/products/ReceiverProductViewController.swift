//
//  HackatonApp
//
//  Created by ido talmor on 17/03/2018.
//  Copyright © 2018 idotalmor. All rights reserved.
//

import UIKit

class ReceiverProductViewController: UIViewController {

    var transaction :Transaction?
    var parameters : [String:String] = [:]
    @IBOutlet weak var productImageView: DesignableImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var expirationDateLabel: UILabel!
    @IBOutlet weak var productDescription: UITextView!
    

    var json : Any = ""{
        didSet{
            
                }
        
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var product = Products().search(forBarcode: (transaction?.product)!)
        productImageView.image = product?.prodImage
        productNameLabel.text = product?.prodName
        expirationDateLabel.text = SecToDate(timeStamp: (transaction?.expirationdate)!)
        productDescription.text = product?.prodDetails

        // Do any additional setup after loading the view.
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.popToRootViewController(animated: false)
    }
    

}

extension ReceiverProductViewController {
    
    func getWaitingForReceiverTransactions(){
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
