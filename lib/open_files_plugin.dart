import 'dart:async';

import 'package:flutter/services.dart';

class OpenFilesPlugin {
  static const MethodChannel _channel = MethodChannel('open_files_plugin');

  static Future<int> getOpenFileCount() async {
    final int count = await _channel.invokeMethod('getOpenFileCount');
    return count;
  }

  static Future<Map<String, int>> getFileDescriptorLimits() async {
    final Map<dynamic, dynamic> limits = await _channel.invokeMethod('getFileDescriptorLimits');
    return limits.cast<String, int>();
  }

}
