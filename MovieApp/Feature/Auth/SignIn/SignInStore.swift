import Combine

enum SignInEvent {
    case didLogin
}

enum SignInAction {
    case googleSignIn
}

final class SignInStore: Store<SignInEvent, SignInAction> {
    override func handleActions(action: SignInAction) {
        switch action {
        case .googleSignIn:
            statefulCall(googleSignIn)
        }
    }
    
    private func googleSignIn() async {
        let login = await FirebaseUserListener.shared.signInWithGoogle()
        if login {
            sendEvent(.didLogin)
        } else {
            print("что то не так")
        }
    }
}
