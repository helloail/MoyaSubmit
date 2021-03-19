//
//  ContentView.swift
//  MoyaSubmit
//
//  Created by Moh Zinnur Atthufail Addausi on 17/03/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var movieVM: MovieViewModel = MovieViewModel()
    
    var body: some View {
        
        ZStack {
            switch self.movieVM.state {
            case .idle, .loading :
                Text("")
            case .error(let error):
                Text("Error \(error.localizedDescription)")
            case .loaded:
                VStack {
                    content
                }
            case .empty:
                Text("")
            }
            
        }.onAppear {
            self.movieVM.fetchArticleExecute()
        }
    }
}

extension ContentView {
    
    var content: some View {
        ScrollView {
            ForEach(self.movieVM.movielist, id: \.id) { categoryResult in
                Text(categoryResult.title ?? "")
            }.buttonStyle(PlainButtonStyle())
        }.padding(.top, 16)
    }
}

