//
//  ViewExtensions.swift
//  Runner
//
//  Created by GØDØFIMØ on 27/6/25.
//

import SwiftUI

extension View {
    @ViewBuilder
    func applyForegroundColor(if condition: Bool, color: Color) -> some View {
        if condition {
            self.foregroundColor(color)
        } else {
            self
        }
    }
}
