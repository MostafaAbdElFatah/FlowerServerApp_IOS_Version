import UIKit

struct OrderKeysNames {
    static let id = "id"
    static let name = "flowerName"
    static let payment = "payment"
    static let quantity = "quantity"
    static let status = "status"
    static let price = "totalPrice"
    static let discount = "discount"
}

struct FlowerKeysNames {    
    static let id = "productId"
    static let name = "name"
    static let category = "category"
    static let price = "price"
    static let photo = "photo"
    static let instructions = "instructions"
}

struct UserKeysNames {
    static let name = "name"
    static let address = "address"
    static let phone = "phone"
    static let device_token = "device_token"
}

struct UserInfo {
    var name:String
    var address:String
    var phone:String
    var device_token:String
}

struct Order {
    var id:String
    var flowerName:String
    var payment:String
    var quantity:Int
    var status:Bool
    var totalPrice:Float
    var discount:Int
}

struct Flower {
    var productId:Int
    var name:String
    var photo:String
    var category:String
    var price:Float
    var instructions:String
}
