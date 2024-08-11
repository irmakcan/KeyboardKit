//
//  Bundle+Resources.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-12-16.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Bundle {

    /// Get whether or not the bundle is an extension.
    @_disfavoredOverload
    var isExtension: Bool {
        bundlePath.hasSuffix(".appex")
    }
}
