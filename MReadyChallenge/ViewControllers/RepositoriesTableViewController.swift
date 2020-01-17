import UIKit

class RepositoriesTableViewController: UITableViewController {

    var repositories = [Repository]()
    let networkManager = NetworkManager()
    var currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let loadingAlert = LoadingAlert.loadingAlert
        self.present(loadingAlert, animated: true, completion: nil)
        fetchRepositories() {
            loadingAlert.dismiss(animated: true, completion: nil)
        }
    }

    //MARK: Data sources
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repositories.count
    }
    
    //MARK: UITableView Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCell", for: indexPath) as? RepositoryTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(for: repositories[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == repositories.count - 1 {
            
            let spinner = UIActivityIndicatorView(style: .medium)
            spinner.startAnimating()
            tableView.tableFooterView = spinner
            
            currentPage += 1
           
            fetchRepositories() {
                tableView.tableFooterView = nil
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedRepo = repositories[indexPath.row]
        performSegue(withIdentifier: "repoDetailsSegue", sender: selectedRepo)
        
    }
    
    //MARK: Fetch data
    func fetchRepositories(completion: @escaping () -> ()) {
        networkManager.fetchRepositories(for: [.objC, .swift], orderedBy: .stars, page: currentPage) { repos in
            if let fetchedRepos = repos {
                self.repositories.append(contentsOf: fetchedRepos)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    completion()
                }
            } else {
                let alert = UIAlertController(title: "Error", message: "There was an error when fetching the data", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .destructive, handler: nil))
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: completion)
                }
            }
        }
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "repoDetailsSegue" {
            guard let destination = segue.destination as? RepoDetailsViewController else { return }
            destination.repository = sender as? Repository
        }
    }
    
}
