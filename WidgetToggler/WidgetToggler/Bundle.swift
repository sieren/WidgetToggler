//  Copyright (c) 2023 Matthias Frick. All rights reserved.

import Foundation

extension Bundle {
  var releaseVersionNumber: String? {
    return infoDictionary?["CFBundleShortVersionString"] as? String
  }
  var buildVersionNumber: String? {
    return infoDictionary?["CFBundleVersion"] as? String
  }
}
