//
//  MoviesScreen.swift
//  Cushion
//
//  Created by Mehmet Tarhan on 23.02.2025.
//  Copyright © 2025 MEMTARHAN. All rights reserved.
//

import SwiftUI

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
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Popular")
                            .font(.headline)
                            .padding(.horizontal, 20)
                        Spacer()
                        NavigationLink {
                            MovieListScreen(listCategory: .popular)
                        } label: {
                            Text("See All...")
                                .font(.subheadline)
                                .padding()
                        }
                    }
                    MovieHorizontalPaginatedScrollView(data: viewModel.popularMovies)
                }

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
                    MovieHorizontalPaginatedScrollView(data: viewModel.nowPlayingMovies)
                }

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
                    MovieHorizontalPaginatedScrollView(data: viewModel.upcomingMovies)
                }

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
                    MovieHorizontalPaginatedScrollView(data: viewModel.topRatedMovies)
                }
            }
            .navigationTitle("Movies")
        }
        .task {
            viewModel.handleData()
        }
    }
}

#Preview {
    MoviesScreen()
}
