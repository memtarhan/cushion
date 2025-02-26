//
//  MovieListScreen.swift
//  Cushion
//
//  Created by Mehmet Tarhan on 24.02.2025.
//  Copyright © 2025 MEMTARHAN. All rights reserved.
//

import SwiftUI

struct MovieListScreen: View {
    @StateObject var viewModel = MovieListViewModel()

    let listCategory: MovieListCategory

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    var body: some View {
        GeometryReader { proxy in
            NavigationStack {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(viewModel.movies) { movie in
                            MovieOverviewRow(data: movie)
                                .frame(width: (proxy.size.width - 64) / 2)
                                .onAppear {
                                    viewModel.loadMoreIfNeeded(currentItem: movie)
                                }
                        }
                    }
                    .padding(.horizontal)
                    if viewModel.loading {
                        ProgressView("Loading more...")
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .padding(.vertical)
                    }
                }
                .navigationTitle(listCategory.title)
                .navigationBarTitleDisplayMode(.inline)
            }
            .task {
                viewModel.listCategory = listCategory
                viewModel.fetchMovies()
            }
        }
    }
}

#Preview {
    MovieListScreen(listCategory: .popular)
}
