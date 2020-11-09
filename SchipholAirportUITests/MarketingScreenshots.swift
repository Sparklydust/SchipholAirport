//
//  MarketingScreenshots.swift
//  SchipholAirportUITests
//
//  Created by Roland Lariotte on 09/11/2020.
//

import XCTest

//  MARK: MarketingScreenshots
/// UITests for taking marketing screenshots to populate
/// on the AppStore.
///
/// Edit the scheme test to use Marketing.xctestplan.
///
class MarketingScreenshots: XCTestCase {

  var app: XCUIApplication!

  override func setUpWithError() throws {
    try super.setUpWithError()
    continueAfterFailure = true
    app = XCUIApplication()
    app.launch()
  }

  override func tearDownWithError() throws {
    app.terminate()
    try super.tearDownWithError()
  }
}

// MARK: - Screenshots helper
extension MarketingScreenshots {
  /// Take a screenshot and save it as attachment.
  ///
  /// Can be retrieve in the navigation panel.
  /// Command+9 and find the file by clicking on
  /// Test and expand the arrow.
  ///
  /// - Parameters:
  ///     - name: name of the screenshot file.
  ///
  private func takeSaveScreenshot(name: String) {
    let screenshot = XCUIScreen.main.screenshot()

    let attachment = XCTAttachment(
      uniformTypeIdentifier: "public.png",
      name: "screenshot-\(name)-\(UIDevice.current.name).png",
      payload: screenshot.pngRepresentation,
      userInfo: nil)

    attachment.lifetime = .keepAlways

    add(attachment)
  }
}

// MARK: - UITest Screenshots
extension MarketingScreenshots {
  func test() throws {
    
  }
}
