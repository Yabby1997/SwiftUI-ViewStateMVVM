//
//  GiphySearchViewModel.swift
//  GiphySwiftUI
//
//  Created by USER on 2022/10/02.
//

import Foundation
import GiphyDomainLayer

struct GiphySearchState {
    var giphies: [GiphyEntity] = []
}

enum GiphySearchInput {
    case search(query: String)
    case clear
}

final class GiphySearchViewModel: ViewModel {
    typealias State = GiphySearchState
    typealias Input = GiphySearchInput

    @Published private(set) var state: GiphySearchState

    private let giphyUseCase: GiphyUseCaseProtocol

    init(
        state: GiphySearchState,
        giphyUseCase: GiphyUseCaseProtocol
    ) {
        self.state = state
        self.giphyUseCase = giphyUseCase
    }

    func trigger(_ input: GiphySearchInput) {
        switch input {
        case .search(query: let query):
            search(query)
        case .clear:
            clear()
        }
    }

    private func search(_ query: String) {
        Task {
            let searchResults = try await giphyUseCase.search(query: query)
            await MainActor.run {
                state.giphies = searchResults
            }
        }
    }

    private func clear() {
        state.giphies = []
    }
}

final class GiphySearchMockViewModel: ViewModel {
    typealias State = GiphySearchState
    typealias Input = GiphySearchInput

    @Published private(set) var state: GiphySearchState

    init(state: GiphySearchState) {
        self.state = state
    }

    func trigger(_ input: GiphySearchInput) {
        switch input {
        case .search(_):
            search()
        case .clear:
            clear()
        }
    }

    private func search() {
        let url = URL(string: "https://media1.giphy.com/media/nDSlfqf0gn5g4/giphy.gif?cid=7f6648ffk1d1xl3s0k387ps5rkpfnzc9f34dhtcue82ciass&rid=giphy.gif&ct=g")
        state.giphies = (0...100).map { GiphyEntity(name: "\($0)", thumbnailUrl: url, originalUrl: url) }
    }

    private func clear() {
        state.giphies = []
    }
}
