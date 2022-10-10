//
//  GiphySwiftUIApp.swift
//  GiphySwiftUI
//
//  Created by USER on 2022/10/02.
//

import SwiftUI
import GiphyDomainLayer
import GiphyDataLayer
import URLRequestDataSourceLayer

@main
struct GiphySwiftUIApp: App {
    var body: some Scene {

        let networkService = URLRequestBuilderNetworkService()
        let giphyRepository = GiphyRepository(
            apiKey: "rEDEvI1fNspJPNdMNscfdzwLsC3zZRx5",
            networkService: networkService
        )
        let giphyUseCase = GiphyUseCase(repository: giphyRepository)
        let giphySearchViewModel = GiphySearchViewModel(
            state: GiphySearchState(),
            giphyUseCase: giphyUseCase
        )

        WindowGroup {
            GiphySearchView().environmentObject(AnyViewModel(giphySearchViewModel))
        }
    }
}
