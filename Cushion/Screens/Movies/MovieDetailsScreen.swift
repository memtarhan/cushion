//
//  MovieDetails.swift
//  Cushion
//
//  Created by Mehmet Tarhan on 23.02.2025.
//  Copyright © 2025 MEMTARHAN. All rights reserved.
//

import SwiftUI

struct MoviePosterView: View {
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

struct MovieTitleView: View {
    var title: String

    var body: some View {
        Text(title)
            .font(.largeTitle.weight(.semibold))
    }
}

struct MovieInfoView: View {
    var year: String
    var genre: String
    var runtime: String

    var body: some View {
        HStack(spacing: 8) {
            Spacer()

            Text(year)
                .font(.headline.weight(.medium))
            Image(systemName: "smallcircle.filled.circle.fill")
                .font(.caption2.weight(.ultraLight))
                .foregroundStyle(.secondary)

            Text(genre)
                .font(.headline.weight(.medium))
            Image(systemName: "smallcircle.filled.circle.fill")
                .font(.caption2.weight(.ultraLight))
                .foregroundStyle(.secondary)

            Text(runtime)
                .font(.headline.weight(.medium))

            Spacer()
        }
    }
}

struct MovieRatingView: View {
    var imdbRating: String
    var rated: String

    var body: some View {
        HStack(spacing: 20) {
            HStack(alignment: .center, spacing: 2) {
                Spacer()

                Text(imdbRating)
                    .font(.title3.weight(.medium))

                Image(systemName: "star.fill")
                    .foregroundStyle(Color.yellow)
            }
            .frame(minWidth: 0, maxWidth: .infinity)

            Image(systemName: "smallcircle.filled.circle.fill")
                .font(.caption2.weight(.ultraLight))
                .foregroundStyle(.secondary)

            HStack {
                Text(rated)
                    .font(.title3.weight(.medium))

                Spacer()
            }
            .frame(minWidth: 0, maxWidth: .infinity)

            Spacer()
        }
    }
}

struct MovieOverviewView: View {
    var awardsDescription: String
    var overview: String

    var body: some View {
        VStack(spacing: 8) {
            Text(awardsDescription)
                .font(.headline.italic())
                .foregroundStyle(.secondary)

            Text(overview)
                .font(.callout)
        }
    }
}

struct MovieCastContainerView: View {
    var director: String
    var writer: String
    let cast: [MovieCreditModel]

    var body: some View {
        VStack {
            HStack {
                Text("Director")
                    .font(.subheadline.italic())
                    .foregroundStyle(.secondary)
                Spacer()
                Text(director)
                    .font(.callout)
            }

            HStack {
                Text("Writer")
                    .font(.subheadline.italic())
                    .foregroundStyle(.secondary)
                Spacer()
                Text(writer)
                    .font(.callout)
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 8)

        MovieCastView(cast: cast)
    }
}

struct MovieCastRow: View {
    var cast: MovieCreditModel

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: cast.photo)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 45, height: 45)
                    .clipShape(Circle())
            } placeholder: {
            }

            Text(cast.name)
                .font(.system(size: 10))
            Text(cast.character)
                .foregroundStyle(.secondary)
                .font(.caption2)
        }
    }
}

struct MovieCastView: View {
    var cast: [MovieCreditModel]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Cast")

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(cast) { castData in
                        MovieCastRow(cast: castData)
                    }
                }
            }
        }
        .padding()
    }
}

struct MovieDetailsScreen: View {
    @StateObject var viewModel = MovieDetailsViewModel()
    let movieId: String

    var body: some View {
        ScrollView {
            if let details = viewModel.details {
                VStack {
                    MoviePosterView(url: details.poster)
                    VStack {
                        MovieTitleView(title: details.title)
                        MovieInfoView(year: details.year, genre: details.genre, runtime: details.runtime)
                        MovieRatingView(imdbRating: details.imdbRating, rated: details.rated)
                        MovieOverviewView(awardsDescription: details.awardsDescription, overview: details.overview)
                        MovieCastContainerView(director: details.director, writer: details.writer, cast: details.cast)
                    }
                    .padding(.horizontal, 8)
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
    MovieDetailsScreen(movieId: "movie_15640")
}
