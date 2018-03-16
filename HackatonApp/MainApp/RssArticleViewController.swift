import UIKit
import WebKit

class RssArticleViewController: UIViewController{

    @IBOutlet weak var webView: WKWebView!
    var articleURL : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let strURL = articleURL.components(separatedBy: "?")[0]
        let url = URL(string: strURL)
        let request : URLRequest = URLRequest(url: url!)
        webView.load(request)

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.popToRootViewController(animated: true)
        
    }

}
