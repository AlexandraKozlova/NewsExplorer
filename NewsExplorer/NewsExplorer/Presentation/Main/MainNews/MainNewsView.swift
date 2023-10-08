//
//  MainNewsView.swift
//  NewsExplorer
//
//  Created by Aleksandra on 04.10.2023.
//

import SwiftUI

struct MainNewsView: View {
    // MARK: - Properties
    @EnvironmentObject private var viewModel: MainNewsViewModel
    
    @State private var selectedNews: News? = nil
    @State private var showDetailView: Bool = false
    
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    
    @State private var isStartDatePickerVisible = false
    @State private var isEndDatePickerVisible = false
    @State private var isSortOptionsVisible = false
    @State private var selectedSortOption: SortOption = .relevancy
    
    @State private var selectedDate = Date()
    @State private var showDatePicker = false
    
    private var september2023: Date {
        var components = DateComponents()
        components.year = 2023
        components.month = 9
        components.day = 1
        return Calendar.current.date(from: components)!
    }
    
    // MARK: - Body
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
                
                dateButonsView
                
                if isStartDatePickerVisible || isEndDatePickerVisible {
                    datePickerView
                }
                
                sortByButtonView
                
                if isSortOptionsVisible {
                    sortOptionsView
                        .padding(.top, 8)
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(radius: 2)
                        .zIndex(2)
                        .padding(.horizontal, 20)
                    
                }
                
                listOfNews
            }
            .padding(.vertical, 20)
            .sheet(isPresented: $showDetailView) {
                DetailNewsView(news: $selectedNews)
            }
        }
    }
}

// MARK: - Views
private extension MainNewsView {
    var listOfNews: some View {
        List {
            ForEach(viewModel.allNews) { news in
                NewsRowView(news: news)
                    .listRowInsets(.init(top: 0,
                                         leading: 0,
                                         bottom: 10,
                                         trailing: 0))
                    .onTapGesture {
                        selectedNews = news
                        showDetailView.toggle()
                    }
                    .listRowBackground(Color.white)
            }
            
            .listStyle(.plain)
        }
        .scrollContentBackground(.hidden)
    }
    
    var sortOptionsView: some View {
        VStack {
            ForEach(SortOption.allCases, id: \.self) { option in
                Button(action: {
                    selectedSortOption = option
                    viewModel.sortOption = option
                    isSortOptionsVisible.toggle()
                }) {
                    Text(option.buttonTitle)
                        .foregroundColor(.indigo)
                }
                .padding(5)
            }
        }
    }
    
    var dateButonsView: some View {
        HStack {
            Button(action: {
                isStartDatePickerVisible.toggle()
                isEndDatePickerVisible = false
            }) {
                Text("From: \(startDate.formattedDateTo(format: .ddMMMyyyy))")
                    .foregroundColor(Color.indigo)
            }
            .padding(.horizontal, 10)
            .frame(height: 30)
            .background(Color.white)
            .cornerRadius(8)
            
            Spacer()
            
            Button(action: {
                isEndDatePickerVisible.toggle()
                isStartDatePickerVisible = false
            }) {
                Text("To: \(endDate.formattedDateTo(format: .ddMMMyyyy))")
                    .foregroundColor(Color.indigo)
            }
            .padding(.horizontal, 10)
            .frame(height: 30)
            .background(Color.white)
            .cornerRadius(8)
        }
        .shadow(radius: 2)
        .padding(.horizontal, 10)
    }
    
    var datePickerView: some View {
        DatePicker("",
                   selection: isStartDatePickerVisible ? $startDate : $endDate,
                   in: september2023...,
                   displayedComponents: .date)
        .datePickerStyle(.graphical)
        .padding(.horizontal, 30)
        .onChange(of: startDate) { newValue in
            viewModel.startDate = newValue
        }
        
        .onChange(of: endDate) { newValue in
            viewModel.endDate = newValue
        }
    }
    
    var sortByButtonView: some View {
        Button(action: {
            isSortOptionsVisible.toggle()
        }) {
            Text("Sort by: \(selectedSortOption.buttonTitle)")
                .foregroundColor(Color.indigo)
        }
        .padding(.horizontal, 10)
        .frame(height: 30)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 2)
        .padding(.horizontal, 10)
    }
}

// MARK: - Preview
struct MainNewsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MainNewsView()
                .navigationBarHidden(true)
        }
        .preferredColorScheme(.light)
        .environmentObject(MainNewsViewModel(appContainer: AppContainerImpl()))
    }
}
