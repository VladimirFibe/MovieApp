import Combine

enum SignUpEvent {
    case login
}

enum SignUpAction {
    case createUser(email: String, password: String, firstname: String, lastname: String)
}

final class SignUpStore: Store<SignUpEvent, SignUpAction> {
    override func handleActions(action: SignUpAction) {
        switch action {
        case let .createUser(email, password, firstname, lastname):
            statefulCall {
                await self.createUser(email: email, password: password, firstname: firstname, lastname: lastname)
            }
        }
    }
    
    private func createUser(email: String, password: String, firstname: String, lastname: String) async {
        let login = await FirebaseUserListener.shared.signUpWithEmailPassword(withEmail: email, password: password, firstname: firstname, lastname: lastname)
        print("зарегался", login)
        if login {
            print("на выход")
            sendEvent(.login)
        }
    }
}
