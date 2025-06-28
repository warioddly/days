//
//  DaysCalendarLockScreen.swift
//  DaysCalendarLockScreen
//
//  Created by GØDØFIMØ on 27/6/25.
//

import SwiftUI
import WidgetKit

struct SimpleEntry: TimelineEntry {
    var date: Date
    var flowerName: String
}

struct Provider: TimelineProvider {

    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), flowerName: "Flower-0")
    }

    func getSnapshot(
        in context: Context,
        completion: @escaping @Sendable (SimpleEntry) -> Void
    ) {
        completion(SimpleEntry(date: Date(), flowerName: "Flower-0"))
    }

    func getTimeline(
        in context: Context,
        completion: @escaping @Sendable (Timeline<SimpleEntry>) -> Void
    ) {
        let flowerNames = (0...10).map { "Flower-\($0)" }
        let calendar = Calendar.current
        let currentDate = Date()

        let entries: [SimpleEntry] = (0..<7).map { dayOffset in
            let entryDate = calendar.date(
                byAdding: .day,
                value: dayOffset,
                to: currentDate
            )!
            let startOfDay = calendar.startOfDay(for: entryDate)
            let index = abs(startOfDay.hashValue) % flowerNames.count
            let flowerName = flowerNames[index]

            return SimpleEntry(date: entryDate, flowerName: flowerName)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }

}

struct DaysCalendarLockScreenEntryView: View {
    var entry: Provider.Entry

    @Environment(\.widgetFamily) var widgetFamily

    var body: some View {

        let imageHeight: CGFloat = {
            switch widgetFamily {
            case .accessoryInline: return 16
            case .accessoryRectangular: return 62
            default: return 42
            }
        }()

        let image = Image(entry.flowerName)
            .renderingMode(Image.TemplateRenderingMode.template)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: imageHeight)

        let date = Text(formatDate(entry))
            .font(.caption)
            .bold()

        let weekday = Text(formatter.string(from: entry.date).lowercased())
            .font(.caption)
            .bold()

        switch widgetFamily {
        case .accessoryInline:
            return AnyView(
                HStack {
                    image.frame(height: 16)
                    weekday
                }
            )

        case .accessoryRectangular:
            return AnyView(
                HStack {
                    image
                    Spacer().frame(width: 10)
                    VStack(alignment: .leading) {
                        date
                        Spacer().frame(height: 2)

                        let todayDayOfYear =
                            Calendar.current.ordinality(
                                of: .day,
                                in: .year,
                                for: entry.date
                            )
                            ?? 1

                        VStack(alignment: .leading) {

                            Text(
                                formatter.string(from: entry.date).lowercased()
                            )
                            .font(.caption)
                            .bold()

                            Spacer().frame(width: 12)

                            HStack {

                                Text("\(todayDayOfYear)")
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                                    .font(.caption)

                                Text("days left")
                                    .foregroundColor(Color.gray.opacity(0.4))
                                    .fontWeight(.semibold)
                                    .font(.caption)

                            }
                        }

                    }

                }
            )

        default:
            return AnyView(
                VStack {
                    image
                    date
                }
            )
        }

    }
}

struct DaysCalendarLockScreen: Widget {
    let kind: String = "DaysCalendarLockScreen"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                DaysCalendarLockScreenEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                DaysCalendarLockScreenEntryView(entry: entry)
            }
        }
        .configurationDisplayName("A Day, A Flower")
        .description(
            "A minimal lock screen widget that shows today's date and a unique flower icon for each day."
        )
        .supportedFamilies([
            .accessoryCircular, .accessoryInline, .accessoryRectangular,
        ])
    }
}

@available(iOS 17.0, *)
#Preview(as: .accessoryCircular) {
    DaysCalendarLockScreen()
} timeline: {
    let flowerNames = (0...10).map { "Flower-\($0)" }
    let calendar = Calendar.current
    let currentDate = Date()

    let entries: [SimpleEntry] = (0..<7).map { dayOffset in
        let entryDate = calendar.date(
            byAdding: .day,
            value: dayOffset,
            to: currentDate
        )!
        let startOfDay = calendar.startOfDay(for: entryDate)
        let index = abs(startOfDay.hashValue) % flowerNames.count
        let flowerName = flowerNames[index]

        return SimpleEntry(date: entryDate, flowerName: flowerName)
    }

    return entries
}
