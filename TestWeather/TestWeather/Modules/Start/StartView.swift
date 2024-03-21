//
//  StartView.swift
//  TestWeather
//
//  Created by Nikolai Lipski on 20.03.24.
//

import SwiftUI

struct StartView: View {
    @StateObject var viewModel: StartViewModel
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                List {
                    ForEach(viewModel.searchHistory, id: \.self) { item in
                        Button {
                            viewModel.onTapLocation(item)
                        } label: {
                            Text("\(item.name), \(item.country)")
                        }
                    }
                }
                .searchable(text: $viewModel.textToSearch, prompt: "Search City")
                .searchSuggestions {
                    ForEach(viewModel.searchResults, id: \.self) { item in
                        Button {
                            viewModel.onTapSuggestion(item)
                        } label: {
                            Text("\(item.name), \(item.country)")
                                .foregroundColor(.blue)
                        }
                    }
                }
                
                if viewModel.searchHistory.isEmpty {
                    Text("No search history")
                }
            }
            .navigationDestination(for: DetailsDependency.self) { dependency in
                DetailsView(viewModel: DetailsViewModel(dependency: dependency))
            }
        }
        .onChange(of: viewModel.detailsDependency) { data in
            guard let data else { return }
            
            path.append(data)
        }
        .onSubmit(of: .search) {
            viewModel.search()
        }
        .overlay {
            if viewModel.isProcessing {
                LoadingView()
            }
        }
        .alert(viewModel.errorText, isPresented: $viewModel.isShowingAlert) {
            Button("OK", role: .cancel) { }
        }
    }
}

#Preview {
    StartView(viewModel: StartViewModel(context: Context()))
}
