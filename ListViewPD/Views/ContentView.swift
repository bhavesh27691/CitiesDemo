//
//  ContentView.swift
//  ListViewPD
//
//  Created by Bhavesh Rathod on 27/01/25.
//

import SwiftUI
import SwiftData

// MARK: - City List View
struct ContentView: View {
    @StateObject private var viewModel = CitiesViewModel(objDataManager: LocalCitiesManager(), cache: CitiesCache())
    @FocusState private var isInputActive: SearchBarField?

    private enum SearchBarField: Int, CaseIterable {
        case searchBar
    }
    
    var body: some View {
        NavigationView {
            VStack {
                searchAndReverseBar
                citiesList
            }
            .navigationTitle(Constants.titleAndPlaceHolder.screenTitle)
            .alert(isPresented: .constant(viewModel.showAlert)) {
                Alert(
                    title: Text(viewModel.alertTitle),
                    message: Text(viewModel.alertMessage),
                    dismissButton: .default(Text(Constants.titleAndPlaceHolder.alertActionOK), action: {
                    })
                )
            }
        }
    }

    private var searchAndReverseBar: some View {
        HStack {
            TextField(Constants.titleAndPlaceHolder.searchBarPlaceHolder, text: $viewModel.searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .focused($isInputActive,equals:.searchBar)
                .padding(.leading)
            Button(action: {
                isInputActive = nil
                viewModel.reverseOrder()
            }) {
                Label("", systemImage: Constants.ImagesNames.reverseImg)
            }
            .padding(.trailing)
        }
    }

    private var citiesList: some View {
        List {
            ForEach(viewModel.filteredSections.keys.sorted(by: sortStates), id: \.self) { state in
                CitySectionView(
                    state: state,
                    cities: viewModel.filteredSections[state] ?? [],
                    isExpanded: viewModel.expandedStates.contains(state),
                    onToggle: {
                        isInputActive = nil
                        viewModel.toggleSection(state)
                    }
                )
            }
        }
        .listStyle(PlainListStyle())
    }

    private func sortStates(_ lhs: String, _ rhs: String) -> Bool {
        viewModel.isReversed ? lhs > rhs : lhs < rhs
    }
}
