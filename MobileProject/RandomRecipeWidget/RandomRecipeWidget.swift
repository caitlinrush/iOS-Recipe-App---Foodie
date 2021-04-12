//
//  RandomRecipeWidget.swift
//  RandomRecipeWidget
//
//  Created by Caitlin Rush on 2020-12-03.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    
    
    func placeholder(in context: Context) -> RecipeTimelineEntry {
        RecipeTimelineEntry(date: Date(), widgetData: [Recipe]())
    }

    func getSnapshot(in context: Context, completion: @escaping (RecipeTimelineEntry) -> ()) {
        let entry = RecipeTimelineEntry(date: Date(), widgetData: [Recipe]())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [RecipeTimelineEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = RecipeTimelineEntry(date: entryDate)
//            entries.append(entry)
//        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
    func getRecipeData() -> [RecipeTimelineEntry]{
        let entries = [RecipeTimelineEntry(date: Date(), widgetData: [Recipe]())]
        return entries
        
        
    }
}

struct RecipeTimelineEntry: TimelineEntry {
    let date: Date
    let widgetData: [Recipe]
    
}

struct RandomRecipeWidgetEntryView : View {
    var entry: Provider.Entry
    var body: some View {
        Text(entry.date, style: .time)
            .bold()
    }
}


@main
struct RandomRecipeWidget: Widget {
    let kind: String = "RandomRecipeWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            RandomRecipeWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Random Recipe Widget")
        .description("This widget shows a random recipe.")
    }
}

struct RandomRecipeWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RandomRecipeWidgetEntryView(entry: RecipeTimelineEntry(date: Date(), widgetData: [Recipe]()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        
        RandomRecipeWidgetEntryView(entry: RecipeTimelineEntry(date: Date(), widgetData: [Recipe]()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
        
        RandomRecipeWidgetEntryView(entry: RecipeTimelineEntry(date: Date(), widgetData: [Recipe]()))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
        .environment(\.colorScheme, .light)
    }
}
