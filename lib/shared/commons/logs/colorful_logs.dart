// main.dart
import 'dart:convert';
import 'dart:developer' as developer;

/// Logs with colors.

// ANSI colors

// Blue text
void logData([dynamic msg]) {
  try {
    String str = msg?.toString() ?? '';
    if (msg is Map) {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      str = encoder.convert(msg);
    }
    final caller = _getCallerInfo();
    developer.log('$caller\x1B[90m$str\x1B[0m');
  } catch (e) {
    logError('Error to logData: $e');
  }
}

void logVerbose([dynamic msg]) {
  final str = msg?.toString() ?? '';
  final caller = _getCallerInfo();
  developer.log('$caller\x1B[35m$str\x1B[0m');
}

// Cyan
void logInfo([dynamic msg]) {
  final str = msg?.toString() ?? '';
  final caller = _getCallerInfo();
  developer.log('$caller\x1B[34m$str\x1B[0m');
}

// Green text
void logSuccess([dynamic msg]) {
  final str = msg?.toString() ?? '';
  final caller = _getCallerInfo();
  developer.log('$caller\x1B[32m$str\x1B[0m');
}

// Yellow text
void logWarning([dynamic msg]) {
  final str = msg?.toString() ?? '';
  final caller = _getCallerInfo();
  developer.log('$caller\x1B[33m$str\x1B[0m');
}

// Red text
void logError([dynamic msg]) {
  final str = msg?.toString() ?? '';
  final caller = _getCallerInfo();
  developer.log('$caller\x1B[31m$str\x1B[0m');
}

String _getCallerInfo() {
  return '';
  // final stackTrace = StackTrace.current;
  // final frames = stackTrace.toString().split('\n');

  // // The stack trace usually contains multiple frames. The first frame after the log functions
  // // is the one we're interested in, as it represents the caller.
  // // You may need to adjust the `frames` index if you have additional wrappers around the log functions.
  // final callerFrame = frames[3];

  // // Extract the function name from the frame
  // final regex = RegExp(r'#\d+\s+(.*) \(');
  // final match = regex.firstMatch(callerFrame);

  // if (match != null && match.groupCount >= 1) {
  //   final functionName = match.group(1);
  //   return '\x1B[35m$functionName: ';
  // }

  // return '';
}
