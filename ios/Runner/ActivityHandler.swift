import ActivityKit
import Combine

class ActivityHandler {
    var activity: Activity<BeerWidgetAttributes>? = nil
    var counter: Int64 = 0
    
    func startActivity() {
        print("Starting activity");
        let attributes = BeerWidgetAttributes()
        let state = BeerWidgetAttributes.TimerStatus(progress: 1)
        activity = try? Activity<BeerWidgetAttributes>.request(attributes: attributes, contentState: state, pushType: nil)
    }
    
    func stopActivity() {
        let state = BeerWidgetAttributes.TimerStatus(progress: 1)
        Task {
            await activity?.end(using: state, dismissalPolicy: .immediate)
        }
    }
    
    func updateActivity() {
        self.counter += 1;
        let state = BeerWidgetAttributes.TimerStatus(progress: counter)
        Task {
            await activity?.update(using: state)
        }
    }
}
