//
//  MovieTests.swift
//  BMoviesTests
//
//  Created by Rodrigo Busata on 05/07/19.
//  Copyright © 2019 Busata. All rights reserved.
//

import XCTest
@testable import BMovies
import Alamofire

class MovieTests: XCTestCase {
    
    var presenter: MoviePresenter?
    
    override func setUp() {
        self.presenter = MoviePresenter()
    }
    
    func testGetUpcomingMovies() {
        let expectation = self.expectation(description: "GetUpcomingMovies")
        
        self.presenter?.getUpcomingMovies(page: 1) { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.page, 1)
                XCTAssertGreaterThan(response.results?.count ?? 0, 0)
                XCTAssertGreaterThan(response.totalPages, 0)
                XCTAssertGreaterThan(response.totalResults, 0)
                
                if let movie = response.results?.first  {
                    XCTAssertNotNil(movie.id)
                    XCTAssertNotNil(movie.title)
                    XCTAssertNotNil(movie.releaseDate)
                 
                } else {
                    XCTFail("Movie is null")
                }
                
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 15)
    }
}
