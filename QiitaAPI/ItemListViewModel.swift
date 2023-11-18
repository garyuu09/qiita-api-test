//
//  ItemListViewModel.swift
//  QiitaAPI
//
//  Created by Ryuga on 2023/11/18.
//

import Foundation

@MainActor
final class ItemListViewModel: ObservableObject {
    @Published var items: [QiitaItem] = []
    private let apiClient: APIClientInterface

    init(apiClient: APIClientInterface) {
        self.apiClient = apiClient
    }

    func fetch() async throws {
        Task {
            do {
                items = try await apiClient.fetchQiitaItem()
            } catch {
                throw APIError.responseError
            }
        }
    }
}
