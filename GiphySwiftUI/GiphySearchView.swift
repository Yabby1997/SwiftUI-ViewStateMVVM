//
//  GiphySearchView.swift
//  GiphySwiftUI
//
//  Created by USER on 2022/10/02.
//

import SwiftUI
import NukeUI

struct GiphySearchView: View {

    @EnvironmentObject var viewModel: AnyViewModel<GiphySearchState, GiphySearchInput>

    var body: some View {
        VStack {
            HStack {
                Button("Search") {
                    viewModel.trigger(.search(query: "spongebob"))
                }
                Button("Clear") {
                    viewModel.trigger(.clear)
                }
            }
            .padding()
            ScrollView(showsIndicators: true) {
                LazyVGrid(
                    columns: [
                        GridItem(.flexible(), spacing: 1),
                        GridItem(.flexible(), spacing: 1),
                        GridItem(.flexible(), spacing: 1),
                    ],
                    spacing: 1
                ) {
                    ForEach(viewModel.state.giphies, id: \.name) { giphy in
                        LazyImage(url: giphy.originalUrl)
                            .scaledToFit()
                    }
                }
            }
        }
    }
}

struct GiphySearchView_Previews: PreviewProvider {
    static var previews: some View {
        GiphySearchView().environmentObject(AnyViewModel(GiphySearchMockViewModel(state: GiphySearchState())))
    }
}
