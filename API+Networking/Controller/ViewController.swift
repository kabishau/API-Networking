import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let randomImageEndpoint = DogAPI.EndPoint.randomImageFromAllDogsCollection.url
        
        DogAPI.requestRandomImage(from: randomImageEndpoint) { (dogImage, error) in
            self.handleRandomImageResponse(dogImage: dogImage, error: error)
        }
        
        // same thing as above - it's cleaner but I need to get used to this syntax
        //DogAPI.requestRandomImage(from: randomImageEndpoint, completion: handleRandomImageResponse(dogImage:error:))
    }
    
    func handleRandomImageResponse(dogImage: DogImage?, error: Error?) {
        guard let dogImage = dogImage, let imageUrl = URL(string: dogImage.message) else { return }
        // passing func into completionHandler - syntax looks weird...
        // do func and completion have same type?
        DogAPI.requestImageFile(url: imageUrl, completion: self.handleImageFileRespose(image:error:))
    }
    
    func handleImageFileRespose(image: UIImage?, error: Error?) {
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
    
}

