import Foundation

struct DogImage: Codable {
    
    let status: String
    let message: String
}

struct BreedListResponse: Codable {
    
    let status: String
    let message: [String: [String]]
}
