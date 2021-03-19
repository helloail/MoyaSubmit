//
//  MovieRemoteDataSource.swift
//  MoyaSubmit
//
//  Created by Moh Zinnur Atthufail Addausi on 18/03/21.
//

import Foundation
import Moya

protocol MovieRemoteDataSourceProtocol {
    func catchMoviesList(completion: @escaping ((Swift.Result<MovieModel, Error>) -> Void))
}
class MovieRemoteDataSource: MovieRemoteDataSourceProtocol  {
    let provider = MoyaProvider<MovieService>( plugins: [VerbosePlugin(verbose: true)])

    func catchMoviesList(completion: @escaping ((Swift.Result<MovieModel, Error>) -> Void)) {
     
        provider.request(.popular) { result in
            switch result{
            case .success(let response) :
                do {
                    let posts = try JSON().newJSONDecoder().decode(MovieModel.self, from: response.data)
                    completion(.success(posts))
                } catch (let error) {
                    completion(.failure(error))
                }
            case .failure(let error) :
                completion(.failure(error))
            }
        }
    }
}
