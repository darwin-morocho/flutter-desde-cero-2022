import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/app/domain/either/either.dart';
import 'package:tv/app/domain/failures/http_request/http_request_failure.dart';
import 'package:tv/app/domain/models/media/media.dart';
import 'package:tv/app/inject_repositories.dart';
import 'package:tv/app/presentation/global/widgets/request_failed.dart';
import 'package:tv/app/presentation/modules/favorites/views/favorites_view.dart';
import 'package:tv/app/presentation/modules/favorites/views/widgets/favorites_content.dart';
import 'package:tv/app/presentation/modules/movie/views/movie_view.dart';
import 'package:tv/app/presentation/routes/app_routes.dart';
import 'package:tv/app/presentation/routes/routes.dart';
import 'package:tv/main.dart';

import '../../../../../inject_test_repositories.dart';
import '../../../../../mocks.mocks.dart';
import '../../../../../mocks/mocks.dart';
import '../../../utils/stubs/stubs_signed_in.dart';
import '../stubs/stub_favorites.dart';

void main() {
  setUp(injectTestRepositories);
  testWidgets(
    'FavoritesView > load > failed',
    (tester) async {
      stubsSignedIn();
      when(
        Repositories.account.getFavorites(MediaType.movie),
      ).thenAnswer(
        (_) async {
          await Future.delayed(
            const Duration(milliseconds: 500),
          );
          return Left(
            HttpRequestFailure.network(),
          );
        },
      );
      await _initApp(tester);
      await tester.pumpAndSettle();
      await tester.tap(
        find.byIcon(Icons.favorite),
      );
      await tester.pumpAndSettle();
      expect(
        find.byType(FavoritesView),
        findsOneWidget,
      );
      expect(
        find.byType(RequestFailed),
        findsOneWidget,
      );
      await tester.tap(
        find.descendant(
          of: find.byType(RequestFailed),
          matching: find.byType(MaterialButton),
        ),
      );
      await tester.pump();
      expect(
        find.byType(CircularProgressIndicator),
        findsOneWidget,
      );
      await tester.pumpAndSettle();
      expect(
        find.byType(RequestFailed),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'FavoritesView > load > success',
    (tester) async {
      stubsSignedIn();
      stubsFavoritesSuccess();
      int counter = 0;
      when(
        (Repositories.account as MockAccountRepository).markAsFavorite(
          mediaId: anyNamed('mediaId'),
          type: anyNamed('type'),
          favorite: anyNamed('favorite'),
        ),
      ).thenAnswer(
        (_) async {
          if (counter == 0) {
            counter++;
            return Left(
              HttpRequestFailure.network(),
            );
          }
          return Right(null);
        },
      );
      await _initApp(tester);
      await tester.pumpAndSettle();
      await tester.tap(
        find.byIcon(Icons.favorite),
      );
      await tester.pumpAndSettle();
      expect(
        find.byType(FavoritesView),
        findsOneWidget,
      );
      expect(
        find.byType(FavoritesContent),
        findsOneWidget,
      );

      final mediaItemFinder = find.byKey(
        Key('movie-${mockMovieMedia.id}'),
      );
      expect(
        mediaItemFinder,
        findsOneWidget,
      );
      await tester.tap(mediaItemFinder);
      await tester.pumpAndSettle();
      expect(
        find.byType(MovieView),
        findsOneWidget,
      );
      await tester.tap(
        find.byKey(
          const Key('favorite-button'),
        ),
      );
      await tester.pumpAndSettle();
      expect(
        find.text('Network Error'),
        findsOneWidget,
      );
      await tester.tap(
        find.byKey(
          const Key('favorite-button'),
        ),
      );
      await tester.pumpAndSettle();
      await tester.pageBack();
      await tester.pumpAndSettle();
      expect(
        mediaItemFinder,
        findsNothing,
      );
    },
  );
}

Future<void> _initApp(WidgetTester tester) {
  return tester.pumpWidget(
    Root(
      initialRoute: Routes.splash,
      appRoutes: {
        ...appRoutes,
        Routes.home: (context) => Scaffold(
              key: const Key('home'),
              appBar: AppBar(
                actions: [
                  IconButton(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      Routes.favorites,
                    ),
                    icon: const Icon(
                      Icons.favorite,
                    ),
                  ),
                ],
              ),
            )
      },
    ),
  );
}
