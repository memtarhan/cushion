//
//  MovieDetailsViewModel.swift
//  Cushion
//
//  Created by Mehmet Tarhan on 23.02.2025.
//  Copyright © 2025 MEMTARHAN. All rights reserved.
//

import Foundation

@MainActor
class MovieDetailsViewModel: ObservableObject {
    @Published var details: MovieDetailsModel?

    private let service: MovieDetailsService

    init() {
        service = MovieDetailsServiceImpl()
    }

    func handleMovieDetails(id: String) {
        Task(priority: .background) {
            if let response = try? await service.getDetails(for: id) {
                details = MovieDetailsModel(poster: response.poster,
                                            backdrop: response.backdrop,
                                            title: response.title,
                                            runtime: getFormattedRuntime(minutes: response.runtime),
                                            year: "\(response.year)",
                                            genre: response.genre,
                                            rated: response.rated,
                                            imdbRating: response.imdbRating,
                                            awardsDescription: response.awards,
                                            overview: response.overview,
                                            director: response.director,
                                            writer: response.writer,
                                            cast: response.credits.map { MovieCreditModel(name: $0.name, character: $0.character, photo: $0.photo) })
            }
        }
    }

    private func getFormattedRuntime(minutes: Int) -> String {
        let hours = minutes / 60
        let remainingMinutes = minutes % 60

        return "\(hours)h \(remainingMinutes)min"
    }
}
