//
//  MovieDetailsService.swift
//  Cushion
//
//  Created by Mehmet Tarhan on 23.02.2025.
//  Copyright © 2025 MEMTARHAN. All rights reserved.
//

import Foundation

protocol MovieDetailsService: APIService {
    func getDetails(for movieId: String) async throws -> MovieDetailsResponse
}

struct MovieDetailsServiceImpl: MovieDetailsService {
    func getDetails(for movieId: String) async throws -> MovieDetailsResponse {
        guard let endpoint = Endpoints.movieDetails(id: movieId).url else {
            throw APIError.badURL
        }

        let response: MovieDetailsResponse = try await handleDataTask(from: endpoint)
        return response
    }
}
