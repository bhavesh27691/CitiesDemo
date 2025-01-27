//
//  CitiesViewModelTests.swift
//  ListViewPDTests
//
//  Created by Bhavesh Rathod on 27/01/25.
//

import XCTest
@testable import ListViewPD

class MockCitiesManager: CitiesManagerProtocol {
    var result: Result<[City], Error>?

    func fetchCities(completion: @escaping (Result<[City], Error>) -> Void) {
        if let result = result {
            completion(result)
        }
    }
}

class MockCitiesCache: CitiesCache {
    var cachedCities: [City]?

    override func getCachedCities() -> [City]? {
        return cachedCities
    }

    override func saveCities(_ cities: [City]) {
        cachedCities = cities
    }
}

final class CitiesViewModelTests: XCTestCase {
    
    var viewModel: CitiesViewModel!
    var mockManager: MockCitiesManager!
    var mockCache: MockCitiesCache!

    override func setUp() {
        super.setUp()
        mockManager = MockCitiesManager()
        mockCache = MockCitiesCache()
        viewModel = CitiesViewModel(objDataManager: mockManager, cache: mockCache)
    }

    override func tearDown() {
        viewModel = nil
        mockManager = nil
        mockCache = nil
        super.tearDown()
    }

    func testLoadCities_WithCachedData() {
        let mockCities = [
            City(cityName: "Ahmedabad", lat: "0.0", lng: "0.0", country: "India", iso2: "", adminName: "Gujarat", capital: "Gandhinagar", population: "100000", populationProper: "10000"),
            City(cityName: "Baroda", lat: "0.0", lng: "0.0", country: "India", iso2: "", adminName: "Gujarat", capital: "Gandhinagar", population: "100000", populationProper: "10000"),
            City(cityName: "Mumbai", lat: "0.0", lng: "0.0", country: "India", iso2: "", adminName: "Maharashtra", capital: "Mumbai", population: "100000", populationProper: "10000"),
            City(cityName: "Udaypur", lat: "0.0", lng: "0.0", country: "India", iso2: "", adminName: "Rajashthan", capital: "Jodhpur", population: "100000", populationProper: "10000")
        ]
        mockCache.cachedCities = mockCities

        viewModel.loadCities()

        XCTAssertEqual(viewModel.cities.count, 4)
        XCTAssertEqual(viewModel.sections.count, 3)
    }

    func testLoadCities_WithNoCachedData() {
        let mockCities = [
            City(cityName: "Ahmedabad", lat: "0.0", lng: "0.0", country: "India", iso2: "", adminName: "Gujarat", capital: "Gandhinagar", population: "100000", populationProper: "10000"),
            City(cityName: "Baroda", lat: "0.0", lng: "0.0", country: "India", iso2: "", adminName: "Gujarat", capital: "Gandhinagar", population: "100000", populationProper: "10000"),
            City(cityName: "Mumbai", lat: "0.0", lng: "0.0", country: "India", iso2: "", adminName: "Maharashtra", capital: "Mumbai", population: "100000", populationProper: "10000"),
            City(cityName: "Udaypur", lat: "0.0", lng: "0.0", country: "India", iso2: "", adminName: "Rajashthan", capital: "Jodhpur", population: "100000", populationProper: "10000")
        ]
        mockCache.cachedCities = nil
        mockManager.result = .success(mockCities)

        viewModel.loadCities()

        XCTAssertEqual(viewModel.cities.count, 0)
        XCTAssertEqual(viewModel.sections.count, 0)
        XCTAssertFalse(viewModel.isLoading)
    }

    func testLoadCities_FetchFailure() {
        mockCache.cachedCities = nil
        mockManager.result = .failure(NSError(domain: "TestError", code: 0, userInfo: nil))

        viewModel.loadCities()

        XCTAssertTrue(viewModel.showAlert)
        XCTAssertEqual(viewModel.alertTitle, Constants.titleAndPlaceHolder.alertTitle)
        XCTAssertEqual(viewModel.alertMessage, "The operation couldn’t be completed. (TestError error 0.)")
    }

    func testFilteredSections_WithSearchText() {
        let mockCities = [
            City(cityName: "Ahmedabad", lat: "0.0", lng: "0.0", country: "India", iso2: "", adminName: "Gujarat", capital: "Gandhinagar", population: "100000", populationProper: "10000"),
            City(cityName: "Baroda", lat: "0.0", lng: "0.0", country: "India", iso2: "", adminName: "Gujarat", capital: "Gandhinagar", population: "100000", populationProper: "10000"),
            City(cityName: "Mumbai", lat: "0.0", lng: "0.0", country: "India", iso2: "", adminName: "Maharashtra", capital: "Mumbai", population: "100000", populationProper: "10000"),
            City(cityName: "Udaypur", lat: "0.0", lng: "0.0", country: "India", iso2: "", adminName: "Rajashthan", capital: "Jodhpur", population: "100000", populationProper: "10000")
        ]
        mockCache.cachedCities = mockCities
        viewModel.searchText = "City A"

        viewModel.loadCities()

        let filteredSections = viewModel.filteredSections
        XCTAssertEqual(filteredSections.count, 1)
        XCTAssertTrue(filteredSections["Mumbai"]?.contains { $0.cityName == "Maharashtra" } == true)
    }

    func testReverseOrder() {
        let mockCities = [
            City(cityName: "Ahmedabad", lat: "0.0", lng: "0.0", country: "India", iso2: "", adminName: "Gujarat", capital: "Gandhinagar", population: "100000", populationProper: "10000"),
            City(cityName: "Baroda", lat: "0.0", lng: "0.0", country: "India", iso2: "", adminName: "Gujarat", capital: "Gandhinagar", population: "100000", populationProper: "10000"),
            City(cityName: "Mumbai", lat: "0.0", lng: "0.0", country: "India", iso2: "", adminName: "Maharashtra", capital: "Mumbai", population: "100000", populationProper: "10000"),
            City(cityName: "Udaypur", lat: "0.0", lng: "0.0", country: "India", iso2: "", adminName: "Rajashthan", capital: "Jodhpur", population: "100000", populationProper: "10000")
        ]
        mockCache.cachedCities = mockCities

        viewModel.reverseOrder()

        XCTAssertTrue(viewModel.isReversed)
    }

    func testToggleSection() {
        let sectionState = "Gujarat"

        viewModel.toggleSection(sectionState)

        XCTAssertTrue(viewModel.expandedStates.contains(sectionState))

        viewModel.toggleSection(sectionState)

        XCTAssertFalse(viewModel.expandedStates.contains(sectionState))
    }
}

