//
//  MovieViewModel.swift
//  MoyaSubmit
//
//  Created by Moh Zinnur Atthufail Addausi on 18/03/21.
//

import Foundation
import RxSwift

class MovieViewModel: ObservableObject {
    
    private var movieservice: MovieRemoteDataSourceProtocol
    @Published private(set) var state = LoadedStateHelper.idle
    @Published var movielist = [Result]()
    @Published var url = ""
    @Published var page = 1
    let disposebag = DisposeBag()
    
     init(movieservice: MovieRemoteDataSourceProtocol = MovieRemoteDataSource() ) {
        
        self.movieservice = movieservice
     }
    func fetchArticleExecute(){
        self.state = .loading
        self.movieservice.catchMoviesList()
            .subscribeOn(MainScheduler.instance)
            .subscribe { Movie in
                self.movielist = Movie.results ?? []
                self.state = .loaded
            } onError: { error in
                self.state = .error(error)
                self.state = .loaded
            }.disposed(by: disposebag)
    }
}
