//
//  ThemesDataSourceTests.swift
//  Dialer
//
//  Created by Женя Михайлова on 24.11.16.
//  Copyright © 2016 Evgeniya Mikhailova. All rights reserved.
//

import XCTest
@testable import Dialer

class ThemesDataSourceTests: XCTestCase {

    var dataSource : ThemesDataSourceInterface?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.dataSource = ThemesDataSource()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.dataSource = nil;
        super.tearDown()
    }
    
    func testSaveAndLoadTheme() {
        
        dataSource?.setCurrentThemeBy(identifier: .light)
        let theme = dataSource?.currentTheme()
        
        XCTAssert(theme?.identifier() == .light)
    }
}
