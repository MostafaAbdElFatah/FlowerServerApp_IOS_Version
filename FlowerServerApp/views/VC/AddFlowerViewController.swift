

import UIKit

class AddFlowerViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{

    @IBOutlet weak var flowerBtn: UIButton!
    @IBOutlet weak var flowerName: UITextField!
    @IBOutlet weak var flowerCategory: UITextField!
    @IBOutlet weak var flowerPrice: UITextField!
    @IBOutlet weak var flowerInstructions: UITextField!
    override func viewDidLoad() {
        self.flowerName.delegate = self
        self.flowerCategory.delegate = self
        self.flowerPrice.delegate = self
        self.flowerInstructions.delegate = self
    }
    @IBAction func addFlowerToDatabase(_ sender: UIButton) {
        view.endEditing(true)
        guard let name = flowerName.text, flowerName.text != ""
            , let category = flowerCategory.text, flowerCategory.text != ""
            , let stringPrice = flowerPrice.text, flowerPrice.text != ""
            , let instructions = flowerInstructions.text, flowerInstructions.text != ""
            else {
                self.showAlert(title: "Error in Data...", message: "Leak of Data, please if not fill the data")
                return
        }
        
        let charsToRemove = Array("[()?:!.,;{}]+-/\\%$#~^&*?\"\'")
        var newString = String(name.filter { !charsToRemove.contains($0) })
        newString = newString.replacingOccurrences(of: " ", with: "_")
        newString.append(".png")
        let price = Float(stringPrice)!
        let id = Int(arc4random_uniform(999999999))
        let flower = Flower(productId: id, name: name, photo: newString, category: category, price: price, instructions: instructions)
        if StorageManager.addPhoto(photo: newString, image: self.flowerBtn.currentImage!) {
            DatabaseManager.pushFlower(flower: flower)
            self.flowerBtn.setImage(#imageLiteral(resourceName: "add_white"), for: .normal)
            self.flowerName.text = ""
            self.flowerCategory.text = ""
            self.flowerPrice.text = ""
            self.flowerInstructions.text = ""
        }
    }
    
    @IBAction func showPickerPhoto(_ sender: UIButton) {
        let imagePicker:UIImagePickerController = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.flowerBtn.setImage(image, for: UIControlState.normal)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - hide keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

}
