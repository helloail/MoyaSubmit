//
//  MovieViewModel.swift
//  MoyaSubmit
//
//  Created by Moh Zinnur Atthufail Addausi on 18/03/21.
//

import Foundation

class MovieViewModel: ObservableObject {
    
    private var movieservice: MovieRemoteDataSourceProtocol
    @Published private(set) var state = LoadedStateHelper.idle
    @Published var movielist = [Result]()
    @Published var url = ""
    @Published var page = 1
    
     init(movieservice: MovieRemoteDataSourceProtocol = MovieRemoteDataSource() ) {
        
        self.movieservice = movieservice
    }
    
    func fetchArticleExecute() {
        
        self.movieservice.catchMoviesList() { [weak self] result in
            
            switch result {
            
            case .success(let result) :
           
                DispatchQueue.main.async {
                    guard let data = result.results else {
                        return
                    }
                    self?.movielist = data
                    
                    if self?.movielist.count == 0 {
                        self?.state = .empty
                    } else {
                        self?.state = .loaded
                    }
                }
            case .failure(let error):
                
                self?.state = .error(error)
                
            }
        }
    }
}
