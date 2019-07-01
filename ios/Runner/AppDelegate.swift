import UIKit
import Flutter
import OpenFoodFactsMpp

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    AppFlutterIOSKt.configureStandardCodecMessageChannel(self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
