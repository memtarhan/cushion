//
//  SeriesScreen.swift
//  Cushion
//
//  Created by Mehmet Tarhan on 22.02.2025.
//  Copyright © 2025 MEMTARHAN. All rights reserved.
//

import SwiftUI

struct ContentOverviewRow: View {
    var data: SeriesOverviewModel
    private let imageWidth: CGFloat = 160
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
                ProgressView()
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))

            VStack {
                ForEach(data.genres, id: \.self) { genre in
                    Text(genre)
                        .font(.subheadline)
                }
            }
            .padding(.top, 8)
        }

        .padding(.horizontal, 8)
    }
}

struct HorizontalPaginatedScrollView: View {
    var data: [SeriesOverviewModel]

    var body: some View {
        ScrollViewReader { _ in
            ScrollView(.horizontal) {
                HStack(alignment: .top) {
                    ForEach(data) { rowData in
                        ContentOverviewRow(data: rowData)
                            .id(rowData.id)
                    }
                }
            }
        }
    }
}

struct SeriesScreen: View {
    @StateObject var viewModel = SeriesViewModel()

    var body: some View {
        VStack {
            if let popular = viewModel.popular {
                VStack(alignment: .leading, spacing: 0) {
                    Text(popular.description)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .font(.headline)

                    HorizontalPaginatedScrollView(data: popular.items)
                }
            }
        }
        .task {
            viewModel.fetchSeries()
        }
    }
}

#Preview {
    SeriesScreen()
}
