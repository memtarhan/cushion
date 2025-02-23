//
//  SeriesViewModel.swift
//  Cushion
//
//  Created by Mehmet Tarhan on 22.02.2025.
//  Copyright © 2025 MEMTARHAN. All rights reserved.
//

import Foundation

class SeriesViewModel: ObservableObject {
    @Published var popular: SeriesListModel?

    private let service: SeriesListService

    init() {
        service = SeriesListProvider()
    }

    func fetchSeries() {
        Task(priority: .background) {
            if let response = try? await self.service.getPopular(at: 1) {
                let popularItems = response.results.map { result in
                    SeriesOverviewModel(id: result.id, poster: result.poster, genres: result.genres)
                }

                popular = SeriesListModel(description: "Popular", items: popularItems)
            }
        }
    }
}
