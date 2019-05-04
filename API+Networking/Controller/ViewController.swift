import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let randomImageEndpoint = DogAPI.EndPoint.randomImageFromAllDogsCollection.url
        
        let task = URLSession.shared.dataTask(with: randomImageEndpoint) { (data, response, error) in
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            //TODO: - What is the right way to do this?
            let dogImage = try! decoder.decode(DogImage.self, from: data)
            
            guard let imageUrl = URL(string: dogImage.message) else { return }
            
            /*
            DogAPI.requestImageFile(url: imageUrl, completionHandler: { (image, error) in
                //TODO: - How to handle Error properly?
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            })
            */
            
            // not sure how this works... it replaces the code above
            DogAPI.requestImageFile(url: imageUrl, completionHandler: self.handleImageFileRespose(image:error:))
        }
        task.resume()
    }
    
    func handleImageFileRespose(image: UIImage?, error: Error?) {
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
    
}

