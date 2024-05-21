//
//  Bundle+Extensions.swift
//  BaseProject
//
//  Created by Ritesh Sinha on 19/05/24.
//

import Foundation
import UIKit

extension Bundle {
    // MARK: - Properties

    var appName: String? {
        return infoDictionary?["CFBundleName"] as? String
    }

    var appVersion: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }

    var appBuild: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }

    // MARK: - Methods

    func url(forResource name: String?, withExtension ext: String?) -> URL? {
        return self.url(forResource: name, withExtension: ext)
    }

    func path(forResource name: String?, ofType ext: String?) -> String? {
        return self.path(forResource: name, ofType: ext)
    }

    func object(forInfoDictionaryKey key: String) -> Any? {
        return infoDictionary?[key]
    }

    func appIcon() -> UIImage? {
        guard let iconsDictionary = infoDictionary?["CFBundleIcons"] as? [String: Any],
              let primaryIconsDictionary = iconsDictionary["CFBundlePrimaryIcon"] as? [String: Any],
              let iconFiles = primaryIconsDictionary["CFBundleIconFiles"] as? [String],
              let lastIcon = iconFiles.last else {
            return nil
        }

        return UIImage(named: lastIcon)
    }
}

