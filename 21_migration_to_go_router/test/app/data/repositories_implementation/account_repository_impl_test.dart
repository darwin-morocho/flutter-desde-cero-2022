import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/app/data/http/http.dart';
import 'package:tv/app/data/repositories_implementation/account_repository_impl.dart';
import 'package:tv/app/data/services/local/language_service.dart';
import 'package:tv/app/data/services/local/session_service.dart';
import 'package:tv/app/data/services/remote/account_api.dart';
import 'package:tv/app/domain/failures/http_request/http_request_failure.dart';
import 'package:tv/app/domain/models/media/media.dart';

import '../../../mocks.dart';

void main() {
  late MockClient client;
  late MockFlutterSecureStorage secureStorage;
  late AccountRepositoryImpl repository;

  setUp(
    () {
      client = MockClient();
      secureStorage = MockFlutterSecureStorage();
      final sessionService = SessionService(
        secureStorage,
      );

      when(
        secureStorage.read(key: anyNamed('key')),
      ).thenAnswer(
        (_) async => 'lala',
      );

      final accountAPI = AccountAPI(
        Http(
          client: client,
          baseUrl: 'https://api.themoviedb.org/3',
          apiKey: '4248991ee7e5702debde74e854effa57',
        ),
        sessionService,
        LanguageService('en'),
      );

      repository = AccountRepositoryImpl(
        accountAPI,
        sessionService,
      );
    },
  );

  void mockGet({
    required int statusCode,
    required Map<String, dynamic> json,
  }) {
    when(
      client.get(
        any,
        headers: anyNamed('headers'),
      ),
    ).thenAnswer(
      (_) async => Response(
        jsonEncode(json),
        statusCode,
      ),
    );
  }

  test(
    'AccountRepositoryImpl > getUserData',
    () async {
      when(
        secureStorage.read(key: sessionIdKey),
      ).thenAnswer(
        (_) async => 'sessionId',
      );

      mockGet(
        statusCode: 200,
        json: {
          'id': 123,
          'username': 'darwin',
          'avatar': {},
        },
      );

      final user = await repository.getUserData();
      expect(user, isNotNull);
    },
  );

  test(
    'AccountRepositoryImpl > getFavorites > fail',
    () async {
      mockGet(
        statusCode: 401,
        json: {
          'status_code': 3,
          'status_message': '',
        },
      );

      final result = await repository.getFavorites(
        MediaType.movie,
      );

      expect(
        result.value,
        isA<HttpRequestFailure>(),
      );
    },
  );

  test(
    'AccountRepositoryImpl > getFavorites > success',
    () async {
      mockGet(
        statusCode: 200,
        json: {
          'page': 1,
          'results': [
            {
              'backdrop_path': null,
              'first_air_date': '2007-09-24',
              'genre_ids': [10759],
              'id': 1404,
              'original_language': 'en',
              'original_name': 'Chuck',
              'overview': '',
              'origin_country': ['US'],
              'poster_path': '/lala.png',
              'popularity': 0.125125,
              'name': 'Chuck',
              'vote_average': 8.2,
              'vote_count': 37
            }
          ],
          'total_pages': 3,
          'total_results': 52
        },
      );

      final result = await repository.getFavorites(
        MediaType.movie,
      );

      expect(
        result.value,
        isA<Map<int, Media>>(),
      );
    },
  );

  test(
    'AccountRepositoryImpl > markAsFavorite > success',
    () async {
      when(
        client.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer(
        (_) async => Response(
          jsonEncode(
            {
              'status_code': 12,
              'status_message': '',
            },
          ),
          201,
        ),
      );
      final result = await repository.markAsFavorite(
        mediaId: 123,
        type: MediaType.movie,
        favorite: true,
      );

      expect(
        result.value is! HttpRequestFailure,
        true,
      );
    },
  );

  test(
    'AccountRepositoryImpl > markAsFavorite > fail',
    () async {
      when(
        client.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer(
        (_) async => Response(
          jsonEncode(
            {
              'status_code': 34,
              'status_message': '',
            },
          ),
          404,
        ),
      );
      final result = await repository.markAsFavorite(
        mediaId: 123,
        type: MediaType.movie,
        favorite: true,
      );

      expect(
        result.value is HttpRequestFailure,
        true,
      );
    },
  );
}
