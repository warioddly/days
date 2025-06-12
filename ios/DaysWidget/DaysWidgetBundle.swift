//
//  DaysWidgetBundle.swift
//  DaysWidget
//
//  Created by GØDØFIMØ on 12/6/25.
//

import WidgetKit
import SwiftUI

@main
struct DaysWidgetBundle: WidgetBundle {
    var body: some Widget {
        DaysWidget()
        DaysWidgetControl()
        DaysWidgetLiveActivity()
    }
}
