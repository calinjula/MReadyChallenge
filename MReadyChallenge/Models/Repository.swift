import Foundation

class Repository: Decodable {
    
    var name: String
    var stars: Int
    var watchers: Int
    var forks: Int
    var owner: Owner
    var htmlUrl: String
    
    enum CodingKeys: String, CodingKey {
        case name, watchers, forks, owner
        case stars = "stargazers_count"
        case htmlUrl = "html_url"
    }
}
