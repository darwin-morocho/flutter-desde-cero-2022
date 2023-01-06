import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

Future<void> mockNetworkImages(Future<void> Function() test) {
  PathProviderPlatform.instance = MockPathProviderPlatform();
  return test();
}

class MockPathProviderPlatform extends PathProviderPlatform {
  @override
  Future<String?> getTemporaryPath() {
    throw FakeError();
  }
}

class FakeError {
  @override
  String toString() => '';
}
