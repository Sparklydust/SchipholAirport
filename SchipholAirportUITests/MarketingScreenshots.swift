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
      name: "screenshot-\(name).png",
      payload: screenshot.pngRepresentation,
      userInfo: nil)

    attachment.lifetime = .keepAlways

    add(attachment)
  }
}

// MARK: - UITest Screenshots
extension MarketingScreenshots {
  /// Testing the UI to take screenshots.
  ///
  /// - Warning: Order of the method called is very
  /// important.
  ///
  func testMaketingScreenshots_start() throws {
    sleep(4)
    screenshotAirportTabViewWithMap()
    screenshotFlightsTabView()
    screenshotAirlinesTabViewInKm()
    screenshotSettingsTabView()
    screenshotAirlinesTabViewInMiles()
    resetTest()
  }
}

// MARK: - Screenshots setup.
extension MarketingScreenshots {
  /// First tab view.
  ///
  func screenshotAirportTabViewWithMap() {
      takeSaveScreenshot(name: "1.AirportsTab")
  }

  /// Second tab view.
  ///
  func screenshotFlightsTabView() {
    app.tabBars
      .buttons
      .element(boundBy: 1)
      .tap()

    sleep(2)
    takeSaveScreenshot(name: "2.FlightsTab")
  }

  /// Third tab view with distance in Km.
  ///
  func screenshotAirlinesTabViewInKm() {
    app.tabBars
      .buttons
      .element(boundBy: 2)
      .tap()

    sleep(2)
    takeSaveScreenshot(name: "3.AirlinesTabKm")
  }

  /// Fourth tab view.
  ///
  func screenshotSettingsTabView() {
    app.tabBars
      .buttons
      .element(boundBy: 3)
      .tap()

    sleep(1)
    takeSaveScreenshot(name: "4.SettingsTab")
  }

  /// Third tab view with distance in Miles.
  ///
  func screenshotAirlinesTabViewInMiles() {
    app.segmentedControls
      .matching(identifier: "segContIdentifier")
      .buttons
      .element(boundBy: 1)
      .tap()

    app.tabBars
      .buttons
      .element(boundBy: 2)
      .tap()

    sleep(2)
    takeSaveScreenshot(name: "5.AirlinesTabMi")
  }

  /// Reset test to have distance in km and map view showing.
  ///
  func resetTest() {
    app.tabBars
      .buttons
      .element(boundBy: 3)
      .tap()

    sleep(1)

    app.segmentedControls
      .matching(identifier: "segContIdentifier")
      .buttons
      .element(boundBy: 0)
      .tap()

    app.tabBars
      .buttons
      .element(boundBy: 0)
      .tap()
  }
}
