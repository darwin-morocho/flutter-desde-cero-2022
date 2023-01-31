import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/app/data/http/http.dart';
import 'package:tv/app/data/repositories_implementation/authentication_repository_impl.dart';
import 'package:tv/app/data/services/local/language_service.dart';
import 'package:tv/app/data/services/local/session_service.dart';
import 'package:tv/app/data/services/remote/account_api.dart';
import 'package:tv/app/data/services/remote/authentication_api.dart';

import '../../../../mocks.mocks.dart';

void main() {
  group(
    'AuthenticationRepositoryImpl >',
    () {
      late AuthenticationRepositoryImpl repository;
      late MockFlutterSecureStorage secureStorage;
      late MockClient client;
      setUp(
        () {
          secureStorage = MockFlutterSecureStorage();
          client = MockClient();

          final sessionService = SessionService(
            secureStorage,
          );

          final http = Http(
            client: client,
            baseUrl: 'baseUrl',
            apiKey: 'apiKey',
          );

          final authenticationAPI = AuthenticationAPI(
            http,
          );
          final accountAPI = AccountAPI(
            http,
            sessionService,
            LanguageService('es'),
          );
          repository = AuthenticationRepositoryImpl(
            authenticationAPI,
            accountAPI,
            sessionService,
          );
        },
      );
      test(
        'isSignedIn > true',
        () async {
          String? sessionId = 'lala';
          when(
            secureStorage.read(
              key: anyNamed('key'),
            ),
          ).thenAnswer(
            (_) async => sessionId,
          );

          when(
            secureStorage.deleteAll(),
          ).thenAnswer(
            (_) async {
              sessionId = null;
            },
          );

          expect(await repository.isSignedIn, true);

          await repository.signOut();

          expect(
            await repository.isSignedIn,
            false,
          );
        },
      );

      test(
        'isSignedIn > false',
        () async {
          when(
            secureStorage.read(
              key: anyNamed('key'),
            ),
          ).thenAnswer(
            (_) async => null,
          );

          final isSignedIn = await repository.isSignedIn;
          expect(isSignedIn, false);
        },
      );
    },
  );
}
