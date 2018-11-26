//
//  OrdersViewController.swift
//  FlowerServerApp
//
//  Created by Mostafa AbdEl Fatah on 11/19/18.
//  Copyright © 2018 Mostafa AbdEl Fatah. All rights reserved.
//

import UIKit

class AddFlowerViewController: UIViewController {

    @IBOutlet weak var flowerName: UITextField!
    @IBOutlet weak var flowerCategory: UITextField!
    @IBOutlet weak var flowerPrice: UITextField!
    
    @IBOutlet weak var flowerInstructions: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showPickerPhoto(_ sender: UIButton) {
    }
    
    @IBAction func addFlowerToDatabase(_ sender: UIButton) {
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
