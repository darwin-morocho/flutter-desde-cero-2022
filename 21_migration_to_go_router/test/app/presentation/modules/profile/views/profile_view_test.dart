import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/app/domain/either/either.dart';
import 'package:tv/app/inject_repositories.dart';
import 'package:tv/app/presentation/modules/sign_in/views/sign_in_view.dart';
import 'package:tv/app/presentation/modules/splash/views/splash_view.dart';
import 'package:tv/app/presentation/routes/routes.dart';
import 'package:tv/main.dart';

import '../../../../../inject_test_repositories.dart';
import '../../../../../mocks.mocks.dart';
import '../../../utils/stubs/stubs_signed_in.dart';

void main() {
  setUp(injectTestRepositories);
  testWidgets(
    'ProfileView > darkMode',
    (tester) async {
      await _initApp(
        tester,
        initialRoute: Routes.profile,
      );
      final scaffoldState = tester.state(
        find.byType(Scaffold),
      );
      final initialBrightness = Theme.of(scaffoldState.context).brightness;
      expect(initialBrightness, Brightness.light);
      await tester.tap(
        find.byType(SwitchListTile),
      );
      await tester.pumpAndSettle();
      expect(
        Theme.of(scaffoldState.context).brightness,
        Brightness.dark,
      );
    },
  );

  testWidgets(
    'ProfileView > sign out',
    (tester) async {
      stubsSignedIn();
      when(
        (Repositories.account as MockAccountRepository).getFavorites(any),
      ).thenAnswer(
        (_) async => Right({}),
      );

      when(Repositories.authentication.signOut()).thenAnswer(
        (_) async {
          await Future.delayed(
            const Duration(milliseconds: 100),
          );
        },
      );
      await _initApp(
        tester,
        initialRoute: null,
      );
      expect(find.byType(SplashView), findsOneWidget);
      await tester.pumpAndSettle();
      expect(
        find.byKey(
          const Key('home'),
        ),
        findsOneWidget,
      );

      await tester.tap(
        find.byIcon(Icons.person),
      );
      await tester.pumpAndSettle();

      await tester.tap(
        find.byKey(
          const Key('sign-out-list-tile'),
        ),
      );
      await tester.pump(
        const Duration(milliseconds: 110),
      );
      await tester.pumpAndSettle();
      expect(
        find.byType(SignInView),
        findsOneWidget,
      );
    },
  );
}

Future<void> _initApp(
  WidgetTester tester, {
  required String? initialRoute,
}) {
  return tester.pumpWidget(
    Root(
      initialRoute: initialRoute,
      overrideRoutes: [
        GoRoute(
          name: Routes.home,
          path: '/',
          builder: (context, __) => Scaffold(
            key: const Key('home'),
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () => context.pushNamed(
                    Routes.profile,
                  ),
                  icon: const Icon(Icons.person),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
