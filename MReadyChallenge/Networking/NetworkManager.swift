import Foundation

class NetworkManager {
    
    func fetchRepositories(for languages: [Language], orderedBy: RepoOrderBy, page: Int, completionHandler: @escaping ([Repository]?) -> ()) {
        guard let searchRequest = Request.searchRepos(for: languages, orderedBy: orderedBy, page: page) else { return }
        URLSession.shared.dataTask(with: searchRequest) { (data, response, error) in
            if error != nil || data == nil {
                completionHandler(nil)
                return
            }
            
            if (response as? HTTPURLResponse)?.statusCode != 200 {
                completionHandler(nil)
                return
            }
            
            do {
                //Okay to force since we checked for nil earlier
                let requestResponse = try JSONDecoder().decode(SearchRepositoriesResponse.self, from: data!)
                completionHandler(requestResponse.repositories)
            } catch {
                print("error while decoding: \(error)")
                completionHandler(nil)
            }
            
        }.resume()
    }
    
    func fetchReadme(for repo: Repository, completionHandler: @escaping (String?) -> ()) {
        guard let readMeRequest = Request.getReadme(for: repo) else { return }
        URLSession.shared.dataTask(with: readMeRequest) { (data, response, error) in
            if error != nil || data == nil {
                completionHandler(nil)
                return
            }
            if (response as? HTTPURLResponse)?.statusCode != 200 {
                completionHandler(nil)
                return
            }
            
            completionHandler(String(data: data!, encoding: .utf8))
        }.resume()
    }
    
}


