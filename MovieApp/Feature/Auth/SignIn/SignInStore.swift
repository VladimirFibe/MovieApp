import Combine

enum SignInEvent {
    case didLogin
}

enum SignInAction {
    case signIn(String, String)
    case googleSignIn
}

final class SignInStore: Store<SignInEvent, SignInAction> {
    override func handleActions(action: SignInAction) {
        switch action {
        case let .signIn(email, password):
            statefulCall {
                await self.sigIn(withEmail: email, password: password)
            }
        case .googleSignIn:
            statefulCall(googleSignIn)
        }
    }
    
    private func sigIn(withEmail email: String, password: String) async {
        let login = await FirebaseUserListener.shared.signInWithEmailPassword(withEmail: email, password: password)
        if login {
            sendEvent(.didLogin)
        } else {
            print("что то не так")
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
