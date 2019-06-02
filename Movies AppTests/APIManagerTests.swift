//
//  APIManagerTests.swift
//  Movies AppTests
//
//  Created by Tarun Gorre on 01.06.19.
//  Copyright © 2019 Tarun Gorre. All rights reserved.
//

import XCTest
@testable import Movies_App

class APIManagerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    func testAPIClient() {
        let jsonUrl = URL(string: "https://api.themoviedb.org/3/movie/now_playing?page=1&language=en-US&api_key=68d9195b856d6960e5a60da525d650bf")
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        URLSession.shared.dataTask(with: jsonUrl!) { (data, response, error) in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
            }.resume()
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }

    func testJsonDecoding() {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "Movies", withExtension: "json"),
            let data = try? Data(contentsOf: url) else {
                return
        }
        
        guard let jsonObject = try? JSONDecoder().decode(MoviesResponse.self, from: data) else {
            return
        }
        let movies = jsonObject.results
        XCTAssertEqual(movies.count, 20)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
