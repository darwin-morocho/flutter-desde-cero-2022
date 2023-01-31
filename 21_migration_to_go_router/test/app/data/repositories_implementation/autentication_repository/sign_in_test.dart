import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/app/data/http/http.dart';
import 'package:tv/app/data/repositories_implementation/authentication_repository_impl.dart';
import 'package:tv/app/data/services/local/language_service.dart';
import 'package:tv/app/data/services/local/session_service.dart';
import 'package:tv/app/data/services/remote/account_api.dart';
import 'package:tv/app/data/services/remote/authentication_api.dart';
import 'package:tv/app/domain/failures/sign_in/sign_in_failure.dart';
import 'package:tv/app/domain/models/user/user.dart';

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
            baseUrl: '',
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

      tearDown(() {
        showHttpErrors = true;
      });

      Future<void> mockGet({
        required String path,
        required int statusCode,
        required Map<String, dynamic> reponse,
      }) {
        final completer = Completer();
        when(
          client.get(
            Uri.parse(path),
            headers: anyNamed('headers'),
          ),
        ).thenAnswer(
          (_) async {
            completer.complete();
            return Response(
              jsonEncode(reponse),
              statusCode,
            );
          },
        );
        return completer.future;
      }

      Future<void> mockPost({
        required String path,
        required int statusCode,
        required Map<String, dynamic> response,
      }) {
        final completer = Completer();
        when(
          client.post(
            Uri.parse(path),
            headers: anyNamed('headers'),
            body: anyNamed('body'),
          ),
        ).thenAnswer(
          (_) async {
            completer.complete();
            return Response(
              jsonEncode(response),
              statusCode,
            );
          },
        );
        return completer.future;
      }

      test(
        'signIn > createRequestToken > fail',
        () async {
          // mockGet(
          //   path: '/authentication/token/new?api_key=apiKey&language=en',
          //   statusCode: 401,
          //   reponse: {
          //     'status_message': '',
          //     'success': false,
          //     'status_code': 7,
          //   },
          // );

          showHttpErrors = false;

          when(
            client.get(
              any,
              headers: anyNamed('headers'),
            ),
          ).thenThrow(
            const SocketException('fake error'),
          );

          final result = await repository.signIn(
            'username',
            'password',
          );
          expect(
            result.value,
            isA<SignInFailureNetwork>(),
          );
        },
      );

      test(
        'signIn > createSessionWithLogin > fail',
        () async {
          mockGet(
            path: '/authentication/token/new?api_key=apiKey&language=en',
            statusCode: 200,
            reponse: {
              'success': true,
              'expires_at': '2016-08-26 17:04:39 UTC',
              'request_token': 'ff5c7eeb5a8870efe3cd7fc5c282cffd26800ecd',
            },
          );

          final future = mockPost(
            path:
                '/authentication/token/validate_with_login?api_key=apiKey&language=en',
            statusCode: 401,
            response: {
              'status_message': '',
              'success': false,
              'status_code': 32,
            },
          );

          final result = await repository.signIn(
            'username',
            'password',
          );
          await future;

          expect(
            result.value,
            isA<SignInFailure>(),
          );
        },
        timeout: const Timeout(
          Duration(seconds: 5),
        ),
      );
      test(
        'signIn > createSession > fail',
        () async {
          mockGet(
            path: '/authentication/token/new?api_key=apiKey&language=en',
            statusCode: 200,
            reponse: {
              'success': true,
              'expires_at': '2016-08-26 17:04:39 UTC',
              'request_token': 'ff5c7eeb5a8870efe3cd7fc5c282cffd26800ecd',
            },
          );

          final futureCreateSessionWithLogin = mockPost(
            path:
                '/authentication/token/validate_with_login?api_key=apiKey&language=en',
            statusCode: 200,
            response: {
              'success': true,
              'expires_at': '2018-07-24 04:10:26 UTC',
              'request_token': '1531f1a558c8357ce8990cf887ff196e8f5402ec',
            },
          );

          final futureCreateSession = mockPost(
            path: '/authentication/session/new?api_key=apiKey&language=en',
            statusCode: 401,
            response: {
              'status_message': '',
              'success': false,
              'status_code': 7,
            },
          );

          final result = await repository.signIn(
            'username',
            'password',
          );
          await futureCreateSessionWithLogin;
          await futureCreateSession;

          expect(
            result.value,
            isA<SignInFailure>(),
          );
        },
        timeout: const Timeout(
          Duration(seconds: 5),
        ),
      );

      test(
        'signIn > getAccount > fail',
        () async {
          mockGet(
            path: '/authentication/token/new?api_key=apiKey&language=en',
            statusCode: 200,
            reponse: {
              'success': true,
              'expires_at': '2016-08-26 17:04:39 UTC',
              'request_token': 'ff5c7eeb5a8870efe3cd7fc5c282cffd26800ecd',
            },
          );

          showHttpErrors = false;

          when(
            client.get(
              Uri.parse(
                '/account?session_id=sessionId&api_key=apiKey&language=en',
              ),
              headers: anyNamed('headers'),
            ),
          ).thenThrow(
            const SocketException('mocked error'),
          );

          final futureCreateSessionWithLogin = mockPost(
            path:
                '/authentication/token/validate_with_login?api_key=apiKey&language=en',
            statusCode: 200,
            response: {
              'success': true,
              'expires_at': '2018-07-24 04:10:26 UTC',
              'request_token': '1531f1a558c8357ce8990cf887ff196e8f5402ec',
            },
          );

          final futureCreateSession = mockPost(
            path: '/authentication/session/new?api_key=apiKey&language=en',
            statusCode: 200,
            response: {
              'success': true,
              'session_id': 'sessionId',
            },
          );

          final result = await repository.signIn(
            'username',
            'password',
          );

          await futureCreateSessionWithLogin;
          await futureCreateSession;

          expect(
            result.value,
            isA<SignInFailure>(),
          );
        },
        timeout: const Timeout(
          Duration(seconds: 5),
        ),
      );

      test(
        'signIn > success',
        () async {
          when(
            secureStorage.write(
              key: anyNamed('key'),
              value: anyNamed('value'),
            ),
          ).thenAnswer(
            (_) => Future.value(),
          );

          mockGet(
            path: '/authentication/token/new?api_key=apiKey&language=en',
            statusCode: 200,
            reponse: {
              'success': true,
              'expires_at': '2016-08-26 17:04:39 UTC',
              'request_token': 'ff5c7eeb5a8870efe3cd7fc5c282cffd26800ecd',
            },
          );

          mockGet(
            path: '/account?session_id=sessionId&api_key=apiKey&language=en',
            statusCode: 200,
            reponse: {
              'avatar': {
                'gravatar': {'hash': 'c9e9fc152ee756a900db85757c29815d'}
              },
              'id': 548,
              'iso_639_1': 'en',
              'iso_3166_1': 'CA',
              'name': 'Travis Bell',
              'include_adult': true,
              'username': 'travisbell'
            },
          );

          mockPost(
            path:
                '/authentication/token/validate_with_login?api_key=apiKey&language=en',
            statusCode: 200,
            response: {
              'success': true,
              'expires_at': '2018-07-24 04:10:26 UTC',
              'request_token': '1531f1a558c8357ce8990cf887ff196e8f5402ec',
            },
          );

          mockPost(
            path: '/authentication/session/new?api_key=apiKey&language=en',
            statusCode: 200,
            response: {
              'success': true,
              'session_id': 'sessionId',
            },
          );

          final result = await repository.signIn(
            'username',
            'password',
          );
          expect(
            result.value,
            isA<User>(),
          );
        },
      );
    },
  );
}
