//
//  SplashTests.swift
//  BMoviesTests
//
//  Created by Rodrigo Busata on 05/07/19.
//  Copyright © 2019 Busata. All rights reserved.
//

import XCTest
@testable import BMovies
import Alamofire

class SplashTests: XCTestCase {
    
    var presenter: SplashPresenter?
    
    override func setUp() {
        self.presenter = SplashPresenter()
    }
    
    func testGetGenreList() {
        let expectation = self.expectation(description: "getGenreList")
        
        self.presenter?.getGenreList() { result in
            switch result {
            case .success(let response):
                XCTAssertGreaterThan(response.genres?.count ?? 0, 0)
                
                if let genre = response.genres?.first{
                    XCTAssertNotNil(genre.id)
                    XCTAssertNotNil(genre.name)
                    
                } else {
                    XCTFail("Genre is null")
                }
                
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 15)
    }
}

