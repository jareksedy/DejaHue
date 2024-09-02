//
//  GridSize.swift
//  DejaHue
//
//  Created by Ярослав Седышев on 02.09.2024.
//

import Foundation

enum GridSize: Int {
    case grid3x3 = 3
    case grid4x4 = 4
    case grid5x5 = 5
}

extension GridSize {
    var gridSizeString: String {
        switch self {
        case .grid3x3: return "3×3"
        case .grid4x4: return "4×4"
        case .grid5x5: return "5×5"
        }
    }
}
