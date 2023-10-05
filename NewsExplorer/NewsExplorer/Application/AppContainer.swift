//
//  AppContainer.swift
//  NewsExplorer
//
//  Created by Aleksandra on 04.10.2023.
//

import Foundation

protocol AppContainer: AnyObject {
    var newsNetworkService: NewsNetworkService { get }
    var newsService: NewsService { get }
}

final class AppContainerImpl: AppContainer {
    let newsNetworkService: NewsNetworkService
    let newsService: NewsService
    
    init() {
        let networkManagerImpl = NetworkManagerImpl(session: URLSession.shared)
        
        let newsNetworkServiceProvider = NetworkServiceProviderImpl<NewsEndPoint>(
            networkManager: networkManagerImpl,
            encoder: JSONEncoder(),
            decoder: JSONDecoder()
        )
        let newsNetworkService = NewsNetworkServiceImpl(newsProvider: newsNetworkServiceProvider)
        self.newsNetworkService = newsNetworkService
        
        let newsService = NewsServiceImpl(newsNetworkService: newsNetworkService)
        self.newsService = newsService
    }
}
