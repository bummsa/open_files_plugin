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
        var fd: Int32 = 0
        while true {
            let res = fcntl(fd, F_GETFD)
            if res == -1 {
                if errno == EBADF {
                    break
                }
            } else {
                openFileCount += 1
            }
            fd += 1
        }
        return openFileCount
    }

    private func getFileDescriptorLimits() -> [String: Int] {
        var rlimit = rlimit()
        if getrlimit(RLIMIT_NOFILE, &rlimit) == 0 {
            let softLimit = Int(rlimit.rlim_cur)
            let hardLimit = Int(rlimit.rlim_max)
            return ["softLimit": softLimit, "hardLimit": hardLimit]
        } else {
            return ["softLimit": -1, "hardLimit": -1]
        }
    }

}
