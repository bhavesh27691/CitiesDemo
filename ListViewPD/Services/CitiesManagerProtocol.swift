//
//  CitiesManagerProtocol.swift
//  ListViewPD
//
//  Created by Bhavesh Rathod on 27/01/25.
//

import Foundation

// MARK: - Protocols
protocol CitiesManagerProtocol {
    func fetchCities(completion: @escaping (Result<[City], Error>) -> Void)
}
