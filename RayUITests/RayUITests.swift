//
//  RayUITests.swift
//  RayUITests
//
//  Created by mac on 11.05.2023.
//

import XCTest

final class RayUITests: XCTestCase {
  var app: XCUIApplication!
  
  func testButtonsVisability() throws {
      let app = XCUIApplication()
      app.launch()
      XCTAssert(!app.buttons["addToFavouriteButton"].isHittable)
  }
}
