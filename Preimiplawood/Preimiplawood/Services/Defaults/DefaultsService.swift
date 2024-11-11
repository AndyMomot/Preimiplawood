//
//  DefaultsService.swift
//
//  Created by Andrii Momot on 16.04.2024.
//

import Foundation

final class DefaultsService {
    static let shared = DefaultsService()
    private let standard = UserDefaults.standard
    private init() {}
}

extension DefaultsService {
    var flow: RootContentView.ViewState {
        get {
            let name = standard.string(forKey: Keys.flow.rawValue) ?? ""
            return RootContentView.ViewState(rawValue: name) ?? .onboarding
        }
        set {
            standard.set(newValue.rawValue, forKey: Keys.flow.rawValue)
        }
    }
    
    var nickName: String? {
        get { standard.string(forKey: Keys.nickName.rawValue) }
        set { standard.set(newValue, forKey: Keys.nickName.rawValue) }
    }
    
    var projects: [ProjectModel] {
        get {
            guard let data = standard.object(forKey: Keys.projects.rawValue) as? Data,
                  let items = try? JSONDecoder().decode([ProjectModel].self, from: data) else {
                return []
            }
            return items
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                standard.setValue(data, forKey: Keys.projects.rawValue)
            }
        }
    }
}

extension DefaultsService {
    func removeAll() {
        if let bundleIdentifier = Bundle.main.bundleIdentifier {
            standard.removePersistentDomain(forName: bundleIdentifier)
        }
    }
}

// MARK: - Keys
extension DefaultsService {
    enum Keys: String {
        case flow
        case nickName
        case projects
    }
}
