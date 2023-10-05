//
//  DetailNewsView.swift
//  NewsExplorer
//
//  Created by Aleksandra on 04.10.2023.
//

import SwiftUI
import Kingfisher

struct DetailNewsView: View {
    @Binding var news: News?
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                KFImage(URL(string: news?.imageURL ?? ""))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipped()
                    .frame(height: UIScreen.main.bounds.height * 0.4)
                    .padding(.horizontal, 10)
                
                HStack {
                    Text(news?.author ?? "")
                        .font(.body)
                        .foregroundColor(.gray)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Text(Date(dateString: news?.publishedAt ?? "").formattedDateTo(format: .ddMMMyyyy))
                        .font(.body)
                        .foregroundColor(.gray)
                        .fontWeight(.semibold)
                }
                .padding(.horizontal, 20)
                
                Text(news?.title ?? "")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                    .padding(.horizontal, 20)
                
                Text(news?.description ?? "")
                    .font(.title3)
                    .foregroundColor(Color.black)
                    .padding(.horizontal, 20)
                
                Text("Source: \(news?.source ?? "")")
                    .font(.body)
                    .foregroundColor(.blue)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 20)
                Spacer()
            }
        }
        .background(Color(.white))
        .navigationBarHidden(true)
    }
}

// MARK: - Preview
struct DetailNews_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailNewsView(news: .constant(News(id: "1",
                                                author: "Zahra Tayeb",
                                                title: "Bitcoin has plunged almost 20% since Standard Chartered predicted the crypto could surge to $120,000",
                                                description: "The world's largest cryptocurrency has had a weak August, finishing 10% lower for the second month in a row amid a broader sell-off in stocks and bonds.",
                                                publishedAt: "2023-09-05T13:38:23Z",
                                                source: "Business Insider", imageURL: nil)))
        }
        .preferredColorScheme(.dark)
    }
}
