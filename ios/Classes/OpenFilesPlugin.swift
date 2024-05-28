import Flutter
import UIKit

public class SwiftOpenFilesPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "open_files_plugin", binaryMessenger: registrar.messenger())
        let instance = SwiftOpenFilesPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "getOpenFileCount" {
            result(getOpenFileCount())
        } else {
            result(FlutterMethodNotImplemented)
        }
    }

    private func getOpenFileCount() -> Int {
        var count = 0
        let files = try? FileManager.default.contentsOfDirectory(atPath: "/proc/self/fd")
        if let files = files {
            count = files.count
        }
        return count
    }
}
