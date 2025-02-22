//
//  SeriesListService.swift
//  Cushion
//
//  Created by Mehmet Tarhan on 22.02.2025.
//  Copyright © 2025 MEMTARHAN. All rights reserved.
//

import Foundation

protocol SeriesListService: APIService {
    func getPopular(at page: Int) async throws -> ContentResponse
}

struct SeriesListProvider: SeriesListService {
    func getPopular(at page: Int) async throws -> ContentResponse {
        guard let endpoint = Endpoints.seriesTopRated(page: page).url else {
            throw APIError.badURL
        }

        let response: ContentListResponse = try await handleDataTask(from: endpoint)
        return response.response
    }
}
