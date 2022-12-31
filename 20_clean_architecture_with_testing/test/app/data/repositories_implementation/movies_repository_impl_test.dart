import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/app/data/http/http.dart';
import 'package:tv/app/data/repositories_implementation/movies_repository_impl.dart';
import 'package:tv/app/data/services/local/language_service.dart';
import 'package:tv/app/data/services/remote/movies_api.dart';
import 'package:tv/app/domain/failures/http_request/http_request_failure.dart';
import 'package:tv/app/domain/models/movie/movie.dart';
import 'package:tv/app/domain/models/peformer/performer.dart';

import '../../../mocks.mocks.dart';

void main() {
  group(
    'MoviesRepositoryImpl >',
    () {
      late MoviesRepositoryImpl repository;
      late MockClient client;
      setUp(
        () {
          client = MockClient();
          repository = MoviesRepositoryImpl(
            MoviesAPI(
              Http(
                client: client,
                baseUrl: '',
                apiKey: '',
              ),
              LanguageService('es'),
            ),
          );
        },
      );
      tearDown(
        () => showHttpErrors = true,
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
        'getMovieById > success',
        () async {
          mockGet(
            statusCode: 200,
            response: {
              'adult': false,
              'backdrop_path': '/fCayJrkfRaCRCTh8GqN30f8oyQF.jpg',
              'belongs_to_collection': null,
              'budget': 63000000,
              'genres': [
                {'id': 18, 'name': 'Drama'}
              ],
              'homepage': '',
              'id': 550,
              'imdb_id': 'tt0137523',
              'original_language': 'en',
              'original_title': 'Fight Club',
              'overview': 'overview',
              'popularity': 0.5,
              'runtime': 139,
              'poster_path': '/fCayJrkfRaCRCTh8GqN30f8oyQF.jpg',
              'title': 'Fight Club',
              'vote_average': 7.8,
              'release_date': '1999-10-12',
              'vote_count': 3439,
            },
          );
          final result = await repository.getMovieById(123);
          expect(
            result.value,
            isA<Movie>(),
          );
        },
      );

      test(
        'getMovieById > fail',
        () async {
          showHttpErrors = false;
          when(
            client.get(
              any,
              headers: anyNamed('headers'),
            ),
          ).thenThrow(
            ClientException('message'),
          );
          final result = await repository.getMovieById(123);
          expect(
            result.value,
            isA<HttpRequestFailureNetwork>(),
          );
        },
      );

      test(
        'getCastByMovie > success',
        () async {
          mockGet(
            statusCode: 200,
            response: {
              'id': 550,
              'cast': [
                {
                  'adult': false,
                  'gender': 2,
                  'id': 819,
                  'known_for_department': 'Acting',
                  'name': 'Edward Norton',
                  'original_name': 'Edward Norton',
                  'popularity': 7.861,
                  'profile_path': '/5XBzD5WuTyVQZeS4VI25z2moMeY.jpg',
                  'cast_id': 4,
                  'character': 'The Narrator',
                  'credit_id': '52fe4250c3a36847f80149f3',
                  'order': 0
                },
              ],
            },
          );
          final result = await repository.getCastByMovie(123);
          expect(
            result.value,
            isA<List<Performer>>(),
          );
        },
      );

      test(
        'getCastByMovie > fail',
        () async {
          mockGet(
            statusCode: 401,
            response: {
              'status_message': '',
              'success': false,
              'status_code': 7
            },
          );
          final result = await repository.getCastByMovie(123);
          expect(
            result.value,
            isA<HttpRequestFailureUnauthorized>(),
          );
        },
      );
    },
  );
}
