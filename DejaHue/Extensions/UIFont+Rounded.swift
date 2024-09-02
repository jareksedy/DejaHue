//
//  UIFont+Rounded.swift
//  DejaHue
//
//  Created by Ярослав Седышев on 02.09.2024.
//

import SwiftUI

extension UIFont {
    func rounded() -> UIFont {
        guard let descriptor = fontDescriptor.withDesign(.rounded) else {
            return self
        }

        return UIFont(descriptor: descriptor, size: pointSize)
    }
}
