import Foundation

enum TabItem: Int {
    case search
    case recent
    case home
    case favorite
    case profile
    
    var title: String {
        switch self {
        case .search: return "Search"
        case .recent: return "Recent"
        case .home: return "Home"
        case .favorite: return "Favorite"
        case .profile: return "Profile"
        }
    }
    
    var icon: String {
        switch self {
        case .search: return "search"
        case .recent: return "recent"
        case .home: return "home"
        case .favorite: return "favorite"
        case .profile: return "profile"
        }
    }
    
    var activeIcon: String {
        switch self {
        case .search: return "searchSelected"
        case .recent: return "recentSelected"
        case .home: return "home"
        case .favorite: return "favoriteSelected"
        case .profile: return "profileSelected"
        }
    }
}
