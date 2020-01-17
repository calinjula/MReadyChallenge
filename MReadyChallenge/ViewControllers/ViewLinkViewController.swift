import UIKit
import WebKit

class ViewLinkViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
   
    var urlToShow: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = urlToShow else { return }
        let request = URLRequest(url: url)
        self.webView.load(request)
    }
    

}
