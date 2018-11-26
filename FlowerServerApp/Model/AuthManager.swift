import Foundation
import FirebaseAuth

struct AuthManager {
    
    // MARK:- log in to an existing account
    static func signIn(completion:@escaping (String)->()){
        let email = "admin@gmail.com"
        let password = "admin1"
        Auth.auth().signIn(withEmail: email, password: password) { (authDataResult, error) in
            if let error = error {
                print("AUTH ERROR:\(error)")
                completion("\(error.localizedDescription)")
            }
        }
    }
    // MARK:- get user info
    static func getUserId()->String?{
        return Auth.auth().currentUser?.uid
    }
    
    static func getUser()->User?{
        return Auth.auth().currentUser
    }
    
    // MARK:- when auth changed
    static func authChanged(completion:@escaping (Auth,User?)->()){
        Auth.auth().addStateDidChangeListener { (auth, user) in
            completion(auth, Auth.auth().currentUser)
        }
    }
}
