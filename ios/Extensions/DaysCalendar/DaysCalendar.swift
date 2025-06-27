//
//  DaysCalendar.swift
//  DaysCalendar
//
//  Created by GØDØFIMØ on 27/6/25.
//

import SwiftUI
import WidgetKit

struct SimpleEntry: TimelineEntry {
    let date: Date
    let flowerName: String
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), flowerName: "Flower-0")
    }

    func getSnapshot(
        in context: Context,
        completion: @escaping (SimpleEntry) -> Void
    ) {
        completion(SimpleEntry(date: Date(), flowerName: "Flower-0"))
    }

    func getTimeline(
        in context: Context,
        completion: @escaping (Timeline<SimpleEntry>) -> Void
    ) {
        var entries: [SimpleEntry] = []
        let flowerNames = (0...10).map { "Flower-\($0)" }
        let currentDate = Date()

        for hourOffset in 0..<flowerNames.count {
            let entryDate = Calendar.current.date(
                byAdding: .hour,
                value: hourOffset,
                to: currentDate
            )!
            let flowerName = flowerNames[hourOffset]
            entries.append(SimpleEntry(date: entryDate, flowerName: flowerName))
        }

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
            DaysCalendarEntryView(entry: entry).containerBackground(
                .white,
                for: .widget
            )
        }
        .configurationDisplayName("Today’s Date & Flower")
        .description("Every day blooms with a new flower and a reminder of time.")
    }
}

#Preview(as: .systemSmall) {
    DaysCalendar()
} timeline: {

    let flowerNames = (0...10).map { "Flower-\($0)" }

    var entries: [SimpleEntry] = []
    let currentDate = Date()

    for hourOffset in 0..<flowerNames.count {
        let entryDate = Calendar.current.date(
            byAdding: .hour,
            value: hourOffset,
            to: currentDate
        )!
        let flowerName = flowerNames[hourOffset]

        let entry = SimpleEntry(
            date: entryDate,
            flowerName: flowerName
        )

        entries.append(entry)
    }

    return entries

}
