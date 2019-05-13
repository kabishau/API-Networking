import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    let breeds: [String] = ["greyhound", "poodle", "bluetick", "boxer", "mastiff"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        /*
        let randomImageEndpoint = DogAPI.EndPoint.randomImageFromAllDogsCollection.url
        
        DogAPI.requestRandomImage(from: randomImageEndpoint) { (dogImage, error) in
            self.handleRandomImageResponse(dogImage: dogImage, error: error)
        }
        */
        
        // same thing as above - it's cleaner but I need to get used to this syntax
        //DogAPI.requestRandomImage(from: randomImageEndpoint, completion: handleRandomImageResponse(dogImage:error:))
    }
    
    func handleRandomImageResponse(dogImage: DogImage?, error: Error?) {
        
        guard let dogImage = dogImage,
              let imageUrl = URL(string: dogImage.message) else { return }
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

extension ViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return breeds[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let url = DogAPI.EndPoint.randomImageForBreed(breeds[row]).url
        
        DogAPI.requestRandomImage(from: url) { (dogImage, error) in
            self.handleRandomImageResponse(dogImage: dogImage, error: error)
        }
    }
}

extension ViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return breeds.count
    }
    
    
}
