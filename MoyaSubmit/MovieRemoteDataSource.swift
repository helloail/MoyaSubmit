//
//  MovieRemoteDataSource.swift
//  MoyaSubmit
//
//  Created by Moh Zinnur Atthufail Addausi on 18/03/21.
//

import Foundation
import Moya
import RxSwift

protocol MovieRemoteDataSourceProtocol {
    func catchMoviesList() -> Single<MovieModel>
}

enum error : Swift.Error  {
    case error
}

class MovieRemoteDataSource: MovieRemoteDataSourceProtocol  {
    
    let provider = MoyaProvider<MovieService>( )
    func catchMoviesList() -> Single<MovieModel> {
        return Single.create { single -> Disposable in
            return self.provider.rx.request(.popular)
                .subscribe { response in
                    if response.statusCode == 200 {
                        do {
                            let dataresult = try JSONDecoder().decode(MovieModel.self, from: response.data)
                            return single(.success(dataresult))
                        }catch{
                            return single(.error(error))
                        }
                    }else{
                        return single(.error(error.error))
                    }
                } onError: { (error) in
                    return single(.error(error))
                }
        }
    }
}

