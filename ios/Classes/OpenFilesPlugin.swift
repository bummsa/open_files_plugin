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
        var openFileCount = 0
        var name: [Int32] = [CTL_KERN, KERN_PROC, KERN_PROC_PID, getpid()]
        var length = size_t(0)
        sysctl(&name, 4, nil, &length, nil, 0)
        let proc_kinfo = UnsafeMutablePointer<kinfo_proc>.allocate(capacity: length / MemoryLayout<kinfo_proc>.stride)
        defer {
            proc_kinfo.deallocate()
        }
        sysctl(&name, 4, proc_kinfo, &length, nil, 0)
        let proc = proc_kinfo.pointee
        let fileDesc = proc.kp_proc.p_fd
        openFileCount = Int(fileDesc)
        return openFileCount
    }
}
