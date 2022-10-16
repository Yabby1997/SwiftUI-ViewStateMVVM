//
//  GiphySearchView.swift
//  GiphySwiftUI
//
//  Created by USER on 2022/10/02.
//

import SwiftUI

struct GiphySearchView: View {

    @EnvironmentObject var viewModel: AnyViewModel<GiphySearchState, GiphySearchInput>

    var body: some View {
        VStack {
            HStack {
                Button("spongebob") {
                    viewModel.trigger(.search(query: "spongebob"))
                }
                Spacer()
                Button("clear") {
                    viewModel.trigger(.clear)
                }
            }
            ForEach(viewModel.state.giphies, id: \.name) { item in
                Text(item.name)
            }
        }
        .padding()
    }
}

struct GiphySearchView_Previews: PreviewProvider {
    static var previews: some View {
        GiphySearchView().environmentObject(AnyViewModel(GiphySearchMockViewModel(state: GiphySearchState())))
    }
}
