//
//  WidgetHelpers.swift
//  Days
//
//  Created for Days App Widget Extensions
//  Shared utilities for widget timeline entries and providers
//

import SwiftUI
import WidgetKit

/// Shared timeline entry structure for all Days widgets
struct DaysWidgetEntry: TimelineEntry {
    let date: Date
    let flowerName: String
}

/// Generates a list of flower names for use in widgets
func generateFlowerNames() -> [String] {
    return (0...10).map { "Flower-\($0)" }
}

/// Creates timeline entries for hourly updates (used by home screen widgets)
func createHourlyTimelineEntries(from currentDate: Date, flowerNames: [String]) -> [DaysWidgetEntry] {
    var entries: [DaysWidgetEntry] = []
    
    for hourOffset in 0..<flowerNames.count {
        guard let entryDate = Calendar.current.date(
            byAdding: .hour,
            value: hourOffset,
            to: currentDate
        ) else {
            continue
        }
        let flowerName = flowerNames[hourOffset]
        entries.append(DaysWidgetEntry(date: entryDate, flowerName: flowerName))
    }
    
    return entries
}

/// Creates timeline entries for daily updates (used by lock screen widgets)
func createDailyTimelineEntries(from currentDate: Date, flowerNames: [String], days: Int = 7) -> [DaysWidgetEntry] {
    let calendar = Calendar.current
    
    return (0..<days).compactMap { offset in
        guard let entryDate = calendar.date(
            byAdding: .day,
            value: offset,
            to: calendar.startOfDay(for: currentDate)
        ) else {
            return nil
        }
        
        let index = abs(entryDate.hashValue) % flowerNames.count
        let flowerName = flowerNames[index]
        
        return DaysWidgetEntry(date: entryDate, flowerName: flowerName)
    }
}
