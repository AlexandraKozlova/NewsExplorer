//
//  MainNewsViewModel.swift
//  NewsExplorer
//
//  Created by Aleksandra on 04.10.2023.
//

import Foundation
import Combine

final class MainNewsViewModel: ObservableObject {
    // MARK: - Published
    @Published var searchingText = ""
    @Published var allNews: [News] = [News(id: "", author: "hygfhdj", title: "hfugvj", description: "hdfuhnfdjsdcv", publishedAt: "hfduvc", source: "hfduvcjn", imageURL: "dfhujd")]
    @Published var sortOption: SortOption = .relevancy
    @Published var startDate: Date? = nil
    @Published var endDate: Date? = nil
    
    // MARK: - Properties
    private var cancellableSet = Set<AnyCancellable>()
    private let appContainer: AppContainer
    private let newsService: NewsService
    
    // MARK: - Init
    init(appContainer: AppContainer) {
        self.appContainer = appContainer
        self.newsService = appContainer.newsService
        loadNews()
        setupBinding()
    }
}

// MARK: - Private setup
private extension MainNewsViewModel {
    func setupBinding() {
        $searchingText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] searchText in
                self?.loadNews()
            }
            .store(in: &cancellableSet)
        
        $sortOption
            .sink { [weak self] sortOption in
                self?.loadNews()
            }
            .store(in: &cancellableSet)
        
        $startDate
            .sink { [weak self] sortOption in
                self?.loadNews()
            }
            .store(in: &cancellableSet)
        
        $endDate
            .sink { [weak self] sortOption in
                self?.loadNews()
            }
            .store(in: &cancellableSet)
    }
    
    func loadNews() {
        let topic = searchingText.isEmpty ? "bitcoin" : searchingText
        let sortBy = sortOption.apiCall
        let model = NewsRequest(topic: topic,
                                sortBy: sortBy,
                                startDate: startDate?.formattedDateTo(format: .yyyy_MM_dd),
                                endDate: endDate?.formattedDateTo(format: .yyyy_MM_dd))
//        allNews.removeAll()
        
        
//        newsService.getNewsFor(newsModel: model)
//            .receive(on: DispatchQueue.main)
//            .sink { error in
//                print(error)
//            } receiveValue: { news in
//                self.allNews = news
//            }
//            .store(in: &cancellableSet)
    }
}
