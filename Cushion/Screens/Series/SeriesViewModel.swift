//
//  SeriesViewModel.swift
//  Cushion
//
//  Created by Mehmet Tarhan on 22.02.2025.
//  Copyright © 2025 MEMTARHAN. All rights reserved.
//

import Foundation

class SeriesViewModel: ObservableObject {
    private let service: SeriesListService

    init() {
        service = SeriesListProvider()
    }

    func fetchSeries() {
        Task(priority: .background) {
            try? await self.service.getPopular(at: 1)
        }
    }
}
