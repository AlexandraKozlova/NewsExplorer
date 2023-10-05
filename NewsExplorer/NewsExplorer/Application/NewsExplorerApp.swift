//
//  NewsExplorerApp.swift
//  NewsExplorer
//
//  Created by Aleksandra on 04.10.2023.
//

import SwiftUI

@main
struct NewsExplorerApp: App {
    @StateObject private var viewModel = MainNewsViewModel(appContainer: AppContainerImpl())
  
    var body: some Scene {
        WindowGroup {
            MainNewsView()
                .environmentObject(viewModel)
        }
    }
}
