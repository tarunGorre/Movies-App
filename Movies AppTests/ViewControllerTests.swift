//
//  ViewControllerTests.swift
//  Movies AppTests
//
//  Created by Tarun Gorre on 01.06.19.
//  Copyright © 2019 Tarun Gorre. All rights reserved.
//

import XCTest
@testable import Movies_App

class ViewControllerTests: XCTestCase {

    var viewControllerUnderTest: ViewController!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.viewControllerUnderTest = (storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController)
        self.viewControllerUnderTest.loadView()
        self.viewControllerUnderTest.viewDidLoad()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testHasACollectionView() {
        XCTAssertNotNil(viewControllerUnderTest.collectionView)
    }
    
    func testCollectionViewHasDelegate() {
        XCTAssertNotNil(viewControllerUnderTest.collectionView.delegate)
    }
    
    func testCollectionViewConformsToCollectionViewDelegateProtocol() {
        XCTAssertTrue(viewControllerUnderTest.conforms(to: UICollectionViewDelegate.self))
        XCTAssertTrue(viewControllerUnderTest.conforms(to: UICollectionViewDelegateFlowLayout.self))

    }

    func testCollectionViewHasDataSource() {
        XCTAssertNotNil(viewControllerUnderTest.collectionView.dataSource)
    }

    func testCollectionViewConformsToCollectionViewDataSourceProtocol() {
        XCTAssertTrue(viewControllerUnderTest.conforms(to: UICollectionViewDataSource.self))
        
    }
}
