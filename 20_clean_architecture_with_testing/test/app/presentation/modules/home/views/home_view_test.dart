import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/app/domain/either/either.dart';
import 'package:tv/app/domain/failures/http_request/http_request_failure.dart';
import 'package:tv/app/domain/models/media/media.dart';
import 'package:tv/app/domain/models/peformer/performer.dart';
import 'package:tv/app/inject_repositories.dart';
import 'package:tv/app/presentation/global/widgets/request_failed.dart';
import 'package:tv/app/presentation/modules/home/views/home_view.dart';
import 'package:tv/app/presentation/modules/home/views/widgets/movies_and_series/trending_list.dart';
import 'package:tv/app/presentation/modules/home/views/widgets/performers/trending_performers.dart';
import 'package:tv/app/presentation/routes/app_routes.dart';
import 'package:tv/app/presentation/routes/routes.dart';
import 'package:tv/main.dart';

import '../../../../../inject_test_repositories.dart';
import '../../../../../mocks.mocks.dart';

void main() {
  setUp(injectTestRepositories);

  testWidgets(
    'HomeView > load > fail',
    (tester) async {
      when(Repositories.connectivity.hasInternet).thenReturn(false);
      when(Repositories.connectivity.onInternetChanged).thenAnswer(
        (_) => const Stream.empty(),
      );

      when(
        (Repositories.trending as MockTrendingRepository)
            .getMoviesAndSeries(any),
      ).thenAnswer(
        (_) async {
          await Future.delayed(
            const Duration(milliseconds: 50),
          );
          return Left(
            HttpRequestFailure.network(),
          );
        },
      );
      when(Repositories.trending.getPerformers()).thenAnswer(
        (_) async {
          await Future.delayed(
            const Duration(milliseconds: 50),
          );
          return Left(
            HttpRequestFailure.network(),
          );
        },
      );

      await _initApp(tester);
      expect(
        find.byType(HomeView),
        findsOneWidget,
      );
      expect(
        find.byType(CircularProgressIndicator),
        findsWidgets,
      );
      await tester.pumpAndSettle();
      expect(
        find.byType(RequestFailed),
        findsWidgets,
      );

      await tester.tap(
        find.descendant(
          of: find.byType(TrendingList),
          matching: find.byType(MaterialButton),
        ),
      );
      await tester.pump();

      expect(
        find.byType(CircularProgressIndicator),
        findsOneWidget,
      );

      await tester.pumpAndSettle();

      await tester.tap(
        find.descendant(
          of: find.byType(TrendingPerformers),
          matching: find.byType(MaterialButton),
        ),
      );
      await tester.pump();

      expect(
        find.byType(CircularProgressIndicator),
        findsOneWidget,
      );

      await tester.pumpAndSettle();

      tester.binding.window.clearPhysicalSizeTestValue();
    },
  );

  testWidgets(
    'HomeView > load > success',
    (tester) async {
      final mediaList = [
        Media(
          id: 123,
          overview: 'overview',
          title: 'title',
          originalTitle: 'originalTitle',
          posterPath: 'posterPath',
          backdropPath: 'backdropPath',
          voteAverage: 8,
          type: MediaType.movie,
        ),
      ];

      when(Repositories.connectivity.hasInternet).thenReturn(true);
      when(Repositories.connectivity.onInternetChanged).thenAnswer(
        (_) => const Stream.empty(),
      );

      when(
        (Repositories.trending as MockTrendingRepository)
            .getMoviesAndSeries(any),
      ).thenAnswer(
        (_) async {
          await Future.delayed(
            const Duration(milliseconds: 50),
          );
          return Right(mediaList);
        },
      );
      when(Repositories.trending.getPerformers()).thenAnswer(
        (_) async {
          await Future.delayed(
            const Duration(milliseconds: 50),
          );
          return Right(
            [
              Performer(
                id: 12,
                name: 'name',
                popularity: 9,
                originalName: 'originalName',
                profilePath: 'profilePath',
                knownFor: mediaList,
              ),
            ],
          );
        },
      );

      await _initApp(tester);
      expect(
        find.byType(HomeView),
        findsOneWidget,
      );
      expect(
        find.byType(CircularProgressIndicator),
        findsWidgets,
      );
      await tester.pumpAndSettle();
      expect(
        find.byType(RequestFailed),
        findsNothing,
      );

      await tester.pumpAndSettle();

      tester.binding.window.clearPhysicalSizeTestValue();
    },
  );
}

Future<void> _initApp(WidgetTester tester) {
  tester.binding.window.physicalSizeTestValue = const Size(4000, 12000);
  return tester.pumpWidget(
    Root(
      initialRoute: Routes.home,
      appRoutes: {
        ...appRoutes,
        Routes.profile: (_) => const Scaffold(
              key: Key('profile'),
            ),
        Routes.favorites: (_) => const Scaffold(
              key: Key('favorites'),
            ),
      },
    ),
  );
}
