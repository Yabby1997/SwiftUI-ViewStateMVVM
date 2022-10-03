//
//  GiphySearchViewModel.swift
//  ViewStateMVVM
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
            let result = try await giphyUseCase.search(query: query)
            DispatchQueue.main.async { [weak self] in
                self?.state.giphies = result
            }
        }
    }

    private func clear() {
        state.giphies = []
    }
}
