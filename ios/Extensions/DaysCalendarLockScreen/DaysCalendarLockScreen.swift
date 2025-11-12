//
//  DaysCalendarLockScreen.swift
//  DaysCalendarLockScreen
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
        completion: @escaping @Sendable (DaysWidgetEntry) -> Void
    ) {
        completion(DaysWidgetEntry(date: Date(), flowerName: "Flower-0"))
    }

    func getTimeline(
        in context: Context,
        completion: @escaping @Sendable (Timeline<DaysWidgetEntry>) -> Void
    ) {
        let flowerNames = generateFlowerNames()
        let entries = createDailyTimelineEntries(from: Date(), flowerNames: flowerNames)

        let nextMidnight = Calendar.current.nextDate(
            after: Date(),
            matching: DateComponents(hour: 0),
            matchingPolicy: .strict
        )!

        let timeline = Timeline(entries: entries, policy: .after(nextMidnight))
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
    let flowerNames = generateFlowerNames()
    return createDailyTimelineEntries(from: Date(), flowerNames: flowerNames)
}
