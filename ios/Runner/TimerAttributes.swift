//
//  TimerAttributes.swift
//  Live Beer
//
//  Created by Paul Krenn on 29.10.24.
//

import ActivityKit
import SwiftUI

struct TimerAttributes: ActivityAttributes{
    public typealias TimerStatus = ContentState
    
    public struct ContentState: Codable, Hashable{
        var progress: Int64
    }
}
