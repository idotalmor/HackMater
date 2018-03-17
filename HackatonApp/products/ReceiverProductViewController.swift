//
//  HackatonApp
//
//  Created by ido talmor on 17/03/2018.
//  Copyright © 2018 idotalmor. All rights reserved.
//done

import UIKit

class ReceiverProductViewController: UIViewController {
    
    var transaction :Transaction?
    
    @IBOutlet weak var productImageView: DesignableImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var expirationDateLabel: UILabel!
    @IBOutlet weak var productDescription: UITextView!
    
    @IBAction func toPopup(_ sender: UIButton) {
        performSegue(withIdentifier: "ReceiverFormPopup", sender: self)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let product = Products().search(forBarcode: (transaction?.product)!)
        productImageView.image = product?.prodImage
        productNameLabel.text = product?.prodName
        expirationDateLabel.text = SecToDate(timeStamp: (transaction?.expirationdate)!)
        productDescription.text = product?.prodDetails
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let dest = segue.destination as? ReceiverFormViewController else {return}
        dest.transaction = transaction
    }
}


