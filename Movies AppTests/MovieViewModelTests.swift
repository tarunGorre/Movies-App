//
//  MovieViewModelTests.swift
//  Movies AppTests
//
//  Created by Tarun Gorre on 01.06.19.
//  Copyright © 2019 Tarun Gorre. All rights reserved.
//

import XCTest
@testable import Movies_App
class MovieViewModelTests: XCTestCase {
    let movieViewModel = MovieViewModel()
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "Movies", withExtension: "json"),
            let data = try? Data(contentsOf: url) else {
                return
        }
        
        guard let jsonObject = try? JSONDecoder().decode(MoviesResponse.self, from: data) else {
            return
        }
        movieViewModel.movies = jsonObject.results
        movieViewModel.similarMovies = jsonObject.results

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchTheNewMovies() {
        
        let promise = expectation(description: "Completion handler invoked")
        
        movieViewModel.fetchTheNewMovies { allMovies in
            XCTAssertNotNil(allMovies)
            promise.fulfill()
        }
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
        
    }
    
    func testFetchTheSimilarMovies() {
        
        let promise = expectation(description: "Completion handler invoked")
        
        movieViewModel.fetchSimilarMovies(movieId: 14) { allMovies in
            XCTAssertNotNil(allMovies)
            promise.fulfill()
        }
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
        
    }
    
    func testNumberOfMovies() {
        let count =  movieViewModel.numberOfMovies()
        XCTAssertEqual(count, 20)

    }
    
    func testNumberOfSimilarMovies() {
        let count =  movieViewModel.numberOfSimilarMovies()
        XCTAssertEqual(count, 20)
        
    }
    
    func testFetchTheMovie() {
        let movieObject =  movieViewModel.fetchTheMovie(index: 0)
        XCTAssertEqual(movieObject?.id, 420817)
    }

    func testFetchSimilarMovie() {
        let movieObject =  movieViewModel.fetchSimilarMovie(index: 0)
        XCTAssertEqual(movieObject?.id, 420817)
    }

    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
