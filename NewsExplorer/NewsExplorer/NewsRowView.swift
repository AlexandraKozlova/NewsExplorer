//
//  NewsRowView.swift
//  NewsExplorer
//
//  Created by Aleksandra on 04.10.2023.
//

import SwiftUI

struct NewsRowView: View {
    let news: News
    
    var body: some View {
        HStack(spacing: 0) {
            leftColumn
        }
//        .background(
//            RoundedRectangle(cornerRadius: 25)
//                .fill(Color.white.opacity(0.2))
//                .shadow(color: Color.black.opacity(0.15),
//                        radius: 10, x: 0, y: 0))
        .font(.subheadline)
    }
}

struct NewsRowView_Previews: PreviewProvider {
    static var previews: some View {
        NewsRowView(news: News(id: "1",
                               author: "Zahra Tayeb",
                                   title: "Bitcoin has plunged almost 20% since Standard Chartered predicted the crypto could surge to $120,000",
                                   description: "The world's largest cryptocurrency has had a weak August, finishing 10% lower for the second month in a row amid a broader sell-off in stocks and bonds.",
                               publishedAt: "2023-09-05T13:38:23Z",
                               source: "Business Insider"))
    }
}

extension NewsRowView {
    
    private var leftColumn: some View {
        VStack(spacing: 0) {
            Text(news.title)
                .font(.title2)
                .padding(12)
                .foregroundColor(Color.black)
                .fontWeight(.bold)
            Text("\(news.description)")
                .font(.body)
                .foregroundColor(Color.black)
                .frame(minWidth: 30)
                .padding(12)
        }
    }
}
