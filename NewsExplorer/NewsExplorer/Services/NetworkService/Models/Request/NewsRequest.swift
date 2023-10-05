//
//  NewsRequest.swift
//  NewsExplorer
//
//  Created by Aleksandra on 05.10.2023.
//

import Foundation

struct NewsRequest {
    let topic: String
    let sortBy: String
    let startDate: String?
    let endDate: String?
}
