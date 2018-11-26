
import Foundation
import Firebase

struct DatabaseManager {
    
    private static let root = Database.database().reference()
    private static let users = root.child("users")
    private static let flowers = root.child("flowers")
    private static let orders = users.child(AuthManager.getUserId()!).child("orders")
    
    ///
    private static var flowerSnapshot:DataSnapshot = DataSnapshot()
    
    
    
    // MARK:- Save user info to firebase database
    static func saveUserInfo(userName:String, phone:String){
        let user = users.child(AuthManager.getUserId()!)
        user.child("name").setValue(userName)
        user.child("phone").setValue(phone)
        user.child("address").setValue("No ADDRESS")
    }
    
    static func saveDeviceToken() {
        users.child(AuthManager.getUserId()!).child("device_token").setValue("")
    }
    
    // set address in firebase database
    static func saveAddress(address:String){
        users.child(AuthManager.getUserId()!).child("address").setValue(address)
    }
    
    // MARK:- save order in database
    static func saveOrder(order:Order){
        let dbOrder = orders.childByAutoId()
        dbOrder.setValue([ OrderKeysNames.id:dbOrder.key!,
                           OrderKeysNames.name:order.flowerName,
                           OrderKeysNames.payment:order.payment,
                           OrderKeysNames.discount:order.discount,
                           OrderKeysNames.price:order.totalPrice,
                           OrderKeysNames.quantity:order.quantity,
                           OrderKeysNames.status:order.status])
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
    
    // MARK:- get orders list
    static func getOrdersList(completion:@escaping (_ ordersList:[Order])->()){
        
         orders.observeSingleEvent(of: .value) { (snapshot) in
             var orders:[Order] = []
             if let data = snapshot.value as? [String:AnyObject] {
                 for value in data.values {
                         let id = value[OrderKeysNames.id] as! String
                         let name = value[OrderKeysNames.name] as! String
                         let payment = value[OrderKeysNames.payment] as! String
                         let status = value[OrderKeysNames.status] as! Bool
                         let price = (value[OrderKeysNames.price] as! NSNumber).floatValue
                         let quantity = (value[OrderKeysNames.quantity] as! NSNumber).intValue
                         let discount = (value[OrderKeysNames.discount] as! NSNumber).intValue
                         orders.append(Order(id: id, flowerName: name, payment: payment, quantity: quantity, status: status, totalPrice: price, discount: discount))
                }
                completion(orders)
            }
         }
       ////
    }
    
    /// MARK:- remove flower
    
    static func remove(flower:Flower) {
        if let key = getKey(id: flower.productId) {
            flowers.child(key).removeValue()
            StorageManager.removePhoto(child: "flowers/"+flower.photo )
        }

    }
    
    
    static func getKey(id:Int) -> String? {
        
        if let data = flowerSnapshot.value as? [String:AnyObject] {
            for value in data.values {
                let flowerid = value[FlowerKeysNames.id] as! Int
                if id == flowerid {
                    return value.key
                }
            }
        }
        return ""
    }
    
}

 
 
 
 
 
 
 
 









 
 
 
