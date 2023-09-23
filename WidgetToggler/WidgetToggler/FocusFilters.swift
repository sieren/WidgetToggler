//  Copyright (c) 2023 Matthias Frick. All rights reserved.

import OSLog
import Foundation
import AppIntents

struct HideWidgetsFocusFilter: SetFocusFilterIntent, Sendable {

  static public var title: LocalizedStringResource = "Set to automatically hide all widgets."
  
  static public var description: IntentDescription? = """
  Set to hide all widgets when focus mode changes.
  """

  public var displayRepresentation: DisplayRepresentation
  {
    DisplayRepresentation(
      title: "\(primaryText)"
    )
  }

  private var primaryText: LocalizedStringResource {
    return hideWidgets ? "Hide Widgets" : "Show Widgets"
  }

  private var secondaryText: LocalizedStringResource {
    let status = hideWidgets ? "Enabled" : "Disabled"
    return "Status: \(status)"
  }

  /// Providing a default value ensures setting this required Boolean value.
  @Parameter(title: "Hide Widgets", default: false)
  var hideWidgets: Bool

  static func suggestedFocusFilters(for context: FocusFilterSuggestionContext) async -> [HideWidgetsFocusFilter] {
    let defaultFilter = HideWidgetsFocusFilter()
    defaultFilter.hideWidgets = true

    return [defaultFilter]
  }

  func perform() async throws -> some IntentResult {
    WidgetPreferences.shared.showHideWidgets(hide: self.hideWidgets)
    return .result()
  }
}

extension HideWidgetsFocusFilter {
  var logger: Logger {
    let subsystem = Bundle.main.bundleIdentifier!
    return Logger(subsystem: subsystem, category: "WidgetTogglerFocus")
  }
}

