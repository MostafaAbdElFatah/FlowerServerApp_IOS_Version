//
//  StorageManager.swift
//  FlowerApp
//
//  Created by Mostafa AbdEl Fatah on 11/2/18.
//  Copyright © 2018 Mostafa AbdEl Fatah. All rights reserved.
//

import Foundation
import Firebase

struct StorageManager {
    
    private static let root = Storage.storage().reference()
    
    static func getImageURL(photo:String,completion:@escaping (URL?, Error?)->()){
        let flower = root.child("flowers/\(photo)")
        flower.downloadURL { (url, error) in
            if error != nil{
                completion(nil, error)
            }else if let url = url {
                completion(url, nil)
            }
        }
        
    }
    
    static func addPhoto(photo:String,image:UIImage)->Bool{
        if let data = UIImagePNGRepresentation(image) {
            root.child("flowers/\(photo)").putData(data)
            return true
        }
        return false
    }
    
    static func removePhoto(photo:String){
        root.child("flowers/\(photo)").delete(completion: nil)
    }

    
}
