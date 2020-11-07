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
  var idDataLabel = UILabel()
  var latLabel = UILabel()
  var latDataLabel = UILabel()
  var longLabel = UILabel()
  var longDataLabel = UILabel()
  var nameLabel = UILabel()
  var nameDataLabel = UILabel()
  var cityLabel = UILabel()
  var cityDataLabel = UILabel()
  var countryIdLabel = UILabel()
  var countryIdDataLabel = UILabel()
  var nearestAirportLabel = UILabel()
  var nearestAirportDataLabel = UILabel()
  var distanceAirportsLabel = UILabel()
  var distanceAirportsDataLabel = UILabel()

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

  // Variables
  var id = String()
  var latitude = Double()
  var longitude = Double()
  var name = String()
  var city = String()
  var countryId = String()
  var nearestAirport = String()
  var distanceAirports = Double()

  // Constant
  let distanceFormat = "%.2f %@"
  var isInKm = UserDefaultsService.shared.isInKm

  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainView()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    isInKm = UserDefaultsService.shared.isInKm
    setupDataInLabels()
  }
}

// MARK: - Setup Labels Data
extension AirportDetailsVC {
  /// User distance unit set in settings.
  ///
  /// Value are being saved and retrieve in
  /// UserDefaults.
  ///
  func setupDataInLabels() {
    let unit = isInKm ? Localized.km : Localized.mi
    let airportDistance = String(format: distanceFormat, distanceAirports, unit)

    idDataLabel.text = id
    latDataLabel.text = String(latitude)
    longDataLabel.text = String(longitude)
    nameDataLabel.text = name
    cityDataLabel.text = city
    countryIdDataLabel.text = countryId
    nearestAirportDataLabel.text = nearestAirport
    distanceAirportsDataLabel.text = airportDistance
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
    setupDataLabel()
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

  /// Setup data label that are populate to user when view
  /// is shown from an annotation tapped on map.
  ///
  func setupDataLabel() {
    idDataLabel.dataLabelStyle()
    latDataLabel.dataLabelStyle()
    longDataLabel.dataLabelStyle()
    nameDataLabel.dataLabelStyle()
    cityDataLabel.dataLabelStyle()
    countryIdDataLabel.dataLabelStyle()
    nearestAirportDataLabel.dataLabelStyle()
    distanceAirportsDataLabel.dataLabelStyle()
  }

  /// Setup main stack view holding secondary stack
  /// views with labels info.
  ///
  func setupMainStack() {
    mainVStack.axis = .vertical
    mainVStack.distribution = .equalSpacing
    mainVStack.alignment = .center
    mainVStack.spacing = 16
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

  /// Secondary stack views UILabel as subviews added to them.
  ///
  func addSecondaryStacksSubviews() {
    firstVStack.addArrangedSubview(idLabel)
    firstVStack.addArrangedSubview(idDataLabel)

    secondVStack.addArrangedSubview(latLabel)
    secondVStack.addArrangedSubview(latDataLabel)

    thirdVStack.addArrangedSubview(longLabel)
    thirdVStack.addArrangedSubview(longDataLabel)

    fourthVStack.addArrangedSubview(nameLabel)
    fourthVStack.addArrangedSubview(nameDataLabel)

    fifthVStack.addArrangedSubview(cityLabel)
    fifthVStack.addArrangedSubview(cityDataLabel)

    sixthVStack.addArrangedSubview(countryIdLabel)
    sixthVStack.addArrangedSubview(countryIdDataLabel)

    seventhVStack.addArrangedSubview(nearestAirportLabel)
    seventhVStack.addArrangedSubview(nearestAirportDataLabel)

    eigthVStack.addArrangedSubview(distanceAirportsLabel)
    eigthVStack.addArrangedSubview(distanceAirportsDataLabel)
  }
}
