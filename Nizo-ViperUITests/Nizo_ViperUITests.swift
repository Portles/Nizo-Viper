//
//  Nizo_ViperUITests.swift
//  Nizo-ViperUITests
//
//  Created by Nizamet Özkan on 3.03.2024.
//

import XCTest

final class Nizo_ViperUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
