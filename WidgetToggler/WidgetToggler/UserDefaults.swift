//  Copyright (c) 2023 Matthias Frick. All rights reserved.

import Foundation

extension UserDefaults {

  public static let kWindowManagerPlistKey = "com.apple.WindowManager.plist"
  public static let kStageManagerEnabledKey = "GloballyEnabled"
  public static let kStageManageHideWidgets = "StageManagerHideWidgets"
  public static let kStandardHideWidgets = "StandardHideWidgets"

  @objc var stageManagerEnabled: Bool {
    get {
      return integer(forKey: UserDefaults.kStageManagerEnabledKey) == 1
    }
    set {
      set(newValue ? 1 : 0, forKey: UserDefaults.kStageManagerEnabledKey)
    }
  }

  @objc var hideStageManagerWidgets: Bool {
    get {
      return integer(forKey: UserDefaults.kStageManageHideWidgets) == 1
    }
    set {
      set(newValue ? 1 : 0, forKey: UserDefaults.kStageManageHideWidgets)
    }
  }

  @objc var hideDesktopWidgets: Bool {
    get {
      return integer(forKey: UserDefaults.kStandardHideWidgets) == 1
    }
    set {
      set(newValue ? 1 : 0, forKey: UserDefaults.kStandardHideWidgets)
    }
  }
}
