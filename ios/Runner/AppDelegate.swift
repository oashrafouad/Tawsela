import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // green tint color for the whole app (appears in image picker, alerts, etc..)
        window?.tintColor = UIColor(red: 0.26, green: 0.50, blue: 0.31, alpha: 1.00)

        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(name: "imagePickerOptionsChannel", binaryMessenger: controller.binaryMessenger)
        channel.setMethodCallHandler({ [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            if call.method == "showImagePickerOptions" {
                let alertController = UIAlertController(title: "كيف تريد ان تختار الصورة؟", message: nil, preferredStyle: .actionSheet)

                // The result returned is 1 for camera and 2 for gallery
                let cameraAction = UIAlertAction(title: "الكاميرا", style: .default) { action in
                    result(Int(1))
                }
                let photoLibraryAction = UIAlertAction(title: "معرض الصور", style: .default) { action in
                    result(Int(2))
                }
                let cancelAction = UIAlertAction(title: "إلغاء", style: .cancel)

                alertController.addAction(cameraAction)
                alertController.addAction(photoLibraryAction)
                alertController.addAction(cancelAction)

                controller.present(alertController, animated: true)
            } else {
                result(FlutterError(code: "METHOD_NOT_IMPLEMENTED", message: "Method not implemented or incorrect method name", details: nil))
            }
        })

        GeneratedPluginRegistrant.register(with: self)
        GMSServices.provideAPIKey("***REMOVED***")
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}