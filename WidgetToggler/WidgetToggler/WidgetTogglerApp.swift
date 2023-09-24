//  Copyright (c) 2023 Matthias Frick. All rights reserved.

import SwiftUI

import HotKey
import LaunchAtLogin

@main
struct WidgetTogglerApp: App {
  @State var widgetsPrefs: WidgetPreferences
  private let hotKey: HotKey

  public init() {
    widgetsPrefs = WidgetPreferences.shared
    hotKey = HotKey(keyCombo: KeyCombo(key: .w, modifiers: [.command, .control]))
    hotKey.keyDownHandler = { [self] in
      widgetsPrefs.toggleWidgets()
    }
  }

  var body: some Scene {
    MenuBarExtra(
      "WidgetToggler",
      systemImage: widgetsPrefs.hideWidgets ? "rectangle.on.rectangle.slash" : "rectangle.inset.filled.on.rectangle"
    ) {
      Button(
        action: {
          widgetsPrefs.toggleWidgets()
        },
        label: {
          Text(widgetsPrefs.hideWidgets ? "Show Widgets" : "Hide Widgets")
        }
      ).keyboardShortcut(KeyEquivalent("w"), modifiers: [.control, .command])
      Divider()
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
