import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        
        registerBeerChannel(controller)
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    fileprivate func registerBeerChannel(_ controller: FlutterViewController) {
        let beerChannel = FlutterMethodChannel(name: "com.lab73/beer",
                                               binaryMessenger: controller.binaryMessenger)
        
        beerChannel.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
            if(call.method == "sendBeer"){
                self?.sendBeer(result: result)
            }
            if(call.method == "updateBeer"){
                self?.updateBeer(result: result)
            }
            if(call.method == "cancelBeer"){
                self?.cancelBeer(result: result)
            }
        })
    }
    
    let handler = ActivityHandler();
    
    private func sendBeer(result: FlutterResult) {
        handler.startActivity();
        
        result(true);
    }
    
    private func updateBeer(result: FlutterResult) {
        handler.updateActivity();
        result(true);
    }
    
    private func cancelBeer(result: FlutterResult) {
        handler.stopActivity();
        result(true);
    }
}
