//
//  MoviesScreen.swift
//  Cushion
//
//  Created by Mehmet Tarhan on 23.02.2025.
//  Copyright © 2025 MEMTARHAN. All rights reserved.
//

import SwiftUI

struct MoviesScreen: View {
    @StateObject var viewModel = MoviesViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink("Show Detail View") {
                    MovieDetails(movieId: "movie_299")
                }
            }
        }
    }
}

#Preview {
    MoviesScreen()
}
