//
//  City.swift
//  ListViewPD
//
//  Created by Bhavesh Rathod on 27/01/25.
//

import Foundation

// MARK: - Models
struct City: Identifiable, Codable {
    var id = UUID()
    let cityName: String
    let lat: String
    let lng: String
    let country: String
    let iso2: String
    let adminName: String
    let capital: String
    let population: String
    let populationProper: String
    
    enum CodingKeys: String, CodingKey {
        case cityName = "city"
        case lat
        case lng
        case country
        case iso2
        case adminName = "admin_name"
        case capital
        case population
        case populationProper = "population_proper"
    }
}
