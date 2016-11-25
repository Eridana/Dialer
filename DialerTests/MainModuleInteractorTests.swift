//
//  MainModuleInteractorTests.swift
//  Dialer
//
//  Created by Женя Михайлова on 23.11.16.
//  Copyright © 2016 Evgeniya Mikhailova. All rights reserved.
//

import XCTest
@testable import Dialer

class MainModuleInteractorTests: XCTestCase {
    
     var interactor : MainModuleInteractorInput!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        interactor = MainModuleInteractor()
        let dataSource = PhoneNumbersDataSource()
        interactor.setDataSource(dataSource: dataSource)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        interactor = nil
        super.tearDown()
    }
    
    func testLoadingAndCreateData() {
        
        interactor.requestData { (result) in
            switch result {
                case .success(let data) :
                    XCTAssertNotNil(data)
                    XCTAssert(data.count == 12)
                case .failure(let error):
                    print("error = \(error.description)")
                    XCTFail()
            }
        }
        
    }
    
    func testSwitchTheme() {
        
        Theme.current.setCurrentTheme(theme: .Dark);
        XCTAssert(Theme.current.currentTheme == .Dark)
        
        Theme.current.setCurrentTheme(theme: .Light);
        XCTAssert(Theme.current.currentTheme == .Light)
    }
}
