//
//  CitiesViewModel.swift
//  ListViewPD
//
//  Created by Bhavesh Rathod on 27/01/25.
//

import Foundation

// MARK: - ViewModel
class CitiesViewModel: ObservableObject {
    @Published var cities: [City] = []
    @Published var sections: [String: [City]] = [:]
    @Published var isReversed = false
    @Published var expandedStates: Set<String> = []
    @Published var searchText = ""
    
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var alertTitle = ""
    @Published var isLoading = false


    private let objDataManager: CitiesManagerProtocol
    private let cache: CitiesCache

    init(objDataManager: CitiesManagerProtocol, cache: CitiesCache) {
        self.objDataManager = objDataManager
        self.cache = cache
        loadCities()
    }

    var filteredSections: [String: [City]] {
        
        guard !searchText.isEmpty else {
            return sections.mapValues { cities in
                cities.sorted(by: { $0.cityName < $1.cityName })
            }
        }
        return sections.mapValues { cities in
            cities.filter { $0.cityName.localizedCaseInsensitiveContains(searchText) }
                .sorted(by: { $0.cityName < $1.cityName })
        }.filter { !$0.value.isEmpty }
        
    }

    func toggleSection(_ state: String) {
        if expandedStates.contains(state) {
            expandedStates.remove(state)
        } else {
            expandedStates.insert(state)
        }
    }

    func reverseOrder() {
        isReversed.toggle()
    }

    func loadCities() {
        if let cachedCities = cache.getCachedCities() {
            updateSections(with: cachedCities)
        } else {
            refreshData()
        }
    }

    func refreshData() {
        isLoading = true
        objDataManager.fetchCities { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let cities):
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.cache.saveCities(cities)
                    self.updateSections(with: cities)
                }
            case .failure(let error):
                self.isLoading = false
                self.showAlert = true
                self.alertTitle = Constants.titleAndPlaceHolder.alertTitle
                self.alertMessage = error.localizedDescription
            }
        }
    }

    private func updateSections(with cities: [City]) {
        self.cities = cities
        self.sections = Dictionary(grouping: cities, by: { $0.adminName })
    }
}
