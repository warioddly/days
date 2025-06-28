//
//  DaysDots.swift
//  DaysDots
//
//  Created by GØDØFIMØ on 27/6/25.
//

import SwiftUI
import WidgetKit

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(
        in context: Context,
        completion: @escaping (SimpleEntry) -> Void
    ) {
        completion(SimpleEntry(date: Date()))
    }

    func getTimeline(
        in context: Context,
        completion: @escaping (Timeline<Entry>) -> Void
    ) {
        let currentDate = Date()
        let entry = SimpleEntry(date: currentDate)

        let nextMidnight = Calendar.current.nextDate(
            after: currentDate,
            matching: DateComponents(hour: 0, minute: 0),
            matchingPolicy: .nextTime
        )!

        let timeline = Timeline(
            entries: [entry],
            policy: .after(nextMidnight)
        )
        completion(timeline)
    }

}

struct DaysDotsEntryView: View {
    var entry: Provider.Entry

    @Environment(\.widgetFamily) var widgetFamily

    var body: some View {
        switch widgetFamily {
        case .systemLarge: AnyView(YearDotsLargeWidgetView(entry: entry))
        case .systemMedium: AnyView(YearDotsMediumWidgetView(entry: entry))
        default: AnyView(YearDotsSmallWidgetView(entry: entry))
        }
    }
}

struct DaysDots: Widget {
    let kind: String = "DaysDots"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(macOS 14.0, iOS 17.0, *) {
                DaysDotsEntryView(entry: entry)
                    .containerBackground(.black, for: .widget)
            } else {
                DaysDotsEntryView(entry: entry)
                    .padding()
                    .background(.black)
            }
        }
        .supportedFamilies([
            .systemLarge, .systemMedium, .systemSmall,
        ])
        .configurationDisplayName("Days in Dots")
        .description(
            "A minimal calendar where each dot marks a day of your year."
        )
    }
}

struct YearDotsSmallWidgetView: View {
    var entry: SimpleEntry

    var body: some View {
        YearDotsBuilderView(
            entry: entry,
            spacing: 3.3,
            gridItemSpacing: 1,
            horizontalItemCount: 16
        )
    }
}

struct YearDotsMediumWidgetView: View {
    var entry: SimpleEntry

    var body: some View {
        VStack {

            YearDotsBuilderView(
                entry: entry,
                spacing: 5.5,
                gridItemSpacing: 2.5,
                horizontalItemCount: 30
            )

            Spacer().frame(height: 10)

            YearDotsStatusBarView(entry: entry)

        }
    }
}

struct YearDotsLargeWidgetView: View {
    var entry: SimpleEntry

    var body: some View {

        VStack {

            YearDotsBuilderView(
                entry: entry,
                spacing: 12.5,
                gridItemSpacing: 7.5,
                horizontalItemCount: 20
            )

            Spacer().frame(height: 10)

            YearDotsStatusBarView(entry: entry)

        }
    }
}

struct YearDotsStatusBarView: View {

    var entry: SimpleEntry

    var body: some View {

        let currentYear = Calendar.current.component(.year, from: entry.date)
        let todayDayOfYear =
            Calendar.current.ordinality(of: .day, in: .year, for: entry.date)
            ?? 1

        HStack {

            Text(formatDate(entry) + " \(currentYear)")
                .foregroundColor(.white)
                .fontWeight(.semibold)
                .font(.caption)

            Spacer()

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

struct YearDotsBuilderView: View {
    var entry: SimpleEntry

    var spacing: CGFloat
    var gridItemSpacing: CGFloat
    var horizontalItemCount: Int

    var body: some View {

        let currentYear = Calendar.current.component(.year, from: entry.date)
        let date = Calendar.current.date(
            from: DateComponents(year: currentYear, month: 12, day: 31)
        )!
        let totalDaysInYear =
            Calendar.current.ordinality(of: .day, in: .year, for: date) ?? 365
        let todayDayOfYear =
            Calendar.current.ordinality(of: .day, in: .year, for: entry.date)
            ?? 1

        let columns = Array(
            repeating: GridItem(.fixed(gridItemSpacing)),
            count: horizontalItemCount
        )

        LazyVGrid(columns: columns, spacing: spacing) {
            ForEach(1...totalDaysInYear, id: \.self) { day in
                Circle()
                    .fill(
                        day <= todayDayOfYear
                            ? .white
                            : Color.gray.opacity(0.4)
                    )
                    .frame(width: 3, height: 3)
            }
        }
    }
}

#Preview(as: .systemSmall) {
    DaysDots()
} timeline: {
    SimpleEntry(date: .now)
    SimpleEntry(
        date: Calendar.current.date(byAdding: .day, value: 1, to: .now)!
    )
    SimpleEntry(
        date: Calendar.current.date(byAdding: .day, value: 2, to: .now)!
    )
    SimpleEntry(
        date: Calendar.current.date(byAdding: .day, value: 3, to: .now)!
    )
    SimpleEntry(
        date: Calendar.current.date(byAdding: .day, value: 4, to: .now)!
    )
}
