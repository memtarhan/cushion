//
//  SeriesScreen.swift
//  Cushion
//
//  Created by Mehmet Tarhan on 22.02.2025.
//  Copyright © 2025 MEMTARHAN. All rights reserved.
//

import SwiftUI

struct SeriesScreen: View {
    @StateObject var viewModel = SeriesViewModel()

    var body: some View {
        Text("Hello, World!")
            .task {
                viewModel.fetchSeries()
            }
    }
}

#Preview {
    SeriesScreen()
}
