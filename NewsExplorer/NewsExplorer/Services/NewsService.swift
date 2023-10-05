//
//  NewsService.swift
//  NewsExplorer
//
//  Created by Aleksandra on 05.10.2023.
//

import Foundation
import Combine

protocol NewsService {
    func getNewsFor(newsModel: NewsRequest) -> AnyPublisher<[News], Error>
}

// MARK: - NewsService
final class NewsServiceImpl: NewsService {
    private let newsNetworkService: NewsNetworkService
    private var cancellables = Set<AnyCancellable>()
    
    private var allNews: [News] = []
    
    // MARK: - Init
    init(newsNetworkService: NewsNetworkService) {
        self.newsNetworkService = newsNetworkService
    }
    
    func getNewsFor(newsModel: NewsRequest) -> AnyPublisher<[News], Error> {
        
        return Future<[News], Error> { [unowned self] promise in
            newsNetworkService.getNews(newsModel)
                .sink(receiveCompletion: { error in
                    switch error {
                    case .finished:
                        break
                    case .failure(let failure):
                        promise(.failure(failure))
                    }
                }, receiveValue: { news in
                    for article in news.articles {
                        
                        self.allNews.append(News(id: UUID().uuidString,
                                                 author: article.author,
                                                 title: article.title,
                                                 description: article.description,
                                                 publishedAt: article.publishedAt,
                                                 source: article.source.name,
                                                 imageURL: article.urlToImage))
                    }
                    promise(.success(self.allNews))
                })
                .store(in: &cancellables)
        }
        .eraseToAnyPublisher()
    }
}

