//
//  MainNewsViewModel.swift
//  NewsExplorer
//
//  Created by Aleksandra on 04.10.2023.
//

import Foundation
import Combine

class MainNewsViewModel: ObservableObject {
    @Published var searchingText = ""
    @Published var allNews: [News] = [News(id: "1",
                                           author: "Zahra Tayeb",
                                           title: "Bitcoin has plunged almost 20% since Standard Chartered predicted the crypto could surge to $120,000",
                                           description: "The world's largest cryptocurrency has had a weak August, finishing 10% lower for the second month in a row amid a broader sell-off in stocks and bonds.",
                                           publishedAt: "2023-09-05T13:38:23Z",
                                           source: "Business Insider"),
    News(id: "2",
         author: "Zahra Tayeb",
         title: "Cathie Wood's ARK and 21Shares plan America's first ether ETF as race to open spot bitcoin funds heats up",
         description: "The joint SEC filing comes as the race to launch the first exchange-traded fund backed by bitcoin gathers pace.",
         publishedAt: "2023-09-07T10:33:27Z",
         source: "Business Insider")]
}
