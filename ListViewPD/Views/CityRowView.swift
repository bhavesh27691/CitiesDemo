//
//  CityRowView.swift
//  ListViewPD
//
//  Created by Bhavesh Rathod on 27/01/25.
//

import SwiftUI

// MARK: - City Row View
struct CityRowView: View {
    let city: City

    var body: some View {
        VStack(alignment: .leading) {
            Text(city.cityName).font(.headline)
            HStack {
                Image(systemName: Constants.ImagesNames.location)
                    .scaledToFit()
                    .frame(width: 40, height: 25)
                
                Text("Location").font(.headline)
                Spacer()
                Text("\(city.lat), \(city.lng)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            HStack {
                Image(systemName: Constants.ImagesNames.population)
                    .scaledToFit()
                    .frame(width: 40, height: 25)
                
                Text("Population").font(.headline)
                Spacer()
                Text("\(city.population)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}

#Preview {
    CityRowView(city: City(cityName: "Ahmedabad", lat: "0.0", lng: "0.0", country: "India", iso2: "", adminName: "Gujarat", capital: "Gandhinagar", population: "100000", populationProper: "10000"))
}
