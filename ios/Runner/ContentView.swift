//
//  ContentView.swift
//  Live Beer
//
//  Created by Paul Krenn on 29.10.24.
//
import ActivityKit
import SwiftUI
import Combine


struct ContentView: View {
    @State private var activity: Activity<TimerAttributes>? = nil
    @State private var counter: Int64 = 0
    @State private var timerSubscription: AnyCancellable? = nil
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button("Start activity") {
                print("Hello world!")
                startActivity()
            }
            Button("Stop activity") {
                stopActivity()
            }
            Button("Update") {
                startCounterUpdate()
            }
        }
        .padding()
    }
    
    func startActivity() {
        let attributes = TimerAttributes()
        let state = TimerAttributes.TimerStatus(progress: 1)
        activity = try? Activity<TimerAttributes>.request(attributes: attributes, contentState: state, pushType: nil)
    }
    
    func stopActivity() {
        let state = TimerAttributes.TimerStatus(progress: 1)
        
        Task {
            await activity?.end(using: state, dismissalPolicy: .immediate)
        }
        stopCounterUpdate() // Stop counter when activity ends
    }
    
    func updateActivity() {
        let state = TimerAttributes.TimerStatus(progress: counter)
        
        Task {
            await activity?.update(using: state)
        }
    }
    
    func startCounterUpdate() {
        stopCounterUpdate() // Ensure no duplicate timers
        
        timerSubscription = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                counter += 1
                updateActivity()
            }
    }
    
    func stopCounterUpdate() {
        timerSubscription?.cancel()
        timerSubscription = nil
    }
}

#Preview {
    ContentView()
}
