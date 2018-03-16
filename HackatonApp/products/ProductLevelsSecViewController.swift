
import UIKit
import SafariServices

class ProductLevelsSecViewController: UIViewController {
    
    @IBOutlet weak var linkMaterna: UIButton!

    @IBOutlet weak var detailsProd: UILabel!
    @IBOutlet weak var labelProd: UILabel!
    @IBOutlet weak var imgprod: UIImageView!
    
    var url: String = ""
    
    @IBAction func getSenderSegue(_ sender: UIButton) {
        
        
    }
    
    @IBAction func getReceiverSegue(_ sender: UIButton) {
        
        
    }

    var product :ProductID?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgprod.image = product?.prodImage
        labelProd.text = product?.prodName
        detailsProd.text = product?.prodDetails
        
        let text = "לחץ כאן"
        linkMaterna.setTitle( "לחץ כאן", for: .normal)
        linkMaterna.isUserInteractionEnabled = true
        linkMaterna.addTarget(self, action: #selector(toSite(uibtn:)), for: .touchUpInside)
        //linkMaterna.dataDetectorTypes = UIDataDetectorTypes.link
        
        /// Notes:
        /// 1. Change textView to UIButton
        /// 2. Add a target
        /// Open product?.prodLiunk using SafariServices
       
        let range = (text as NSString).range(of: text)
        let attributes = NSMutableAttributedString(string: text)
        attributes.addAttribute(NSAttributedStringKey.link, value: product?.prodLink ?? "", range: range)
        //linkMaterna.attributedText = attributes
    }
    
    @objc func toSite(uibtn : UIButton){
        //linkMaterna.dataDetectorTypes = UIDataDetectorTypes.link
        //safa
        url = product!.prodLink
        UIApplication.shared.open(URL(string : url)!, options: [:], completionHandler: { (status) in
            
        })
    }
    /// Comment this will be sorted later!!
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.navigationController?.popToRootViewController(animated: true)
//        
//    }

    private func openProduct(link: String) {
        guard let url = URL(string: link) else { return }
        
        let safariViewController = SFSafariViewController(url: url)
        navigationController?.present(safariViewController, animated: true, completion: nil)
    }
}

extension ProductLevelsSecViewController: SFSafariViewControllerDelegate {
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}
