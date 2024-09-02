//
//  Haptics.swift
//  DejaHue
//
//  Created by Ярослав Седышев on 02.09.2024.
//

import SwiftUI

class Haptics {
    static let shared = Haptics()
    
    private init() {}

    func play(_ feedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle) {
        UIImpactFeedbackGenerator(style: feedbackStyle).impactOccurred()
    }
    
    func notify(_ feedbackType: UINotificationFeedbackGenerator.FeedbackType) {
        UINotificationFeedbackGenerator().notificationOccurred(feedbackType)
    }
}
