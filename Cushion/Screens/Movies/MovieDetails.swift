//
//  MovieDetails.swift
//  Cushion
//
//  Created by Mehmet Tarhan on 23.02.2025.
//  Copyright © 2025 MEMTARHAN. All rights reserved.
//

import SwiftUI

struct PosterImage: View {
    var url: String
    var body: some View {
        AsyncImage(url: URL(string: url)) { image in
            image
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity)
        } placeholder: {
        }
    }
}

struct MovieDetails: View {
    @StateObject var viewModel = MovieDetailsViewModel()
    let movieId: String

    var body: some View {
        ScrollView {
            if let details = viewModel.details {
                VStack {
                    PosterImage(url: details.poster)

                    Text(details.title)
                        .font(.largeTitle)

                    HStack(spacing: 2) {
                        Spacer()

                        Text(details.year)
                            .font(.headline.weight(.medium))
                        Image(systemName: "smallcircle.filled.circle.fill")
                            .font(.caption2.weight(.ultraLight))
                            .foregroundStyle(.secondary)

                        Text(details.genre)
                            .font(.headline.weight(.medium))
                        Image(systemName: "smallcircle.filled.circle.fill")
                            .font(.caption2.weight(.ultraLight))
                            .foregroundStyle(.secondary)

                        Text(details.runtime)
                            .font(.headline.weight(.medium))

                        Spacer()
                    }

                    HStack(spacing: 20) {
                        Spacer()

                        HStack(alignment: .center, spacing: 2) {
                            Text(details.imdbRating)
                                .font(.title3.weight(.medium))

                            Image(systemName: "star.fill")
                                .foregroundStyle(Color.yellow)
                        }

                        Image(systemName: "smallcircle.filled.circle.fill")
                            .font(.caption2.weight(.ultraLight))
                            .foregroundStyle(.secondary)

                        Text(details.rated)
                            .font(.title3.weight(.medium))

                        Spacer()
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.top)

        .task {
            viewModel.handleMovieDetails(id: movieId)
        }
    }
}

#Preview {
    MovieDetails(movieId: "movie_3618728")
}
