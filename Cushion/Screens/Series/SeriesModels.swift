//
//  SeriesModels.swift
//  Cushion
//
//  Created by Mehmet Tarhan on 22.02.2025.
//  Copyright © 2025 MEMTARHAN. All rights reserved.
//

import Foundation

struct SeriesOverviewModel: Identifiable {
    let id: String
    let poster: String
    let genres: [String]
}

struct SeriesListModel: Identifiable {
    let description: String
    let items: [SeriesOverviewModel]
    
    var id: String { description }
}
