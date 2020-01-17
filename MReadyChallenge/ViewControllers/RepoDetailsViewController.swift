import UIKit
import WebKit

class RepoDetailsViewController: UIViewController {
    
    var repository: Repository?
    
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var watchersLabel: UILabel!
    @IBOutlet weak var linkButton: UIButton!
    @IBOutlet weak var readMeView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = repository?.name
        configureView()
        fetchReadme()
    }
    
    //MARK: Actions
    @IBAction func linkButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "webLinkSegue", sender: nil)
    }

    //MARK: View Configurations
    func configureView() {
        userLabel.text = repository?.owner.login
        forksLabel.text = String(repository?.forks ?? 0)
        watchersLabel.text = String(repository?.watchers ?? 0)
        linkButton.setTitle(repository?.htmlUrl, for: .normal)
    }
    
    //MARK: Fetch Data
    func fetchReadme() {
        let networkManager = NetworkManager()
        guard let repo = repository else { return }
        networkManager.fetchReadme(for: repo) { htmlString in
            if htmlString != nil {
                DispatchQueue.main.async {
                    self.readMeView.loadHTMLString(htmlString!, baseURL: nil)
                }
            } else {
                let alert = UIAlertController(title: "Error", message: "Could not load ReadME", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .destructive, handler: nil))
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    

    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "webLinkSegue" {
            guard let destination = segue.destination as? ViewLinkViewController,
                let repoUrl = repository?.htmlUrl else { return }
            destination.urlToShow = URL(string: repoUrl)
        }
    }
}
