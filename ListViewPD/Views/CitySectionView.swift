//
//  CitySectionView.swift
//  ListViewPD
//
//  Created by Bhavesh Rathod on 27/01/25.
//

import SwiftUI

// MARK: - City Section View
struct CitySectionView: View {
    let state: String
    let cities: [City]
    let isExpanded: Bool
    let onToggle: () -> Void

    var body: some View {
        Section(header: headerView) {
            if isExpanded {
                ForEach(cities) { city in
                    CityRowView(city: city)
                }
            }
        }
    }

    private var headerView: some View {
        Button(action: onToggle) {
            HStack {
                Text(state).font(.headline)
                Spacer()
                Image(systemName: isExpanded ? Constants.ImagesNames.arrowDown : Constants.ImagesNames.arrowRight)
            }
            .padding(.vertical, 5)
        }
    }
}

#Preview {
    CitySectionView(state: "Gujarat", cities: [City(cityName: "Ahmedabad", lat: "0.0", lng: "0.0", country: "India", iso2: "", adminName: "Gujarat", capital: "Gandhinagar", population: "100000", populationProper: "10000")], isExpanded: false, onToggle: {})
}
