//
//  APIService.swift
//  Cushion
//
//  Created by Mehmet Tarhan on 22.02.2025.
//  Copyright © 2025 MEMTARHAN. All rights reserved.
//

import Foundation

protocol APIService {
    /// Handles HTTP call and retrieve a response for given url with no authorization
    /// - Parameter url: The url HTTP call should be pointed to
    /// - Returns: Returns a response of given type
    func handleDataTask<T: APIResponse>(from url: URL) async throws -> T
}

extension APIService {
    func handleDataTask<T: APIResponse>(from url: URL) async throws -> T {
        let (data, _) = try await session.data(from: url)
        #if DEBUG
            data.printPrettied()
        #endif
        return try decoder.decode(T.self, from: data)
    }
}

// MARK: Private variables

private extension APIService {
    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        return decoder
    }

    var session: URLSession {
        URLSession.shared
    }
}
