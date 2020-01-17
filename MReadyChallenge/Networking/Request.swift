import Foundation

class Request {
    
    static private var githubToken = "27e531545805c9128232de716c07f76b9adfcff7"
    
    static func searchRepos(for languages: [Language], orderedBy: RepoOrderBy, page: Int) -> URLRequest? {
        
        let githubEndpoint = GithubEndpoint(path: "/search/repositories", queryItems: [
            URLQueryItem(name: "q", value: Language.generateQueryString(for: languages)),
            URLQueryItem(name: "sort", value: orderedBy.rawValue),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "per_page", value: "10")
        ])
        
        guard let searchUrl = githubEndpoint.url else { return nil }
        var request = URLRequest(url: searchUrl)
        request.addValue("Token \(githubToken)", forHTTPHeaderField: "Authorization")
        return request
    }
    
    static func getReadme(for repository: Repository) -> URLRequest? {
        
        let githubEndpoint = GithubEndpoint(path: "/repos/\(repository.owner.login)/\(repository.name)/readme")
        
        guard let readMeUrl = githubEndpoint.url else { return nil }
        
        var request = URLRequest(url: readMeUrl)
        request.addValue("Token \(githubToken)", forHTTPHeaderField: "Authorization")
        request.addValue("application/vnd.github.VERSION.html", forHTTPHeaderField: "Accept")
        return request
    }
}
