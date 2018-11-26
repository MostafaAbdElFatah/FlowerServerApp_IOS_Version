//
//  FlowersViewController.swift
//  FlowerServerApp
//
//  Created by Mostafa AbdEl Fatah on 11/19/18.
//  Copyright © 2018 Mostafa AbdEl Fatah. All rights reserved.
//

import UIKit
import SDWebImage

class FlowersViewController: UIViewController {

    var flowersList:[Flower] = []
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        AuthManager.signIn { (message) in
            self.showAlert(title: "Auth Error", message: message)
        }
        self.loadData()
    }
    private func loadData(){
        DatabaseManager.getFlowersList { (flowers) in
            self.flowersList += flowers
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension FlowersViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.flowersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FlowerTableViewCell
        // config cell
        StorageManager.getImageURL(photo: self.flowersList[indexPath.row].photo) { (url, error) in
            if let error = error{
                self.showAlert(title: "Image Error", message: error.localizedDescription)
            }else{
                cell.flowerImageView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "loading"))
                //cell.flowerImageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "loading"))
            }
        }
        cell.flowerNameLabel.text = self.flowersList[indexPath.row].name
        cell.flowerCategoryLabel.text = self.flowersList[indexPath.row].category
        cell.flowerPriceLabel.text = "$\(self.flowersList[indexPath.row].price)"
        return cell
    }
    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.deleteFlower(row: indexPath.row)
        }
    }
    
    private func deleteFlower(row:Int){
        
        let alert = UIAlertController(title: "Deleting", message: "Are you sure you want to delete this Flower", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (alertAction) in
            let indexPath = IndexPath(row: row, section: 0)
            // Delete the row from the data source
            DatabaseManager.remove(flower: self.flowersList[indexPath.row])
            self.flowersList.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}
