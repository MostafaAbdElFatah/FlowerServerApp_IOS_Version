
import Foundation
import Firebase

struct DatabaseManager {
    
    private static let root = Database.database().reference()
    private static let users = root.child("users")
    private static let flowers = root.child("flowers")
    private static let orders = users.child(AuthManager.getUserId()!).child("orders")
    
    ///
    private static var flowerSnapshot:DataSnapshot = DataSnapshot()
    
    
    // set new flower in firebase database
    static func pushFlower(flower:Flower){
        let flowerDb = flowers.childByAutoId()
        flowerDb.setValue([ FlowerKeysNames.id:flower.productId
            , FlowerKeysNames.name:flower.name
            , FlowerKeysNames.category:flower.category
            , FlowerKeysNames.price:flower.price
            , FlowerKeysNames.photo:flower.photo
            , FlowerKeysNames.instructions:flower.instructions])
    }
    
   
    
    /// MARK:- remove flower
    
    static func remove(flower:Flower) {
        if let key = getKey(id: flower.productId) {
            flowers.child(key).removeValue()
            StorageManager.removePhoto(photo: flower.photo )
        }
        
    }
    
    
    static func getKey(id:Int) -> String? {
        if let data = flowerSnapshot.value as? [String:AnyObject] {
            for item in data{
                let value = item.value
                let flowerid = value[FlowerKeysNames.id] as! Int
                if id == flowerid {
                    return item.key
                }
            }
        }
        return ""
    }
    
    
    // MARK:- get User info
    static func getUserInfo(completion:@escaping (_ flowersList:UserInfo?)->()){
        users.child(AuthManager.getUserId()!).observeSingleEvent(of: .value) { (snapshot) in
            if let data = snapshot.value as? [String:AnyObject] {
                let name = data[UserKeysNames.name] as! String
                let address = data[UserKeysNames.address] as! String
                let phone = data[UserKeysNames.phone] as! String
                let device_token = data[UserKeysNames.device_token] as! String
                completion(UserInfo(name: name, address: address, phone: phone, device_token: device_token))
            }else {
                completion(nil)
            }
        }
    }
    // MARK:- get flowers list
    static func getFlowersList(completion:@escaping (_ flowersList:[Flower])->()){
        flowers.observeSingleEvent(of: .value) { (snapshot) in
            flowerSnapshot = snapshot
            var flowers:[Flower] = []
            if let data = snapshot.value as? [String:AnyObject] {
                for value in data.values {
                    let id = value[FlowerKeysNames.id] as! Int
                    let name = value[FlowerKeysNames.name] as! String
                    let category = value[FlowerKeysNames.category] as! String
                    let price = (value[FlowerKeysNames.price] as! NSNumber).floatValue
                    let photo = value[FlowerKeysNames.photo] as! String
                    let instructions = value[FlowerKeysNames.instructions] as! String
                    flowers.append(Flower(productId: id, name: name, photo: photo, category: category, price: price, instructions: instructions))
                }
                completion(flowers)
            }
        }
    }
    //remove order from firbase
    static func removeOrder(order:Order) {
        orders.child(order.id).removeValue();
    }
    

    
}

 
 
 
 
 
 
 
 









 
 
 
