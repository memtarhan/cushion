//
//  MoviesScreen.swift
//  Cushion
//
//  Created by Mehmet Tarhan on 23.02.2025.
//  Copyright © 2025 MEMTARHAN. All rights reserved.
//

import SwiftUI

extension CGFloat {
    static var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
}

struct MoviesView: View {
    var data: [MovieCategoryOverviewModel]

    var body: some View {
        ScrollView {
            VStack {
                ForEach(data) { movieCategoryModel in
                    if movieCategoryModel.category == .popular {
                        PopularMoviesSection(data: movieCategoryModel.movies)
                    }
                    if movieCategoryModel.category == .nowPlaying {
                        NowPlayingMoviesSection(data: movieCategoryModel.movies)
                    }
                    if movieCategoryModel.category == .upcoming {
                        UpcomingMoviesSection(data: movieCategoryModel.movies)
                    }
                    if movieCategoryModel.category == .topRated {
                        TopRatedMoviesSection(data: movieCategoryModel.movies)
                    }
                }
            }
        }
    }
}

struct PopularMoviesSection: View {
    var data: [MovieOverviewModel]

    var body: some View {
        VStack(alignment: .leading) {
//            HStack {
//                Text("Popular")
//                    .font(.headline)
//                    .padding(.horizontal, 20)
//                Spacer()
//                NavigationLink {
//                    MovieListScreen(listCategory: .popular)
//                } label: {
//                    Text("See All...")
//                        .font(.subheadline)
//                        .padding()
//                }
//            }

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 0) {
                    ForEach(data) { movie in
                        NavigationLink {
                            MovieDetailsScreen(movieId: movie.id)
                        } label: {
                            AsyncImage(url: URL(string: movie.poster)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                Image(systemName: "movieclapper")
                                    .background(.accent.opacity(0.1))
                            }
                            .font(.largeTitle)
                            .frame(width: .screenWidth - 128)
                            .background(Color.purple.opacity(0.3))
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .shadow(radius: 8)
                            .scrollTransition(.interactive, axis: .horizontal) { effect, phase in
                                effect
                                    .scaleEffect(phase.isIdentity ? 1.0 : 0.75)
                            }
                        }
                    }
                }
                .padding(.horizontal, 64)
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
        }
    }
}

struct NowPlayingMoviesSection: View {
    var data: [MovieOverviewModel]

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Now Playing")
                    .font(.headline)
                    .padding(.horizontal, 20)
                Spacer()
                NavigationLink {
                    MovieListScreen(listCategory: .nowPlaying)
                } label: {
                    Text("See All...")
                        .font(.subheadline)
                        .padding()
                }
            }
            MovieHorizontalPaginatedScrollView(data: data)
        }
    }
}

struct UpcomingMoviesSection: View {
    var data: [MovieOverviewModel]

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Upcoming")
                    .font(.headline)
                    .padding(.horizontal, 20)
                Spacer()
                NavigationLink {
                    MovieListScreen(listCategory: .upcoming)
                } label: {
                    Text("See All...")
                        .font(.subheadline)
                        .padding()
                }
            }
            MovieHorizontalPaginatedScrollView(data: data)
        }
    }
}

struct TopRatedMoviesSection: View {
    var data: [MovieOverviewModel]

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Top Rated")
                    .font(.headline)
                    .padding(.horizontal, 20)
                Spacer()
                NavigationLink {
                    MovieListScreen(listCategory: .topRated)
                } label: {
                    Text("See All...")
                        .font(.subheadline)
                        .padding()
                }
            }
            MovieHorizontalPaginatedScrollView(data: data)
        }
    }
}

struct MovieOverviewRow: View {
    var data: MovieOverviewModel
    private let imageWidth: CGFloat = 120
    private var imageHeight: CGFloat {
        imageWidth * 16 / 9
    }

    var body: some View {
        VStack(alignment: .center) {
            AsyncImage(url: URL(string: data.poster)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: imageWidth, height: imageHeight)
            } placeholder: {
                Image(systemName: "movieclapper")
                    .frame(width: imageWidth, height: imageHeight)
                    .background(.accent.opacity(0.1))
            }
        }

        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .secondary.opacity(0.5), radius: 2)
        .padding(.horizontal, 4)
    }
}

struct MovieHorizontalPaginatedScrollView: View {
    var data: [MovieOverviewModel]

    var body: some View {
        ScrollViewReader { _ in
            ScrollView(.horizontal) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(data) { rowData in
                        NavigationLink {
                            MovieDetailsScreen(movieId: rowData.id)
                        } label: {
                            MovieOverviewRow(data: rowData)
                                .id(rowData.id)
                        }
                    }
                }
            }
        }
    }
}

struct MoviesScreen: View {
    @StateObject var viewModel = MoviesViewModel()

    var body: some View {
        NavigationStack {
            if viewModel.loading {
                ProgressView("Loading...")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .padding(.vertical)

            } else {
                MoviesView(data: viewModel.movies)
                    .navigationTitle("Movies")
            }
        }

        .task {
            viewModel.handleData()
        }
    }
}

#Preview {
    MoviesScreen()
}
