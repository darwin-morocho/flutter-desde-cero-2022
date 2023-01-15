import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/app/domain/either/either.dart';
import 'package:tv/app/domain/failures/http_request/http_request_failure.dart';
import 'package:tv/app/generated/translations.g.dart';
import 'package:tv/app/inject_repositories.dart';
import 'package:tv/app/presentation/global/widgets/request_failed.dart';
import 'package:tv/app/presentation/modules/home/views/home_view.dart';
import 'package:tv/app/presentation/modules/home/views/widgets/movies_and_series/trending_list.dart';
import 'package:tv/app/presentation/modules/home/views/widgets/movies_and_series/trending_tile.dart';
import 'package:tv/app/presentation/modules/home/views/widgets/performers/trending_performers.dart';
import 'package:tv/app/presentation/modules/movie/views/movie_view.dart';
import 'package:tv/app/presentation/routes/app_routes.dart';
import 'package:tv/app/presentation/routes/routes.dart';
import 'package:tv/main.dart';

import '../../../../../inject_test_repositories.dart';
import '../../../../../mocks.mocks.dart';
import 'utils/when.dart';

void main() {
  setUp(injectTestRepositories);

  testWidgets(
    'HomeView > load > fail',
    (tester) async {
      homeViewMockFail();
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
      homeViewMockSuccess();
      when(
        (Repositories.movies as MockMoviesRepository).getMovieById(any),
      ).thenAnswer(
        (_) async => Left(
          HttpRequestFailure.network(),
        ),
      );
      await _initApp(tester);
      expect(
        find.byType(CircularProgressIndicator),
        findsWidgets,
      );
      await tester.pumpAndSettle();
      expect(
        find.byType(RequestFailed),
        findsNothing,
      );

      await tester.tap(
        find.byIcon(Icons.favorite),
      );
      await tester.pumpAndSettle();
      expect(
        find.byKey(const Key('favorites')),
        findsOneWidget,
      );
      await tester.pageBack();
      await tester.pumpAndSettle();
      expect(
        find.byKey(const Key('favorites')),
        findsNothing,
      );
      await tester.tap(
        find.byIcon(Icons.person),
      );
      await tester.pumpAndSettle();
      expect(
        find.byKey(const Key('profile')),
        findsOneWidget,
      );
      await tester.pageBack();
      await tester.pumpAndSettle();

      await tester.tap(
        find.byKey(
          const Key('dropdown-time-window'),
        ),
      );

      await tester.pumpAndSettle();

      await tester.tap(
        find.text(texts.home.dropdownButton.lastWeek).last,
      );

      await tester.pump();
      expect(
        find.byType(CircularProgressIndicator),
        findsOneWidget,
      );
      await tester.pumpAndSettle();
      expect(
        find.byType(CircularProgressIndicator),
        findsNothing,
      );

      await tester.tap(
        find.byType(TrendingTile).first,
      );
      await tester.pumpAndSettle();
      expect(
        find.byType(MovieView),
        findsOneWidget,
      );
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
        Routes.profile: (_) => Scaffold(
              appBar: AppBar(),
              key: const Key('profile'),
            ),
        Routes.favorites: (_) => Scaffold(
              appBar: AppBar(),
              key: const Key('favorites'),
            ),
        Routes.movie: (_) => Scaffold(
              appBar: AppBar(),
              key: const Key('movie'),
            ),
      },
    ),
  );
}
