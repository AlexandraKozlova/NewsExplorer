//
//  SortOption.swift
//  NewsExplorer
//
//  Created by Aleksandra on 05.10.2023.
//

import Foundation

enum SortOption: CaseIterable {
    case relevancy
    case popularity
    case publishedAt
}

extension SortOption {
    var apiCall: String {
        switch self {
        case .relevancy:
            return "relevancy"
        case .popularity:
            return "popularity"
        case .publishedAt:
            return "publishedAt"
        }
    }
    
    var buttonTitle: String {
        switch self {
        case .relevancy:
            return "Relevancy"
        case .popularity:
            return "Popularity"
        case .publishedAt:
            return "Date"
        }
    }
}
