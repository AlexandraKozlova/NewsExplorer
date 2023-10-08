//
//  NewsEndPoint.swift
//  NewsExplorer
//
//  Created by Aleksandra on 05.10.2023.
//

import Foundation

enum NewsEndPoint: Endpoint {
    case news(_ requestModel: NewsRequest)
    
    var baseURL: URL? {
        return URL(string: "https://newsapi.org/v2/everything")
    }
    var path: String? {
        return ""
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: HTTPHeaders {
        return ["X-Api-Key" : "dc3baf7b942c4926b3309338fbf0cb01"]
    }
    
    var queries: HTTPQueries {
        switch self {
        case .news(let model):
            guard let startDate = model.startDate,
                  let endDate = model.endDate else {
                return ["q": model.topic,
                        "sortBy" : model.sortBy]
            }

            return ["q": model.topic,
                    "sortBy" : model.sortBy,
                    "from" : startDate,
                    "to" : endDate]
        }
    }
}
