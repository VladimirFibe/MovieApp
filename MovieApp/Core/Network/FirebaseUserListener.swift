import SwiftUI
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn
import GoogleSignInSwift

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
    @Published var user: User?
    @Published var authenticationState: AuthenticationState = .unauthenticated
    @Published var displayName: String = ""
    private var authStateHandle: AuthStateDidChangeListenerHandle?
    
    private init() {
        registerAuthStateHandler()
    }
    
    func registerAuthStateHandler() {
        if authStateHandle == nil {
            authStateHandle = Auth.auth().addStateDidChangeListener { auth, user in
                self.user = user
                self.authenticationState = user == nil ? .unauthenticated : .authenticated
                self.displayName = user?.email ?? "(unknown)"
            }
        }
    }
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
    
    func signUpWithEmailPassword(withEmail email: String, password: String, firstname: String, lastname: String) async -> Bool {
        authenticationState = .authenticating
        do {
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            user = authResult.user
            let uid = authResult.user.uid
            let data: [String: Any] = [
                "email": email,
                "fistname": firstname,
                "lastname": lastname]
            try await Firestore.firestore().collection("persons").document(uid).setData(data)
            print("User: \(authResult.user.uid) signed in")
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    func signInWithGoogle() async -> Bool {
        guard let clientID = FirebaseApp.app()?.options.clientID else { fatalError("no client id") }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first,
              let rootViewController = window.rootViewController else {
            print("There is no root view controller")
            return false
        }
        do {
            let userAuthentication = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
            let user = userAuthentication.user
            guard let idToken = user.idToken else {
                print("ID token messing")
                return false
            }
            let accessToken = user.accessToken
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString,
                                                           accessToken: accessToken.tokenString)
            let result = try await Auth.auth().signIn(with: credential)
            let firebaseUser = result.user
            let uid = firebaseUser.uid
            let data: [String: Any] = ["email": firebaseUser.email ?? ""]
            try await Firestore.firestore().collection("persons").document(uid).setData(data)
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
