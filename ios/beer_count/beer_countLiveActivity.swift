//
//  beer_countLiveActivity.swift
//  beer_count
//
//  Created by Paul Krenn on 19.11.24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct beer_countAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct beer_countLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: beer_countAttributes.self) { context in
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

extension beer_countAttributes {
    fileprivate static var preview: beer_countAttributes {
        beer_countAttributes(name: "World")
    }
}

extension beer_countAttributes.ContentState {
    fileprivate static var smiley: beer_countAttributes.ContentState {
        beer_countAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: beer_countAttributes.ContentState {
         beer_countAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: beer_countAttributes.preview) {
   beer_countLiveActivity()
} contentStates: {
    beer_countAttributes.ContentState.smiley
    beer_countAttributes.ContentState.starEyes
}
