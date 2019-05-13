import Foundation
import UIKit

class DogAPI {
    
    enum EndPoint {
        
        case randomImageFromAllDogsCollection
        case randomImageForBreed(String)
        
        // computed property kind of do the same as rawValues but helps with building dynamic URL
        var stringValue: String {
            switch self {
            case .randomImageFromAllDogsCollection:
                return "https://dog.ceo/api/breeds/image/random"
            case .randomImageForBreed(let breed):
                return "https://dog.ceo/api/breed/\(breed)/images/random"
            }
        }
        
        var url: URL {
            return URL(string: self.stringValue)!
        }
    }
    
    class func requestRandomImage(from url: URL, completion: @escaping (DogImage?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            let decoder = JSONDecoder()
            
            //TODO: - What is the right way to handle "try!"?
            let dogImage = try! decoder.decode(DogImage.self, from: data)
            
            completion(dogImage, nil)
            
        }
        task.resume()
    }
    
    // this is helper fuction
    class func requestImageFile(url: URL, completion: @escaping (UIImage?, Error?) -> Void) {
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion(nil, error)
                return
            }
            let downloadedImage = UIImage(data: data)
            completion(downloadedImage, nil)
        }
        task.resume()
    }
}
