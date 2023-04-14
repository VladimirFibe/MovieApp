import SwiftUI
import Firebase

enum AuthenticationState {
  case unauthenticated
  case authenticating
  case authenticated
}

enum AuthenticationFlow {
  case login
  case signUp
}

@MainActor
final class FirebaseUserListener: ObservableObject {
    static let shared = FirebaseUserListener()
    private init() {}
    
    @Published var user: User?
    @Published var authenticationState: AuthenticationState = .unauthenticated

}

extension FirebaseUserListener {
    func signInWithEmailPassword(withEmail email: String, password: String) async -> Bool {
        authenticationState = .authenticating
        do {
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
            user = authResult.user
            print("User: \(authResult.user.uid) signed in")
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    func signUpWithEmailPassword(withEmail email: String, password: String) async -> Bool {
        authenticationState = .authenticating
        do {
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            user = authResult.user
            print("User: \(authResult.user.uid) signed in")
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteAccount() async -> Bool {
        do {
            try await user?.delete()
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
}
