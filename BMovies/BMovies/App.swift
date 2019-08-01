//
//  App.swift
//  BMovies
//
//  Created by Rodrigo Busata on 05/07/19.
//  Copyright © 2019 Busata. All rights reserved.
//

import Foundation

struct App {
    
    static var shared = App()
    
    private init() {
    }
    
    let ApiEndpoint = "https://api.themoviedb.org/3"
    let ApiImgEndPoint = "https://image.tmdb.org/t/p"
    
    let ApiParameters: [String: Any] = [
        "api_key": "1f54bd990f1cdfb230adb312546d765d"
    ]
    
    var genres: [Genre] = []
}
