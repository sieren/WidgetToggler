//  Copyright (c) 2023 Matthias Frick. All rights reserved.

import SwiftUI

import KeyboardShortcuts
import LaunchAtLogin

@main
struct WidgetTogglerApp: App {
  @State var widgetsPrefs: WidgetPreferences

  public init() {
    widgetsPrefs = WidgetPreferences.shared
    KeyboardShortcuts.onKeyUp(for: .toggleWidgetMode) { [self] in
      widgetsPrefs.toggleWidgets()
    }
  }

  var body: some Scene {
    Settings {
      SettingsScreen()
    }
    MenuBarExtra(
      "WidgetToggler",
      systemImage: widgetsPrefs.hideWidgets ? "rectangle.on.rectangle.slash" : "rectangle.inset.filled.on.rectangle"
    ) {
      Button(
        action: {
          widgetsPrefs.toggleWidgets()
        },
        label: {
          HStack {
            Text(widgetsPrefs.hideWidgets ? "Show Widgets" : "Hide Widgets")
          }
        }
      ).keyboardShortcut(.toggleWidgetMode)
      Divider()
      SettingsLink(label: {
        Text("Settings")
      })
      LaunchAtLogin.Toggle()
      Divider()
      Button(
        action: {
          if let url = URL(string: "https://github.com/sieren/WidgetToggler") {
            NSWorkspace.shared.open(url)
          }
        },
        label: {
          Text("WidgetToggler " + (Bundle.main.releaseVersionNumber ?? ""))
        }
      )
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
