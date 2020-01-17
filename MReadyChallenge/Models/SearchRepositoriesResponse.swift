import Foundation

class SearchRepositoriesResponse: Decodable {
    
    var numberOfResults: Int
    var repositories: [Repository]
    
    enum CodingKeys: String, CodingKey {
        case numberOfResults = "total_count"
        case repositories = "items"
    }
}
