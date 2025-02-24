//
//  DaysHomeWidget.swift
//  DaysHomeWidget
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
        func getDaysFlutterData() -> SimpleEntry{
            let userDefaults = UserDefaults(suiteName: "group.daysHomeScreenApp")
            let daysFromFlutterApp = userDefaults?.integer(forKey: "daysHomeWidgetDays") ?? 0
            return SimpleEntry(date: Date(),numberOfGreyDots: daysFromFlutterApp)
        }
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(),numberOfGreyDots: 182) // Placeholder with a default value
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = getDaysFlutterData() // Snapshot with a sample value
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let entry = getDaysFlutterData()

        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    var date: Date
    let numberOfGreyDots: Int
}

struct DaysHomeWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        
        GeometryReader { geometry in
            let availableWidth = geometry.size.width
            let availableHeight = geometry.size.height
            
            let totalDots = 365
            let numberOfGreyDots = entry.numberOfGreyDots
            
            // Calculate optimal layout
            let layout = calculateOptimalLayout(
                totalDots: totalDots,
                width: availableWidth,
                height: availableHeight
            )
            
            VStack(spacing: layout.spacing) {
                ForEach(0..<layout.rows, id: \.self) { row in
                    HStack(spacing: layout.spacing) {
                        ForEach(0..<layout.columns, id: \.self) { column in
                            let dotIndex = row * layout.columns + column
                            
                            if dotIndex < totalDots {
                                Circle()
                                    .frame(width: layout.dotSize, height: layout.dotSize)
                                    .foregroundColor(dotIndex < numberOfGreyDots ? .gray : .white)
                            } else {
                                Color.clear
                                    .frame(width: layout.dotSize, height: layout.dotSize)
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .containerBackground(.black, for: .widget)
        }
    }
    }

struct LayoutMetrics {
        let columns: Int
        let rows: Int
        let dotSize: CGFloat
        let spacing: CGFloat
    }
    
    // Calculate the optimal layout based on available space
    private func calculateOptimalLayout(totalDots: Int, width: CGFloat, height: CGFloat) -> LayoutMetrics {
        // Target a slightly wider than tall aspect ratio for aesthetics
        let targetAspectRatio: CGFloat = 1.2
        
        // Start with square root as baseline for columns
        var bestColumns = Int(sqrt(Double(totalDots)))
        var bestRows = Int(ceil(Double(totalDots) / Double(bestColumns)))
        var bestScore: CGFloat = .infinity
        
        // Try different column counts to find optimal layout
        let minColumns = max(Int(sqrt(Double(totalDots))) - 5, 1)
        let maxColumns = min(Int(sqrt(Double(totalDots))) + 10, totalDots)
        
        for cols in minColumns...maxColumns {
            let rows = Int(ceil(Double(totalDots) / Double(cols)))
            let ratio = CGFloat(cols) / CGFloat(rows)
            let score = abs(ratio - targetAspectRatio)
            
            // Check if this layout would fit better in the available space
            let potentialDotSize = min(width / CGFloat(cols), height / CGFloat(rows))
            let currentBestDotSize = min(width / CGFloat(bestColumns), height / CGFloat(bestRows))
            
            if score < bestScore && potentialDotSize >= currentBestDotSize {
                bestScore = score
                bestColumns = cols
                bestRows = rows
            }
        }
        
        // Calculate final metrics
        let maxPossibleDotSize = min(
            width / CGFloat(bestColumns),
            height / CGFloat(bestRows)
        )
        
        let dotSize = maxPossibleDotSize * 0.8 // Use 80% of available space for dots
        let spacing = maxPossibleDotSize * 0.2 // Use 20% of available space for spacing
        
        return LayoutMetrics(
            columns: bestColumns,
            rows: bestRows,
            dotSize: dotSize,
            spacing: spacing
        )
    }

struct DaysHomeWidget: Widget {
    let kind: String = "DaysHomeWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            DaysHomeWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("DaysHomeWidget")
        .description("Displays a number of grey dots.")
    }
}

struct DaysHomewidget_Previews: PreviewProvider {
    static var previews: some View {
        DaysHomeWidgetEntryView(entry: SimpleEntry(date: Date(), numberOfGreyDots: 150))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
