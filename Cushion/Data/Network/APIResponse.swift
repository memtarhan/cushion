//
//  APIResponse.swift
//  Cushion
//
//  Created by Mehmet Tarhan on 22.02.2025.
//  Copyright © 2025 MEMTARHAN. All rights reserved.
//

import Foundation

protocol APIResponse: Decodable { }

// MARK: - ContentListResponse

struct ContentListResponse: APIResponse {
    let response: ContentResponse
}

// MARK: - ContentResponse

struct ContentResponse: APIResponse {
    let page: Int
    let results: [ContentResultResponse]
}

// MARK: - ContentResultResponse

struct ContentResultResponse: APIResponse {
    let id: String
    let country: [String]
    let language, name, overview: String
    let poster: String
    let genres: [String]
    let airDate: String
}
