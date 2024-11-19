//
//  BeerCountWidget.swift
//  BeerCount
//
//  Created by Paul Krenn on 29.10.24.
//

import WidgetKit
import SwiftUI
import ActivityKit

import WidgetKit
import SwiftUI
import ActivityKit
import Combine

import WidgetKit
import SwiftUI
import ActivityKit
import Combine

struct TimerActivityView: View {
    let context: ActivityViewContext<TimerAttributes>
    
    var body: some View {
        VStack(alignment: .center) {
            VStack(alignment: .center) {
                HStack {
                    Image(systemName: "takeoutbag.and.cup.and.straw.fill")
                        .resizable().aspectRatio(contentMode: .fit)
                        .frame(width: 14, height: 14)
                        .foregroundColor(.pink)
                    
                    Spacer()
                    
                    Text("~ 1 Min")
                        .font(.system(size: 14))
                        .bold()
                }
                .padding(.horizontal, 10)
                
                Text("Dein Bier ist unterwegs!")
                    .font(.system(size: 20))
                    .bold()
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Vom")
                        .font(.system(size: 8))
                    Text("Kühlschrank")
                        .font(.system(size: 14))
                        .bold()
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("Zu")
                        .font(.system(size: 8))
                    Text("Dir!")
                        .font(.system(size: 14))
                        .bold()
                }
            }
            .frame(height: 20)
            .padding(.horizontal, 10)
            
        
            ZStack {
                ProgressView(value: CGFloat(context.state.progress), total: 100)
                    .tint(.pink)
                    .background(.white)
                GeometryReader { geometry in

                                Text("🍺")
                                    .position(x: 5, y: geometry.size.height / 2)
                                    .offset(x: CGFloat(geometry.size.width / 100 * CGFloat(context.state.progress)), y: 0)
                        }
            }.frame(height: 20).padding(.horizontal, 10)
        }
        .frame(height: 160)
        .background(.black)
    }
}






// Extracted DynamicIsland Configuration
struct TimerDynamicIsland {
    let context: ActivityViewContext<TimerAttributes>
    
    func dynamicIsland() -> DynamicIsland {
        DynamicIsland {
            DynamicIslandExpandedRegion(.center) {
                ZStack {
                    ProgressView(value: CGFloat(context.state.progress), total: 100)
                        .tint(.pink)
                        .background(.white)
                    GeometryReader { geometry in

                                    Text("🍺")
                                        .position(x: 5, y: geometry.size.height / 2)
                                        .offset(x: CGFloat(geometry.size.width / 100 * CGFloat(context.state.progress)), y: 0)
                            }
                }.frame(height: 20).padding(.horizontal, 10)
            }
            DynamicIslandExpandedRegion(.bottom) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Vom")
                            .font(.system(size: 8))
                        Text("Kühlschrank")
                            .font(.system(size: 14))
                            .bold()
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        Text("Zu")
                            .font(.system(size: 8))
                        Text("Dir!")
                            .font(.system(size: 14))
                            .bold()
                    }
                }
                .frame(height: 20)
                .padding(.horizontal, 10)
            }
        } compactLeading: {
            Text("🍺")
        } compactTrailing: {
            Text("Bierservice")
        } minimal: {
            Text("🍺")
        }
    }
}

struct BeerCountWidget: Widget {
    let kind: String = "BeerCountWidget"

    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TimerAttributes.self) { context in
            TimerActivityView(context: context)
        } dynamicIsland: { context in
            TimerDynamicIsland(context: context).dynamicIsland()
        }
    }
}
