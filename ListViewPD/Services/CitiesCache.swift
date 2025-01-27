//
//  CitiesCache.swift
//  ListViewPD
//
//  Created by Bhavesh Rathod on 27/01/25.
//

import Foundation

// MARK: - Cache Service
class CitiesCache {
    private let cacheExpirationTime: TimeInterval = Constants.cacheExpirationTime

    func saveCities(_ cities: [City]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(cities) {
            UserDefaults.standard.set(encoded, forKey: Constants.UserDefaultsKeys.cachedCities)
            UserDefaults.standard.set(Date(), forKey: Constants.UserDefaultsKeys.lastUpdated)
        }
    }

    func getCachedCities() -> [City]? {
        guard let lastUpdated = UserDefaults.standard.object(forKey: Constants.UserDefaultsKeys.lastUpdated) as? Date else {
            return nil
        }

        if Date().timeIntervalSince(lastUpdated) > cacheExpirationTime {
            return nil
        }

        if let cachedData = UserDefaults.standard.data(forKey: Constants.UserDefaultsKeys.cachedCities),
           let decodedCities = try? JSONDecoder().decode([City].self, from: cachedData) {
            return decodedCities
        }

        return nil
    }
}
