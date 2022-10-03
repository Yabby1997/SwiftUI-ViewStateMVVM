//
//  ViewModel.swift
//  ViewStateMVVM
//
//  Created by USER on 2022/10/02.
//

import Combine
import Foundation

protocol ViewModel: ObservableObject where ObjectWillChangePublisher.Output == Void {
    associatedtype State
    associatedtype Input

    var state: State { get }

    func trigger(_ input: Input)
}

final class AnyViewModel<State, Input>: ViewModel {
    private let wrappedState: () -> State
    private let wrappedTrigger: (Input) -> Void
    private var stateObserver: AnyCancellable?

    var state: State { wrappedState() }

    init<V: ViewModel>(_ viewModel: V) where V.State == State, V.Input == Input {
        self.wrappedState = { viewModel.state }
        self.wrappedTrigger = viewModel.trigger(_:)
        self.stateObserver = viewModel.objectWillChange.sink { [weak self] in
            self?.objectWillChange.send()
        }
    }

    func trigger(_ input: Input) {
        wrappedTrigger(input)
    }
}
