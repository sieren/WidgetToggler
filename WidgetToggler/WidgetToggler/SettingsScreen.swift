//  Copyright (c) 2023 Matthias Frick. All rights reserved.

import Foundation
import SwiftUI

import KeyboardShortcuts

struct SettingsScreen: View {
  @Environment(\.dismiss) var dismiss

  var body: some View {
    VStack(alignment: .leading) {
      Spacer()
      Text("Set a global HotKey to toggle Widgets.")
      Form {
        KeyboardShortcuts.Recorder("HotKey:", name: .toggleWidgetMode)
      }
      Text("Requires restarting WidgetToggler to show in the UI.")
      Spacer()
    }
    .frame(minWidth: 200)
    .padding(50)
  }
}
