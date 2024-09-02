//
//  Color+Extras.swift
//  DejaHue
//
//  Created by Ярослав Седышев on 02.09.2024.
//

import SwiftUI

extension Color {
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        guard UIColor(self).getRed(&r, green: &g, blue: &b, alpha: &a) else {
            return (0, 0, 0, 0)
        }
        return (r, g, b, a)
    }
    
    static func random(in range: ClosedRange<Double>) -> Color {
        return Color(
            red: .random(in: range),
            green: .random(in: range),
            blue: .random(in: range)
        )
    }
}
