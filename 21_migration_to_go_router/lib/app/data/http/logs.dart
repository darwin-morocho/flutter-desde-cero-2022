part of 'http.dart';

@visibleForTesting
bool showHttpErrors = true;

void _printLogs(
  Map<String, dynamic> logs,
  StackTrace? stackTrace,
) {
  if (kDebugMode) {
    // coverage:ignore-start
    if (Platform.environment.containsKey('FLUTTER_TEST') &&
        logs.containsKey('exception') &&
        showHttpErrors) {
      print(
        const JsonEncoder.withIndent('  ').convert(logs),
      );
      print(stackTrace);
    }
    // coverage:ignore-end
    log(
      '''
🔥
--------------------------------
${const JsonEncoder.withIndent('  ').convert(logs)}
--------------------------------
🔥
''',
      stackTrace: stackTrace,
    );
  }
}
