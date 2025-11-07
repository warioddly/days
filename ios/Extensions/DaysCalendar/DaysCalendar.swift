//
//  DaysCalendar.swift
//  DaysCalendar
//
//  Created by GØDØFIMØ on 27/6/25.
//

import SwiftUI
import WidgetKit

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> DaysWidgetEntry {
        DaysWidgetEntry(date: Date(), flowerName: "Flower-0")
    }

    func getSnapshot(
        in context: Context,
        completion: @escaping (DaysWidgetEntry) -> Void
    ) {
        completion(DaysWidgetEntry(date: Date(), flowerName: "Flower-0"))
    }

    func getTimeline(
        in context: Context,
        completion: @escaping (Timeline<DaysWidgetEntry>) -> Void
    ) {
        let flowerNames = generateFlowerNames()
        let entries = createHourlyTimelineEntries(from: Date(), flowerNames: flowerNames)
        completion(Timeline(entries: entries, policy: .atEnd))
    }
}

struct DaysCalendarEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        let lightColor = Color(hex: 0xFF00_47AB)
        VStack {

            Text(formatDate(entry))
                .foregroundColor(lightColor)
                .fontWeight(.semibold)
                .font(.headline)

            Image(entry.flowerName)
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 62)
                .foregroundColor(lightColor)

            Text(formatter.string(from: entry.date).lowercased())
                .foregroundColor(lightColor)
                .fontWeight(.semibold)
                .font(.headline)
        }
    }
}

struct DaysCalendar: Widget {
    let kind: String = "DaysCalendar"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                DaysCalendarEntryView(entry: entry)
                    .containerBackground(.white, for: .widget)
            } else {
                DaysCalendarEntryView(entry: entry)
                    .background(.white)
            }
        }
        .configurationDisplayName("Today’s Date & Flower")
        .description(
            "Every day blooms with a new flower and a reminder of time."
        )
        .supportedFamilies([
            .systemSmall, .systemMedium,
        ])
    }
}

@available(iOS 17.0, *)
#Preview(as: .systemSmall) {
    DaysCalendar()
} timeline: {
    let flowerNames = generateFlowerNames()
    return createHourlyTimelineEntries(from: Date(), flowerNames: flowerNames)
}
