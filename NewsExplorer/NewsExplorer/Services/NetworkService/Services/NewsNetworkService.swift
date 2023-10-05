//
//  NewsNetworkService.swift
//  NewsExplorer
//
//  Created by Aleksandra on 05.10.2023.
//

import Foundation
import Combine

protocol NewsNetworkService {
    func getNews(_ requestModel: NewsRequest) -> AnyPublisher<NewsResponse, NetworkError>
}

final class NewsNetworkServiceImpl<NetworkProvider: NetworkServiceProvider> where NetworkProvider.E == NewsEndPoint {
    let newsProvider: NetworkProvider

    init(newsProvider: NetworkProvider) {
        self.newsProvider = newsProvider
    }
}

extension NewsNetworkServiceImpl: NewsNetworkService {
    func getNews(_ requestModel: NewsRequest) -> AnyPublisher<NewsResponse, NetworkError> {
        return newsProvider.execute(endpoint: .news(requestModel))
    }
}
