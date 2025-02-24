//
//  DaysHomeWidgetLiveActivity.swift
//  DaysHomeWidget

import ActivityKit
import WidgetKit
import SwiftUI

struct DaysHomeWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct DaysHomeWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: DaysHomeWidgetAttributes.self) { context in
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

extension DaysHomeWidgetAttributes {
    fileprivate static var preview: DaysHomeWidgetAttributes {
        DaysHomeWidgetAttributes(name: "World")
    }
}

extension DaysHomeWidgetAttributes.ContentState {
    fileprivate static var smiley: DaysHomeWidgetAttributes.ContentState {
        DaysHomeWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: DaysHomeWidgetAttributes.ContentState {
         DaysHomeWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: DaysHomeWidgetAttributes.preview) {
   DaysHomeWidgetLiveActivity()
} contentStates: {
    DaysHomeWidgetAttributes.ContentState.smiley
    DaysHomeWidgetAttributes.ContentState.starEyes
}
