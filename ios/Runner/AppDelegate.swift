import Flutter
import UIKit
import GoogleMaps                                          // Add this import

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
     GMSServices.provideAPIKey("AIzaSyAJkYw2um2QiZeDuZxcuXZzm9y4VMEQ_jg")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
