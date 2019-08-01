//
//  Movie.swift
//  BMovies
//
//  Created by Rodrigo Busata on 05/07/19.
//  Copyright © 2019 Busata. All rights reserved.
//

import Foundation

class Movie: NSObject, Codable {
    
    var id: Int?
    var voteCount: Int?
    var video: Bool = false
    var voteAverage: Double?
    var title: String?
    var popularity: Double?
    var posterPath: String?
    var originalLanguage: String?
    var originalTitle: String?
    var genreIds: [Int]?
    var backdropPath: String?
    var adult: Bool = false
    var overview: String?
    var releaseDate: Date?
    
    var genresString: String {
        let genres = self.genreIds?.map({ (genreId) -> String in
            return App.shared.genres.first(where: {$0.id == genreId})?.name ?? ""
        }) ?? []
        
        return genres.filter({!$0.isEmpty}).joined(separator: " / ")
    }
    
    var posterURL: URL? {
        if let posterPath = self.posterPath {
            return URL(string: App.shared.ApiImgEndPoint + "/w500" + posterPath)
        }
        
        return nil
    }
    
    var backdropURL: URL? {
        if let backdropPath = self.backdropPath {
            return URL(string: App.shared.ApiImgEndPoint + "/original" + backdropPath)
        }
        
        return nil
    }
}
