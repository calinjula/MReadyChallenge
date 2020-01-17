import Foundation

enum Language: String {
    case swift = "swift"
    case objC = "objc"
    
    static func generateQueryString(for languages: [Language]) -> String {
        if languages.isEmpty {
            return ""
        } else {
            var queryString = "language:\(languages[0].rawValue)"
            for language in languages {
                queryString.append("+language:\(language.rawValue)")
            }
            return queryString
        }
    }
}
