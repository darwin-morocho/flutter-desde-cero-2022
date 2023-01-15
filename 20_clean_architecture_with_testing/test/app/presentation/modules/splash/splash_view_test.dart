import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/app/domain/either/either.dart';
import 'package:tv/app/inject_repositories.dart';
import 'package:tv/app/presentation/modules/splash/views/splash_view.dart';
import 'package:tv/app/presentation/routes/app_routes.dart';
import 'package:tv/app/presentation/routes/routes.dart';
import 'package:tv/main.dart';

import '../../../../inject_test_repositories.dart';
import '../../../../mocks.mocks.dart';
import '../../utils/stubs/stubs_signed_in.dart';

void main() {
  setUp(
    () {
      injectTestRepositories();
    },
  );
  testWidgets(
    'SplashView > offline',
    (tester) async {
      when(Repositories.connectivity.hasInternet).thenReturn(false);

      await tester.pumpWidget(
        Root(
          appRoutes: {
            ...appRoutes,
            Routes.offline: (_) => const Scaffold(
                  body: Center(
                    child: Text('offline'),
                  ),
                ),
          },
        ),
      );

      expect(
        find.byType(SplashView),
        findsOneWidget,
      );
      await tester.pumpAndSettle();
      expect(
        find.text('offline'),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'SplashView > hasInternet > signIn',
    (tester) async {
      when(Repositories.connectivity.hasInternet).thenReturn(true);
      when(Repositories.authentication.isSignedIn).thenAnswer(
        (_) async => false,
      );

      await tester.pumpWidget(
        Root(
          appRoutes: {
            ...appRoutes,
            Routes.signIn: (_) => const Scaffold(
                  body: Center(
                    child: Text('signIn'),
                  ),
                ),
          },
        ),
      );

      expect(
        find.byType(SplashView),
        findsOneWidget,
      );
      await tester.pumpAndSettle();
      expect(
        find.text('signIn'),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'SplashView > hasInternet > isSignedIn > home',
    (tester) async {
      stubsSignedIn();
      when(
        (Repositories.account as MockAccountRepository).getFavorites(any),
      ).thenAnswer(
        (_) async => Right({}),
      );

      await tester.pumpWidget(
        Root(
          appRoutes: {
            ...appRoutes,
            Routes.home: (_) => const Scaffold(
                  body: Center(
                    child: Text('home'),
                  ),
                ),
          },
        ),
      );

      expect(
        find.byType(SplashView),
        findsOneWidget,
      );
      await tester.pumpAndSettle();
      expect(
        find.text('home'),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'SplashView > hasInternet > isSignedIn > signIn',
    (tester) async {
      when(Repositories.connectivity.hasInternet).thenReturn(true);
      when(Repositories.authentication.isSignedIn).thenAnswer(
        (_) async => true,
      );
      when(Repositories.account.getUserData()).thenAnswer(
        (_) async => null,
      );

      await tester.pumpWidget(
        Root(
          appRoutes: {
            ...appRoutes,
            Routes.signIn: (_) => const Scaffold(
                  body: Center(
                    child: Text('signIn'),
                  ),
                ),
          },
        ),
      );

      expect(
        find.byType(SplashView),
        findsOneWidget,
      );
      await tester.pumpAndSettle();
      expect(
        find.text('signIn'),
        findsOneWidget,
      );
    },
  );
}
