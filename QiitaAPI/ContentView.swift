//
//  ContentView.swift
//  QiitaAPI
//
//  Created by Ryuga on 2023/11/18.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ItemListViewModel(apiClient: APIClient())

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.items, id: \.self) { item in
                    Text(item.title)
                }
            }
            .navigationTitle("Qiita Articles")
        }

        .task {
            try? await viewModel.fetch()
        }
    }
}

#Preview {
    ContentView()
}
