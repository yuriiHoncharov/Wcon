//
//  SecureStorage.swift
//  Dogiz
//
//  Created by Novotarskii Okeksiy on 19.02.2022.
//  Copyright © 2022 Lampa. All rights reserved.
//

import Foundation

//struct SecureStorageKeys {
//    static let kAccessData = "kAccessData"
//}

//class SecureStorage {
//    private let storage: Keychainable = Keychain()
//    private let kNotFirstRun: String = "StorageNotFirstRun"
//
//    /* Need remove all data if it is first launch of app */
//    init () {
//        let keychainNotFirstRun: Bool = UserDefaults.standard.bool(forKey: kNotFirstRun)
//
//        if !keychainNotFirstRun {
//            UserDefaults.standard.set(true, forKey: kNotFirstRun)
//            removeAllData()
//        }
//    }
//
//    func load<T: Codable>(with key: String, type: T.Type) -> T? {
//        storage.load(with: key)
//    }
//
//    func save<T: Codable>(with key: String, value: T) {
//        storage.save(with: key, value: value)
//    }
//
//    func remove(with key: String) {
//        storage.remove(with: key)
//    }
//
//    private func removeAllData() {
//        storage.removeAllData()
//    }
//}
