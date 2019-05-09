//
//  MoviePresenter.swift
//  BMovies
//
//  Created by Rodrigo Busata on 05/07/19.
//  Copyright © 2019 Busata. All rights reserved.
//

import Foundation
import Alamofire

class MoviePresenter {
    
    func getUpcomingMovies(page: Int = 1, completion: @escaping (Swift.Result<GetMoviesResponse, ApiError>) -> Void) {
        var params = App.shared.ApiParameters
        params["page"] = page
        params["language"] = Locale.preferredLanguages[0]
        
        Alamofire.request(App.shared.ApiEndpoint + "/movie/upcoming",
                          parameters: params).responseJSON { response in
        
            guard let data = response.data, let json = String(data: data, encoding: .utf8) else {
                completion(.failure(.badRequest))
                return
            }
            
            if let response = GetMoviesResponse.from(json: json) {
                completion(.success(response))
            
            } else {
                completion(.failure(.parseFailed))
            }
        }
    }
}
