//
//  Constants.swift
//  ListViewPD
//
//  Created by Bhavesh Rathod on 27/01/25.
//

import Foundation

// MARK: - Constants
enum Constants {
    
    struct titleAndPlaceHolder {
        static let citiesFileName = "au_cities"
        static let citiesFileExtension = "json"
        static let screenTitle = "Australian Cities"
        static let alertTitle = "Error"
        static let alertActionOK = "OK"
        static let searchBarPlaceHolder = "Search cities"
    }
    
    static let cacheExpirationTime: TimeInterval = 60 * 60
    
    struct UserDefaultsKeys {
        static let cachedCities = "cachedCities"
        static let lastUpdated = "lastUpdated"
    }
    
    struct JsonsErrorMessages {
        static let citiesNotFound = "Cities data not found. The file or API response is empty or missing."
        static let jsonParsingFailed = "Failed to parse cities data. Please check the JSON format."
        static let unexpectedError = "An unexpected error occurred while loading the cities data. Please try again later."
    }
    
    struct ImagesNames {
        static let reverseImg = "arrow.up.arrow.down"
        static let arrowDown = "chevron.down"
        static let arrowRight = "chevron.right"
        static let population = "location"
        static let location = "person.3"
    }
}


