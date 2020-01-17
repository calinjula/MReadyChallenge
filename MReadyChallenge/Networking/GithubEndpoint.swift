import Foundation

class GithubEndpoint: Endpoint {
    
    let host: String
    let path: String
    let queryItems: [URLQueryItem]?
    
    init(path: String, queryItems: [URLQueryItem]? = nil) {
        self.host = "api.github.com"
        self.path = path
        self.queryItems = queryItems
    }
    
}
