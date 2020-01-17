import Foundation

protocol Endpoint {
    var host: String {get}
    var path: String {get}
    var queryItems: [URLQueryItem]? {get}
    
    
}

extension Endpoint {
    
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = queryItems
        
        return urlComponents.url
    }
}
