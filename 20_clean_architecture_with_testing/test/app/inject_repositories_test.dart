import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/app/data/http/http.dart';
import 'package:tv/app/inject_repositories.dart';
import 'package:tv/app/presentation/service_locator/service_locator.dart';

import '../mocks.mocks.dart';

void main() {
  setUp(ServiceLocator.instance.clear);
  test(
    'injectRepositories',
    () {
      final connectivity = MockConnectivity();
      final internetChecker = MockInternetChecker();

      when(connectivity.checkConnectivity()).thenAnswer(
        (_) => Future.value(ConnectivityResult.wifi),
      );
      when(connectivity.onConnectivityChanged).thenAnswer(
        (_) => const Stream.empty(),
      );

      when(internetChecker.hasInternet()).thenAnswer(
        (_) => Future.value(true),
      );

      injectRepositories(
        systemDarkMode: false,
        http: Http(
          client: MockClient(),
          apiKey: '',
          baseUrl: '',
        ),
        languageCode: 'es',
        secureStorage: MockFlutterSecureStorage(),
        preferences: MockSharedPreferences(),
        connectivity: connectivity,
        internetChecker: internetChecker,
      );

      Repositories.account;
      Repositories.authentication;
      Repositories.connectivity;
      Repositories.preferences;
      Repositories.language;
      Repositories.movies;
      Repositories.trending;
    },
  );
}
