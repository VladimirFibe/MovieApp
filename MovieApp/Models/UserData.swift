
import Foundation

struct UserData {
    var name = ""
    var lastName = ""
    var email = ""
    var password = ""
    
    var isSamePassword = false
    
    var confirmPassword: String {
        get {
            return ""
        }
        set {
            if newValue == password {
                isSamePassword = true
            }
        }
    }
}
