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

// MARK: - MovieListResponse

struct MovieListResponse: APIResponse {
    let response: MovieResponse
}

// MARK: - MovieResponse

struct MovieResponse: APIResponse {
    let page: Int
    let results: [MovieResultResponse]
    let title: String
}

// MARK: - MovieResultResponse

struct MovieResultResponse: APIResponse {
    let id: String
    let language: String
    let title: String
    let overview: String
    let poster: String
    let genres: [String]
    let releaseDate: String
}

// MARK: - MovieDetailsResponse

struct MovieDetailsResponse: APIResponse {
    let id: String
    let originalLanguage: String
    let title: String
    let overview: String
    let poster: String
    let backdrop: String
    let genre: String
    let releaseDate: String
    let imdbRating: String
    let imdbVotes: String
    let awards: String
    let rated: String
    let boxOffice: String
    let imdbPage: String
    let homepage: String
    let runtime: Int
    let year: Int
    let director: String
    let writer: String
    let credits: [MovieCreditResponse]
}

// MARK: - MovieCreditResponse

struct MovieCreditResponse: APIResponse {
    let name: String
    let character: String
    let photo: String
}
