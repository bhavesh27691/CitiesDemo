//
//  LocalCitiesManager.swift
//  ListViewPD
//
//  Created by Bhavesh Rathod on 27/01/25.
//

import Foundation

// MARK: - Parser Manager
class LocalCitiesManager: CitiesManagerProtocol {
    func fetchCities(completion: @escaping (Result<[City], Error>) -> Void) {
        if let url = Bundle.main.url(forResource: Constants.titleAndPlaceHolder.citiesFileName , withExtension: Constants.titleAndPlaceHolder.citiesFileExtension) {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let decodedCities = try decoder.decode([City].self, from: data)
                if !decodedCities.isEmpty {
                    completion(.success(decodedCities))
                }else {
                    completion(.failure(CitiesDataError.jsonParsingFailed))
                }
            } catch {
                completion(.failure(CitiesDataError.citiesNotFound))
            }
        }else {
            completion(.failure(CitiesDataError.unexpectedError))
        }
    }
}
