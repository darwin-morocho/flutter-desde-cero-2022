import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/app/data/http/http.dart';
import 'package:tv/app/data/repositories_implementation/trending_repository_impl.dart';
import 'package:tv/app/data/services/local/language_service.dart';
import 'package:tv/app/data/services/remote/trending_api.dart';
import 'package:tv/app/domain/enums.dart';
import 'package:tv/app/domain/failures/http_request/http_request_failure.dart';
import 'package:tv/app/domain/models/media/media.dart';
import 'package:tv/app/domain/models/peformer/performer.dart';

import '../../../mocks.dart';

void main() {
  group(
    'TrendingRepositoryImpl >',
    () {
      late TrendingRepositoryImpl repository;
      late MockClient client;
      setUp(
        () {
          client = MockClient();
          repository = TrendingRepositoryImpl(
            TrendingAPI(
              Http(
                client: client,
                baseUrl: '',
                apiKey: '',
              ),
              LanguageService('en'),
            ),
          );
        },
      );

      void mockGet({
        required int statusCode,
        required Map<String, dynamic> response,
      }) {
        when(
          client.get(
            any,
            headers: anyNamed('headers'),
          ),
        ).thenAnswer(
          (_) async => Response(
            jsonEncode(response),
            statusCode,
          ),
        );
      }

      test(
        'getMoviesAndSeries > success',
        () async {
          mockGet(
            statusCode: 200,
            response: {
              'page': 1,
              'results': [
                {
                  'adult': false,
                  'backdrop_path': '/bOGkgRGdhrBYJSLpXaxhXVstddV.jpg',
                  'genre_ids': [28, 12, 14, 878],
                  'id': 299536,
                  'original_language': 'en',
                  'original_title': 'Avengers: Infinity War',
                  'overview': '',
                  'poster_path': '/7WsyChQLEftFiDOVTGkv3hFpyyt.jpg',
                  'release_date': '2018-04-25',
                  'title': 'Avengers: Infinity War',
                  'video': false,
                  'media_type': 'movie',
                  'vote_average': 8.3,
                  'vote_count': 6937,
                  'popularity': 358.799,
                }
              ],
            },
          );
          final result = await repository.getMoviesAndSeries(
            TimeWindow.day,
          );
          expect(
            result.value,
            isA<List<Media>>(),
          );
        },
      );

      test(
        'getMoviesAndSeries > fail',
        () async {
          mockGet(
            statusCode: 404,
            response: {
              'status_message': '',
              'status_code': 34,
            },
          );
          final result = await repository.getMoviesAndSeries(
            TimeWindow.day,
          );
          expect(
            result.value,
            isA<HttpRequestFailureNotFound>(),
          );
        },
      );

      test(
        'getPerformers > success',
        () async {
          mockGet(
            statusCode: 200,
            response: {
              'page': 1,
              'results': [
                {
                  'adult': false,
                  'id': 3714087,
                  'name': 'Yua Mikami',
                  'original_name': 'Yua Mikami',
                  'media_type': 'person',
                  'popularity': 2.688,
                  'gender': 1,
                  'known_for_department': 'Acting',
                  'profile_path': '/vZ2FW6L8mErV81jO7DaeJ6blVTS.jpg',
                  'known_for': [],
                }
              ],
            },
          );
          final result = await repository.getPerformers();
          expect(
            result.value,
            isA<List<Performer>>(),
          );
        },
      );

      test(
        'getPerformers > fail',
        () async {
          mockGet(
            statusCode: 404,
            response: {
              'status_message': '',
              'status_code': 34,
            },
          );
          final result = await repository.getPerformers();
          expect(
            result.value,
            isA<HttpRequestFailureNotFound>(),
          );
        },
      );
    },
  );
}
