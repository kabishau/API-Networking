import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let randomImageEndpoint = DogAPI.EndPoint.randomImageFromAllDogsCollection.url
        
        /*
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
        */
        
        let task = URLSession.shared.dataTask(with: randomImageEndpoint) { (data, response, error) in
            guard let data = data else { return }

            let decoder = JSONDecoder()
            let dogImage = try! decoder.decode(DogImage.self, from: data)
            
            guard let imageUrl = URL(string: dogImage.message) else { return }
            print(imageUrl)
            let task = URLSession.shared.dataTask(with: imageUrl, completionHandler: { (data, response, error) in
                guard let data = data else { return }
                let downloadedImage = UIImage(data: data)
                
                DispatchQueue.main.async {
                    self.imageView.image = downloadedImage
                }
                
            })
            task.resume()
            
        }
        task.resume()
    }

}

