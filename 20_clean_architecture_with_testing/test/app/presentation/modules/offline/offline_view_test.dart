import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/app/inject_repositories.dart';
import 'package:tv/app/presentation/modules/offline/views/offline_view.dart';
import 'package:tv/app/presentation/routes/app_routes.dart';
import 'package:tv/app/presentation/routes/routes.dart';
import 'package:tv/main.dart';

import '../../../../inject_test_repositories.dart';

void main() {
  setUp(injectTestRepositories);

  testWidgets(
    'OfflineView',
    (tester) async {
      when(Repositories.connectivity.onInternetChanged).thenAnswer(
        (_) => Stream.value(true),
      );
      await tester.pumpWidget(
        Root(
          initialRoute: Routes.offline,
          appRoutes: {
            ...appRoutes,
            Routes.splash: (_) => const Scaffold(
                  body: Center(
                    child: Text('splash'),
                  ),
                ),
          },
        ),
      );
      expect(
        find.byType(OfflineView),
        findsOneWidget,
      );
      await tester.pumpAndSettle();
      expect(
        find.text('splash'),
        findsOneWidget,
      );
    },
  );
}
