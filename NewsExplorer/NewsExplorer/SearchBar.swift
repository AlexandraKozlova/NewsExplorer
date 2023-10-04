//
//  SearchBar.swift
//  NewsExplorer
//
//  Created by Aleksandra on 04.10.2023.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchingText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchingText.isEmpty ?
                    Color.secondary : Color.black
                )
            TextField("Search by title", text: $searchingText)
                .foregroundColor(Color.black)
                .disableAutocorrection(true)
                .overlay(
                Image(systemName: "xmark.circle.fill")
                    .padding()
                    .offset(x: 10)
                    .foregroundColor(Color.black)
                    .opacity(searchingText.isEmpty ? 0.0 : 1.0)
                    .onTapGesture {
                        UIApplication.shared.endEditing()
                        searchingText = ""
                    }
                ,alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.15),
                        radius: 10, x: 0, y: 0)
        )
        .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchingText: .constant(""))
    }
}
