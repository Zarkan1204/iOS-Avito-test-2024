//
//  UserDefaultsManager.swift
//  iOS-Avito-test-2024


import Foundation

struct UserDefaultsManager {
    private let userDefaults: UserDefaults = .standard
    private let jsonEncoder = JSONEncoder()
    private let jsonDecoder = JSONDecoder()
    private let key: String = "lastRequests"


    func save(data: String) {
        
        var lastRequestsNames = getLastRequests()
        
        guard !lastRequestsNames.contains(data) else { return }

        if lastRequestsNames.count >= 5 {
            lastRequestsNames.removeLast()
        }
        lastRequestsNames.insert(data, at: 0)

        do {
            let encodeData = try jsonEncoder.encode(lastRequestsNames)
            userDefaults.set(encodeData, forKey: key)
        } catch {
            print("UserDefaults save error: " + error.localizedDescription)
        }
    }

    func getLastRequests() -> [String] {
        do {
            if let data = userDefaults.data(forKey: key) {
                let decodedData = try jsonDecoder.decode([String].self, from: data)
                return decodedData
            }
        } catch {
            print("UserDefaults read error: " + error.localizedDescription)
        }
        return []
    }
}

