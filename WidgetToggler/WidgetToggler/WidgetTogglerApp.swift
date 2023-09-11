//  Copyright (c) 2023 Matthias Frick. All rights reserved.

import SwiftUI

@main
struct WidgetTogglerApp: App {
  @State var widgetsPrefs = WidgetPreferences()

  var body: some Scene {
    MenuBarExtra(
      "WidgetToggler",
      systemImage: widgetsPrefs.hideWidgets ? "clipboard" : "clipboard.fill"
    ) {
      Button(
        action: {
          widgetsPrefs.toggleWidgets()
        },
        label: {
          Text(widgetsPrefs.hideWidgets ? "Show Widgets" : "Hide Widgets")
        }
      )
      Divider()
      Button(
        action: {
          NSApplication.shared.terminate(nil)
        },
        label: {
          Text("Quit")
        }
      )
    }
  }

}
