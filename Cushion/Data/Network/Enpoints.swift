//
//  Enpoints.swift
//  Cushion
//
//  Created by Mehmet Tarhan on 22.02.2025.
//  Copyright © 2025 MEMTARHAN. All rights reserved.
//

import Foundation

fileprivate let baseURL = "http://127.0.0.1:8000"

enum Endpoints {
    case seriesTopRated(page: Int)

    var url: URL? {
        switch self {
        case let .seriesTopRated(page: page):
            return URL(string: "\(baseURL)/tv/popular?page=\(page)")
        }
    }
}
