//
//  MovieDetailsViewControllerTests.swift
//  Movies AppTests
//
//  Created by Tarun Gorre on 01.06.19.
//  Copyright © 2019 Tarun Gorre. All rights reserved.
//

import XCTest
@testable import Movies_App

class MovieDetailsViewControllerTests: XCTestCase {

    var viewControllerUnderTest: MovieDetailsViewController!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.viewControllerUnderTest = (storyboard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController)
        
        self.viewControllerUnderTest.loadView()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testHasACollectionView() {
        XCTAssertNotNil(viewControllerUnderTest.similarMoviesCollectionView)
    }
    
    func testCollectionViewHasDelegate() {
        XCTAssertNotNil(viewControllerUnderTest.similarMoviesCollectionView.delegate)
    }
    
    func testCollectionViewConformsToCollectionViewDelegateProtocol() {
        XCTAssertTrue(viewControllerUnderTest.conforms(to: UICollectionViewDelegate.self))
        XCTAssertTrue(viewControllerUnderTest.conforms(to: UICollectionViewDelegateFlowLayout.self))
        
    }
    
    func testCollectionViewHasDataSource() {
        XCTAssertNotNil(viewControllerUnderTest.similarMoviesCollectionView.dataSource)
    }
    
    func testCollectionViewConformsToCollectionViewDataSourceProtocol() {
        XCTAssertTrue(viewControllerUnderTest.conforms(to: UICollectionViewDataSource.self))
        
    }
    
    func testCollectionViewCellHasReuseIdentifier() {
        let cell = viewControllerUnderTest.collectionView(viewControllerUnderTest.similarMoviesCollectionView, cellForItemAt: IndexPath(row: 0, section: 0)) as? SimilarMovieCollectionCell

        let actualReuseIdentifer = cell?.reuseIdentifier
        let expectedReuseIdentifier = "SimilarMovieCollectionCell"
        XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
    }

}
