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
        var mib = [CTL_KERN, KERN_PROC, KERN_PROC_PID, getpid()]
        var size = 0
        sysctl(&mib, u_int(mib.count), nil, &size, nil, 0)
        var proc_kinfo = [CChar](repeating: 0, count: size)
        sysctl(&mib, u_int(mib.count), &proc_kinfo, &size, nil, 0)
        
        let kinfo_ptr = UnsafeRawPointer(proc_kinfo).assumingMemoryBound(to: kinfo_proc.self)
        let filedesc = kinfo_ptr.pointee.kp_proc.p_fd
        
        return Int(filedesc)
    }
}
