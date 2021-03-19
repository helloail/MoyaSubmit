//
//  MovieService.swift
//  MoyaSubmit
//
//  Created by Moh Zinnur Atthufail Addausi on 17/03/21.
//

import Foundation
import Moya

enum MovieService {
    case popular
}

extension MovieService : TargetType {
    var baseURL: URL {
        let baseUrl = R.String.BaseURL.baseUrl
        guard let url = URL(string: baseUrl) else {
            fatalError("URL cannot be configured.")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .popular:
            return "/popular"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .popular:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .popular:
            return .requestParameters(
                parameters: ["api_key" : R.String.BaseURL.apikey]
                , encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type" : "application/json"]
    }
}
