//
//  PhoneNumbersDataSourceTests.swift
//  Dialer
//
//  Created by Женя Михайлова on 22.11.16.
//  Copyright © 2016 Evgeniya Mikhailova. All rights reserved.
//

import XCTest
@testable import Dialer

class PhoneNumbersDataSourceTests: XCTestCase {

    var dataSource : PhoneNumbersDataSourceInterface?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.dataSource = PhoneNumbersDataSource()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.dataSource = nil;
        super.tearDown()
    }
    
    func testLoadObjects() {
        // after first load there should be 12 objects with mapped = false
        let count = 12
       // let testExpectation = expectation(description: "Load phoneobjects")
        
        dataSource?.load({ (result) in
           // testExpectation.fulfill()
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
                XCTAssert(data.count == count)
            case .failure(let error):
                XCTFail()
            }
        })
        
//        waitForExpectations(timeout: 5) { error in
//            XCTFail()
//        }
    }
    
    func testCreateObjects() {
        
        let count = 12
        let data = dataSource?.createObjects(count: count)
        
        XCTAssertNotNil(data)
        XCTAssert(data != nil && data!.count == count)
    }
    
    func testSaveObjects() {
        
        let count = 12
        let data = dataSource?.createObjects(count: count)
        
        XCTAssertNotNil(data)
        XCTAssert(data != nil && data!.count == count)
        
        let saved = dataSource?.save(array: data!)
        
        XCTAssert(saved == true)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
