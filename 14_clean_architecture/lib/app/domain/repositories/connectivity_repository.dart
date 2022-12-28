abstract class ConnectivityRepository {
  Future<void> initialize();
  bool get hasInternet;
  Stream<bool> get onInternetChanged;
}
