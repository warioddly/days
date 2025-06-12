//
//  DaysWidgetLiveActivity.swift
//  DaysWidget
//
//  Created by GØDØFIMØ on 12/6/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct DaysWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct DaysWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: DaysWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension DaysWidgetAttributes {
    fileprivate static var preview: DaysWidgetAttributes {
        DaysWidgetAttributes(name: "World")
    }
}

extension DaysWidgetAttributes.ContentState {
    fileprivate static var smiley: DaysWidgetAttributes.ContentState {
        DaysWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: DaysWidgetAttributes.ContentState {
         DaysWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: DaysWidgetAttributes.preview) {
   DaysWidgetLiveActivity()
} contentStates: {
    DaysWidgetAttributes.ContentState.smiley
    DaysWidgetAttributes.ContentState.starEyes
}
