import Combine

enum SettingsEvent {
    case didLogout
}

enum SettingsAction {
    case logout
}
final class SettingsStore: Store<SettingsEvent, SettingsAction> {
    override func handleActions(action: SettingsAction) {
        switch action {
        case .logout: statefulCall(logout)
        }
    }
    
    private func logout() async {
        await FirebaseUserListener.shared.signOut()
        sendEvent(.didLogout)
    }
}
