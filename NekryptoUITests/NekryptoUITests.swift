//
//  NekryptoUITests.swift
//  NekryptoUITests
//
//  Created by Alan Milke on 20/05/25.
//

import XCTest

final class NekryptoUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testExampdvle() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        app.activate()
        
        let refreshButton = app.buttons["Refresh List"]
        //The app main screen should have a way to refresh the information
        XCTAssertTrue(refreshButton.exists)
        
        //refreshButton.tap() // Tap stopped, trying to use local data to test.
        let searchField = app.searchFields["Search Crypto"]
        XCTAssertTrue(searchField.exists)
        let list = app.collectionViews["CryptoListView-List"]
        XCTAssertTrue(list.exists)
    
        print(list.cells.count) //8 visible at the phone testing...
        
        searchField.tap()
        searchField.typeText("Monero")
 
        XCTAssertTrue(list.cells.count == 1) //1 visible since the search worked perfectly.
        
        searchField.tap()
        searchField.typeText("Moneros")
        
        let monerosRow = app.buttons["Moneros"].firstMatch
        
        XCTAssertFalse(monerosRow.exists)
        
    }

    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
