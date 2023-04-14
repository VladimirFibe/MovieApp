//
//  Settings.swift
//  MovieApp
//
//  Created by Vladimir on 14.04.2023.
//

import Foundation

final class Settings {
    static let shared = Settings()
    private init() {}
    
    private enum Keys: String {
        case onboarded
    }
    var onboarded: Bool {
        get {
            UserDefaults.standard.bool(forKey: Keys.onboarded.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.onboarded.rawValue)
        }
    }
}
