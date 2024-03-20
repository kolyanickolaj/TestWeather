//
//  StartView.swift
//  TestWeather
//
//  Created by Nikolai Lipski on 20.03.24.
//

import SwiftUI

struct StartView: View {
    @StateObject var viewModel: StartViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    ForEach(viewModel.searchHistory, id: \.self) { item in
                        NavigationLink {
                            // todo
                        } label: {
                            Text(item.name)
                        }
                    }
                }
                .searchable(text: $viewModel.textToSearch, prompt: "Search City")
                .searchSuggestions {
                    ForEach(viewModel.searchResults, id: \.self) { item in
                        NavigationLink {
                            // todo
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
            
            
        }
        .onSubmit(of: .search) {
            viewModel.search()
        }
        .overlay {
            if viewModel.isProcessing {
                LoadingView()
            }
        }
    }
}

#Preview {
    StartView(viewModel: StartViewModel())
}
