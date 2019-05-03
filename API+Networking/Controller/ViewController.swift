import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let randomImageEndpoint = DogAPI.EndPoint.randomImageFromAllDogsCollection.url
        
        let task = URLSession.shared.dataTask(with: randomImageEndpoint) { (data, response, error) in
            guard let data = data else { return }
            print(data)
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                print(json)
                let stringUrl = json["message"] as! String
                print(stringUrl)
            } catch {
                print(error)
            }
        }
        task.resume()
    }

}

