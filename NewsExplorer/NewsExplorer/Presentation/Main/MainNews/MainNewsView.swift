//
//  MainNewsView.swift
//  NewsExplorer
//
//  Created by Aleksandra on 04.10.2023.
//

import SwiftUI

struct MainNewsView: View {
    @EnvironmentObject private var viewModel: MainNewsViewModel
    
    @State private var selectedNews: News? = nil
    @State private var showDetailView: Bool = false
    
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
   
    @State private var isStartDatePickerVisible = false
    @State private var isEndDatePickerVisible = false

    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.1)
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                Text("Life News")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.blue)
                    .padding(.horizontal, 30)
                
                SearchBarView(searchingText: $viewModel.searchingText)
                
                HStack {
                    Text("Since: \(formattedDate(startDate))")
                        .onTapGesture {
                            isStartDatePickerVisible.toggle()
                            isEndDatePickerVisible = false
                        }
                        .padding(.horizontal, 20)
                    
                    
                    Spacer()
                    
                    Text("To: \(formattedDate(endDate))")
                        .onTapGesture {
                            isEndDatePickerVisible.toggle()
                            isStartDatePickerVisible = false
                        }
                        .padding(.horizontal, 20)
                }
                
                if isStartDatePickerVisible || isEndDatePickerVisible {
                    DatePicker("",
                               selection: isStartDatePickerVisible ? $startDate : $endDate,
                               displayedComponents: .date)
                    .datePickerStyle(.compact)
                    .padding(.horizontal, 30)
                }
                
                List {
                    ForEach(viewModel.allNews) { news in
                        NewsRowView(news: news)
                            .listRowInsets(.init(top: 0,
                                                 leading: 0,
                                                 bottom: 10,
                                                 trailing: 0))
                            .onTapGesture {
                                segue(news: news)
                            }
                            .listRowBackground(Color.white)
                    }
                    .listStyle(.plain)
                }
            }
            .padding(.vertical, 20)
            .sheet(isPresented: $showDetailView) {
                DetailNewsView(news: $selectedNews)
            }
        }
    }
    
    private func segue(news: News) {
        selectedNews = news
        showDetailView.toggle()
    }
    
    private func formattedDate(_ date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy"
            return dateFormatter.string(from: date)
        }
}

struct MainNewsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MainNewsView()
                .navigationBarHidden(true)
        }
        .preferredColorScheme(.light)
        .environmentObject(MainNewsViewModel())
    }
}
