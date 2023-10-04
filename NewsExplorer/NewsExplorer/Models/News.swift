//
//  News.swift
//  NewsExplorer
//
//  Created by Aleksandra on 04.10.2023.
//

import Foundation

struct News: Identifiable {
    let id: String
    let author: String
    let title: String
    let description: String
    let publishedAt: String
    let source: String
}
