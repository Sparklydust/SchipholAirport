//
//  SettingsVC.swift
//  SchipholAirport
//
//  Created by Roland Lariotte on 01/11/2020.
//

import UIKit

//  MARK: SettingsVC
/// View controller reponsable for the user settings.
///
class SettingsVC: UIViewController {

  // UI
  var sectionOneLabel = UILabel()
  var unitSegmentedControl = UISegmentedControl()

  // Constants
  let segContItems = [
    Localized.kilometers,
    Localized.miles
  ]

  // Variables
  var isInKm = true

  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainView()
  }
}

// MARK: - SettingsVC Setup
extension SettingsVC {
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
    setupSectionOneLabel()
    setupUnitSegementedControl()

  }

  /// Adding all subviews into SettingsVC.
  ///
  func addSubviews() {
    view.addSubview(sectionOneLabel)
    view.addSubview(unitSegmentedControl)
  }

  /// Setup and activate all layouts of the SettingsVC.
  ///
  func activateLayoutConstraints() {
    activateSectionOneLabelLayout()
    activateUnitSegmentedControlLayout()
  }
}

// MARK: - Design
extension SettingsVC {
  /// Setup view title.
  ///
  func setupViewTitle() {
    title = Localized.settings

    navigationController?
      .navigationBar
      .prefersLargeTitles = true
  }

  /// Setup sectionOneLabel design.
  ///
  func setupSectionOneLabel() {
    sectionOneLabel.font = .systemFont(ofSize: 20, weight: .medium)
    sectionOneLabel.text = Localized.unit
    sectionOneLabel.textAlignment = .left
  }

  func setupUnitSegementedControl() {
    unitSegmentedControl = UISegmentedControl(items: segContItems)
    unitSegmentedControl.selectedSegmentIndex = isInKm ? 0 : 1
    unitSegmentedControl.layer.cornerRadius = 8
    unitSegmentedControl.addTarget(self,
                                   action: #selector(changeUnit),
                                   for: .valueChanged)
  }

  @objc func changeUnit() {
  }
}

// MARK: - Layouts
extension SettingsVC {
  /// Layout SectionOneLabel.
  ///
  /// First item in view anchored at the top of it.
  ///
  func activateSectionOneLabelLayout() {
    sectionOneLabel.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      sectionOneLabel
        .topAnchor
        .constraint(equalTo: view.layoutMarginsGuide.topAnchor,
                    constant: 32),

      sectionOneLabel
        .leadingAnchor
        .constraint(equalTo: view.leadingAnchor,
                    constant: 16),


      sectionOneLabel
        .trailingAnchor
        .constraint(equalTo: view.trailingAnchor, constant: -16)
    ])
  }

  /// Layout unitSegmentedControl.
  ///
  /// Top anchored to sectionOneLabel bottom.
  ///
  func activateUnitSegmentedControlLayout() {
    unitSegmentedControl.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      unitSegmentedControl
        .topAnchor
        .constraint(equalTo: sectionOneLabel.bottomAnchor,
                    constant: 16),

      unitSegmentedControl
        .leadingAnchor
        .constraint(equalTo: view.leadingAnchor,
                    constant: 16),

      unitSegmentedControl
        .trailingAnchor
        .constraint(equalTo: view.trailingAnchor, constant: -16)
    ])
  }
}
