import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/app/domain/either/either.dart';
import 'package:tv/app/domain/failures/sign_in/sign_in_failure.dart';
import 'package:tv/app/domain/models/user/user.dart';
import 'package:tv/app/generated/translations.g.dart';
import 'package:tv/app/inject_repositories.dart';
import 'package:tv/app/presentation/modules/sign_in/views/sign_in_view.dart';
import 'package:tv/app/presentation/modules/sign_in/views/widgets/submit_button.dart';
import 'package:tv/app/presentation/routes/app_routes.dart';
import 'package:tv/app/presentation/routes/routes.dart';
import 'package:tv/main.dart';

import '../../../../../inject_test_repositories.dart';
import '../../../../../mocks.mocks.dart';

void main() {
  setUp(injectTestRepositories);

  testWidgets(
    'SignInView > empty fields',
    (tester) async {
      await _initApp(tester);
      expect(
        find.byType(SignInView),
        findsOneWidget,
      );

      await tester.tap(
        find.byType(SubmitButton),
      );
      await tester.pump();
      expect(
        find.text(texts.signIn.username),
        findsOneWidget,
      );
      expect(
        find.text(texts.signIn.password),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'SignInView > success',
    (tester) async {
      when(
        (Repositories.account as MockAccountRepository).getFavorites(any),
      ).thenAnswer(
        (_) async => Right({}),
      );
      when(
        Repositories.authentication.signIn('test', 'Test123@'),
      ).thenAnswer(
        (_) async {
          await Future.delayed(
            const Duration(milliseconds: 50),
          );
          return Right(
            const User(id: 123, username: 'username'),
          );
        },
      );

      await _fillAndSendForm(tester);
      await tester.pumpAndSettle();
      expect(
        find.text('home'),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'SignInView > fail > notFound',
    (tester) async {
      when(
        Repositories.authentication.signIn('test', 'Test123@'),
      ).thenAnswer(
        (_) async {
          await Future.delayed(
            const Duration(milliseconds: 50),
          );
          return Left(
            SignInFailure.notFound(),
          );
        },
      );

      await _fillAndSendForm(tester);
      await tester.pumpAndSettle();
      expect(
        find.text(texts.signIn.errors.submit.notFound),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'SignInView > fail > network',
    (tester) async {
      when(
        Repositories.authentication.signIn('test', 'Test123@'),
      ).thenAnswer(
        (_) async {
          await Future.delayed(
            const Duration(milliseconds: 50),
          );
          return Left(
            SignInFailure.network(),
          );
        },
      );

      await _fillAndSendForm(tester);
      await tester.pumpAndSettle();
      expect(
        find.text(texts.signIn.errors.submit.network),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'SignInView > fail > unauthorized',
    (tester) async {
      when(
        Repositories.authentication.signIn('test', 'Test123@'),
      ).thenAnswer(
        (_) async {
          await Future.delayed(
            const Duration(milliseconds: 50),
          );
          return Left(
            SignInFailure.unauthorized(),
          );
        },
      );

      await _fillAndSendForm(tester);
      await tester.pumpAndSettle();
      expect(
        find.text(texts.signIn.errors.submit.unauthorized),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'SignInView > fail > unknown',
    (tester) async {
      when(
        Repositories.authentication.signIn('test', 'Test123@'),
      ).thenAnswer(
        (_) async {
          await Future.delayed(
            const Duration(milliseconds: 50),
          );
          return Left(
            SignInFailure.unknown(),
          );
        },
      );

      await _fillAndSendForm(tester);
      await tester.pumpAndSettle();
      expect(
        find.text(texts.signIn.errors.submit.unknown),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'SignInView > fail > notVerified',
    (tester) async {
      when(
        Repositories.authentication.signIn('test', 'Test123@'),
      ).thenAnswer(
        (_) async {
          await Future.delayed(
            const Duration(milliseconds: 50),
          );
          return Left(
            SignInFailure.notVerified(),
          );
        },
      );

      await _fillAndSendForm(tester);
      await tester.pumpAndSettle();
      expect(
        find.text(texts.signIn.errors.submit.notVerified),
        findsOneWidget,
      );
    },
  );
}

Future<void> _initApp(WidgetTester tester) {
  return tester.pumpWidget(
    Root(
      initialRoute: Routes.signIn,
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
}

Future<void> _fillAndSendForm(WidgetTester tester) async {
  await _initApp(tester);
  await tester.enterText(
    find.byKey(
      const Key('input-username'),
    ),
    'test',
  );
  await tester.enterText(
    find.byKey(
      const Key('input-password'),
    ),
    'Test123@',
  );
  await tester.pump();
  await tester.tap(
    find.byType(MaterialButton),
  );
  await tester.pump();
  expect(
    find.byType(CircularProgressIndicator),
    findsOneWidget,
  );
}
