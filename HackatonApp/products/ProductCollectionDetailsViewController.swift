//done
import UIKit
import SafariServices

class ProductCollectionDetailsViewController: UIViewController {
    
    var product :ProductID?

    @IBOutlet weak var detailsProd: UILabel!
    @IBOutlet weak var labelProd: UILabel!
    @IBOutlet weak var imgprod: UIImageView!
    
    @IBAction func getSenderSegue(_ sender: UIButton) {
    }
    
    @IBAction func getReceiverSegue(_ sender: UIButton) {
    }

    @IBAction func linkBtn(_ sender: Any) {
        var url = product!.prodLink
        openProduct(link: url)
        //UIApplication.shared.open(URL(string : url)!, options: [:], completionHandler: { (status) in
        
        //   })
    }

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgprod.image = product?.prodImage
        labelProd.text = product?.prodName
        detailsProd.text = product?.prodDetails
        
    }
    

    private func openProduct(link: String) {
        guard let url = URL(string: link) else { return }
        
        let safariViewController = SFSafariViewController(url: url)
        navigationController?.present(safariViewController, animated: true, completion: nil)
    }
}

extension ProductCollectionDetailsViewController: SFSafariViewControllerDelegate {
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}
