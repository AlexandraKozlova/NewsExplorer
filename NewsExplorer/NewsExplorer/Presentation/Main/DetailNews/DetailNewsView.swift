//
//  DetailNewsView.swift
//  NewsExplorer
//
//  Created by Aleksandra on 04.10.2023.
//

import SwiftUI

struct DetailNewsView: View {
    
    @Binding var news: News?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Image(systemName: "photo.artframe")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
                    .foregroundColor(.orange)
                    .frame(height: UIScreen.main.bounds.height * 0.3)
                    .padding(.vertical, 40)
                
                HStack {
                    Text(news?.author ?? "")
                        .font(.body)
                        .foregroundColor(.gray)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Text(formatDateString(news?.publishedAt ?? ""))
                        .font(.body)
                        .foregroundColor(.gray)
                        .fontWeight(.semibold)
                }
                
                Text(news?.title ?? "")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                
                Text(news?.description ?? "")
                    .font(.title3)
                    .foregroundColor(Color.black)
                
                Text("Source: \(news?.source ?? "")")
                    .font(.body)
                    .foregroundColor(.blue)
                    .fontWeight(.semibold)
                
                Spacer()
            }
            .padding(.horizontal, 20)
        }
        .background(Color(.white))
        .navigationBarHidden(true)
    }
    
    private func formatDateString(_ dateString: String) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            
            if let date = dateFormatter.date(from: dateString) {
                dateFormatter.dateFormat = "dd MMM yyyy"
                return dateFormatter.string(from: date)
            } else {
                return dateString
            }
        }
}

struct DetailNews_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailNewsView(news: .constant(News(id: "1",
                                                author: "Zahra Tayeb",
                                                title: "Bitcoin has plunged almost 20% since Standard Chartered predicted the crypto could surge to $120,000",
                                                description: "The world's largest cryptocurrency has had a weak August, finishing 10% lower for the second month in a row amid a broader sell-off in stocks and bonds.",
                                                publishedAt: "2023-09-05T13:38:23Z",
                                                source: "Business Insider")))
        }
        .preferredColorScheme(.dark)
    }
}
