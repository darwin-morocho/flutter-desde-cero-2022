import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _key = 'sessionId';
const _accountKey = 'accountId';

class SessionService {
  SessionService(this._secureStorage);

  final FlutterSecureStorage _secureStorage;

  Future<String?> get sessionId {
    return _secureStorage.read(key: _key);
  }

  Future<String?> get accountId {
    return _secureStorage.read(key: _accountKey);
  }

  Future<void> saveSessionId(String sessionId) {
    return _secureStorage.write(
      key: _key,
      value: sessionId,
    );
  }

  Future<void> saveAccountId(String accountId) {
    return _secureStorage.write(
      key: _accountKey,
      value: accountId,
    );
  }

  Future<void> signOut() {
    return _secureStorage.deleteAll();
  }
}
