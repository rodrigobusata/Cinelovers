//
//  SplashPresenter.swift
//  BMovies
//
//  Created by Rodrigo Busata on 05/07/19.
//  Copyright © 2019 Busata. All rights reserved.
//

import Foundation
import Alamofire

class SplashPresenter {
    
    func getGenreList(completion: @escaping (Swift.Result<GetGenreResponse, ApiError>) -> Void) {
        
        let language = Locale.preferredLanguages[0]
        
        Alamofire.request(App.shared.ApiEndpoint + "/genre/movie/list?language=\(language)",
                          parameters: App.shared.ApiParameters).responseJSON { response in
                            
            guard let data = response.data, let json = String(data: data, encoding: .utf8) else {
                completion(.failure(.badRequest))
                return
            }
            
            if let response = GetGenreResponse.from(json: json) {
                completion(.success(response))
                
            } else {
                completion(.failure(.parseFailed))
            }
        }
    }
}
