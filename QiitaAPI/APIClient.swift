//
//  APIClient.swift
//  QiitaAPI
//
//  Created by Ryuga on 2023/11/18.
//

import Foundation

protocol APIClientInterface {
    func fetchQiitaItem() async throws -> [QiitaItem]
}

class APIClient: APIClientInterface {
    func fetchQiitaItem() async throws -> [QiitaItem] {
        let (data, response) = try await URLSession.shared.data(from: URL(string: "https://qiita.com/api/v2/tags/swift/items")!)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.networkError
        }
        switch httpResponse.statusCode {
        case 200..<300:
            guard let decodedResponse = try? JSONDecoder().decode([QiitaItem].self, from: data) else {
                throw APIError.decodeError
            }
            return decodedResponse
        default:
            throw APIError.unknownError
        }
    }
}
