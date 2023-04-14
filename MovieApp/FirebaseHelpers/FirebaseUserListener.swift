import Foundation
import Firebase

final class FirebaseUserListener {
    static let shared = FirebaseUserListener()
    private init() {}
    
    // MARK: - Register
    func registerUser(withEmail email: String, password: String, completion: @escaping (_ error: Error?) -> Void) {
      Auth.auth().createUser(withEmail: email, password: password) { result, error in
        completion(error)
        if error == nil {
          // send verificaton email
          result?.user.sendEmailVerification { error in
            print("auth email sent with error: \(error?.localizedDescription ?? "nil")")
          }
          
          // create user and save it
          
//          if let user = result?.user {
//            let person = Person(id: user.uid, username: email, email: email, status: "Hey there, I'm using Messager")
//            Person.save(person)
//            self.savePersonToFireStore(person)
//          }
        }
      }
    }
}
