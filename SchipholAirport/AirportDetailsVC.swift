//
//  AirportDetailsVC.swift
//  SchipholAirport
//
//  Created by Roland Lariotte on 05/11/2020.
//

import UIKit

//  MARK: AirportDetailsVC
/// Show airport details for airports on map view
/// fetched from api.
///
class AirportDetailsVC: UIViewController {

  // UI
  var idLabel = UILabel()
  var idResultLabel = UILabel()
  var latLabel = UILabel()
  var latResultLabel = UILabel()
  var longLabel = UILabel()
  var longLabelResult = UILabel()
  var nameLabel = UILabel()
  var nameResultLabel = UILabel()
  var cityLabel = UILabel()
  var cityResultLabel = UILabel()
  var countryIdLabel = UILabel()
  var countryIdResultLabel = UILabel()
  var nearestAirportLabel = UILabel()
  var nearestAirportResultLabel = UILabel()
  var distanceAirportsLabel = UILabel()
  var distanceAirportsResultLabel = UILabel()

  // Stack views
  var mainVStack = UIStackView()
  var firstVStack = UIStackView()
  var secondVStack = UIStackView()
  var thirdVStack = UIStackView()
  var fourthVStack = UIStackView()
  var fifthVStack = UIStackView()
  var sixthVStack = UIStackView()
  var seventhVStack = UIStackView()
  var eigthVStack = UIStackView()

  // Constants
  static let detailsNotification = "AirportDetailsVC"

  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainView()
  }
}

// MARK: - AirportDetailsVC Setup
extension AirportDetailsVC {
  /// Main setup.
  ///
  /// - Warning: Order of func is important.
  ///
  func setupMainView() {
    setupDesign()
    addSubviews()
    activateLayoutConstraints()
  }

  /// Setup view design on all elements.
  ///
  func setupDesign() {
    setupViewTitle()
    setupStaticLabels()
    setupMainStack()
    setupSecondaryStackViews()
  }

  /// Adding all subviews into AirportDetailsVC.
  ///
  func addSubviews() {
    view.addSubview(mainVStack)
    addMainStackSubviews()
    addSecondaryStacksSubviews()
  }

  /// Setup and activate all layouts of the SettingsVC.
  ///
  func activateLayoutConstraints() {
    activateMainStackViewLayout()
    activateSecondaryStackViewsLayout()
  }
}

// MARK: - Design
extension AirportDetailsVC {
  /// Setup view title.
  ///
  func setupViewTitle() {
    title = Localized.details

    navigationController?
      .navigationBar
      .prefersLargeTitles = true
    view.backgroundColor = .background$
  }

  /// Setup static label title to populate info to user.
  ///
  func setupStaticLabels() {
    idLabel.secondaryLabelStyle(text: Localized.idLabel)
    latLabel.secondaryLabelStyle(text: Localized.latLabel)
    longLabel.secondaryLabelStyle(text: Localized.longLabel)
    nameLabel.secondaryLabelStyle(text: Localized.nameLabel)
    cityLabel.secondaryLabelStyle(text: Localized.cityLabel)
    countryIdLabel.secondaryLabelStyle(text: Localized.countryIdLabel)
    nearestAirportLabel.secondaryLabelStyle(text: Localized.nearestAirportLabel)
    distanceAirportsLabel.secondaryLabelStyle(text: Localized.distanceAirportsLabel)
  }

  /// Setup main stack view holding secondary stack
  /// views with labels info.
  ///
  func setupMainStack() {
    mainVStack.axis = .vertical
    mainVStack.distribution = .equalSpacing
    mainVStack.alignment = .center
    mainVStack.spacing = 8
  }

  /// Setup secondary stack views holding info labels.
  ///
  func setupSecondaryStackViews() {
    firstVStack.setSecondaryStackStyle()
    secondVStack.setSecondaryStackStyle()
    thirdVStack.setSecondaryStackStyle()
    fourthVStack.setSecondaryStackStyle()
    fifthVStack.setSecondaryStackStyle()
    sixthVStack.setSecondaryStackStyle()
    seventhVStack.setSecondaryStackStyle()
    eigthVStack.setSecondaryStackStyle()
  }
}

// MARK: - Layouts
extension AirportDetailsVC {
  /// Main stack view layout holding all secondary
  /// stack views.
  ///
  /// Main stack view is set to be in the middle of the view.
  ///
  func activateMainStackViewLayout() {
    mainVStack.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      mainVStack
        .centerXAnchor
        .constraint(equalTo: view.centerXAnchor),

      mainVStack
        .centerYAnchor
        .constraint(equalTo: view.centerYAnchor)
    ])
  }

  /// Setup secondary stack views autolayout constraints to false.
  ///
  func activateSecondaryStackViewsLayout() {
    firstVStack.translatesAutoresizingMaskIntoConstraints = false
    secondVStack.translatesAutoresizingMaskIntoConstraints = false
    thirdVStack.translatesAutoresizingMaskIntoConstraints = false
    fourthVStack.translatesAutoresizingMaskIntoConstraints = false
    fifthVStack.translatesAutoresizingMaskIntoConstraints = false
    sixthVStack.translatesAutoresizingMaskIntoConstraints = false
    seventhVStack.translatesAutoresizingMaskIntoConstraints = false
    eigthVStack.translatesAutoresizingMaskIntoConstraints = false
  }

  /// Main statck subviews as secondary stack views
  /// arranged inside it.
  ///
  func addMainStackSubviews() {
    mainVStack.addArrangedSubview(firstVStack)
    mainVStack.addArrangedSubview(secondVStack)
    mainVStack.addArrangedSubview(thirdVStack)
    mainVStack.addArrangedSubview(fourthVStack)
    mainVStack.addArrangedSubview(fifthVStack)
    mainVStack.addArrangedSubview(sixthVStack)
    mainVStack.addArrangedSubview(seventhVStack)
    mainVStack.addArrangedSubview(eigthVStack)
  }

  /// Secondary stack views UILabel subviews added to them.
  ///
  func addSecondaryStacksSubviews() {
    firstVStack.addArrangedSubview(idLabel)
    firstVStack.addArrangedSubview(idResultLabel)

    secondVStack.addArrangedSubview(latLabel)
    secondVStack.addArrangedSubview(latResultLabel)

    thirdVStack.addArrangedSubview(longLabel)
    thirdVStack.addArrangedSubview(longLabelResult)

    fourthVStack.addArrangedSubview(nameLabel)
    fourthVStack.addArrangedSubview(nameResultLabel)

    fifthVStack.addArrangedSubview(cityLabel)
    fifthVStack.addArrangedSubview(cityResultLabel)

    sixthVStack.addArrangedSubview(countryIdLabel)
    sixthVStack.addArrangedSubview(countryIdResultLabel)

    seventhVStack.addArrangedSubview(nearestAirportLabel)
    seventhVStack.addArrangedSubview(nearestAirportResultLabel)

    eigthVStack.addArrangedSubview(distanceAirportsLabel)
    eigthVStack.addArrangedSubview(distanceAirportsResultLabel)
  }
}
