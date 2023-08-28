import UIKit

protocol AppFontProtocol {
    var rawValue: String { get }
}

extension AppFontProtocol {

    func s10() -> UIFont {
        return apply(size: 10)
    }

    func s12() -> UIFont {
        return apply(size: 12)
    }

    func s14() -> UIFont {
        return apply(size: 14)
    }

    func s15() -> UIFont {
        return apply(size: 15)
    }

    func s16() -> UIFont {
        return apply(size: 16)
    }

    func s18() -> UIFont {
        return apply(size: 18)
    }

    func s20() -> UIFont {
        return apply(size: 20)
    }

    func s22() -> UIFont {
        return apply(size: 22)
    }

    func s24() -> UIFont {
        return apply(size: 24)
    }

    func s26() -> UIFont {
        return apply(size: 26)
    }

    func s28() -> UIFont {
        return apply(size: 28)
    }

    func s32() -> UIFont {
        return apply(size: 32)
    }

    func s36() -> UIFont {
        return apply(size: 36)
    }

    func s37() -> UIFont {
        return apply(size: 37)
    }
}

extension AppFontProtocol {

    private func apply(size value: CGFloat) -> UIFont {
        UIFont.init(name: rawValue, size: value) ?? .systemFont(ofSize: value)
    }
}

enum AppFont: String, AppFontProtocol {
    case regular = "PlusJakartaSans-Regular"
    case medium = "PlusJakartaSans-Medium"
    case semibold = "PlusJakartaSans-SemiBold"
    case bold = "PlusJakartaSans-Bold"
}
