//  Copyright (c) 2023 Matthias Frick. All rights reserved.

import Combine
import Foundation
import Observation
import SwiftUI

@Observable
public final class WidgetPreferences : Sendable {
  public var hideWidgets: Bool = false

  @ObservationIgnored private var smActive: Bool = false
  @ObservationIgnored private var defaults: UserDefaults?
  var subscriptions = Set<AnyCancellable>()
  var smObserverTimer: Timer?

  static let shared = WidgetPreferences()

  public init() {
    defaults = UserDefaults.init(suiteName: UserDefaults.kWindowManagerPlistKey)
    let defaultsWg = UserDefaults.standard
    defaultsWg.addSuite(named: UserDefaults.kWindowManagerPlistKey)
    defaults?
      .publisher(for: \.hideStageManagerWidgets)
      .handleEvents(receiveOutput: { hideStageManagerWidgets in
        guard let defaults = self.defaults else { return }
        self.hideWidgets = defaults.stageManagerEnabled ? hideStageManagerWidgets : defaults.hideDesktopWidgets
      })
      .sink { _ in }
      .store(in: &subscriptions)
    defaults?
      .publisher(for: \.hideDesktopWidgets)
      .handleEvents(receiveOutput: { hideDesktopWidgets in
        guard let defaults = self.defaults else { return }
        self.hideWidgets = defaults.stageManagerEnabled ? defaults.hideStageManagerWidgets : hideDesktopWidgets
      })
      .sink { _ in }
      .store(in: &subscriptions)
    smObserverTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
      self.checkIfSMActive()
    })
  }

  // Workaround for now since KVO on SM doesn't fire
  func checkIfSMActive() {
    if smActive != defaults?.stageManagerEnabled {
      guard let defaults = defaults else { return }
      self.hideWidgets = defaults.stageManagerEnabled ? defaults.hideStageManagerWidgets : defaults.hideDesktopWidgets
      smActive = defaults.stageManagerEnabled
    }
  }

  func toggleWidgets() {
    guard let defaults = defaults else { return }
    if defaults.stageManagerEnabled {
      defaults.hideStageManagerWidgets = !defaults.hideStageManagerWidgets
    } else {
      defaults.hideDesktopWidgets = !defaults.hideDesktopWidgets
    }
  }

  func showHideWidgets(hide: Bool) {
    guard let defaults = defaults else { exit(0) }
    defaults.hideStageManagerWidgets = hide
    defaults.hideDesktopWidgets = hide
  }
}
