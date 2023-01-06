import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/app/domain/either/either.dart';
import 'package:tv/app/domain/failures/sign_in/sign_in_failure.dart';
import 'package:tv/app/domain/models/user/user.dart';
import 'package:tv/app/inject_repositories.dart';
import 'package:tv/app/presentation/modules/sign_in/controller/sign_in_controller.dart';
import 'package:tv/app/presentation/modules/sign_in/controller/state/sign_in_state.dart';

import '../../../../../inject_test_repositories.dart';
import '../../../../../mocks.mocks.dart';
import '../mocks.dart';

void main() {
  setUp(injectTestRepositories);
  test(
    'SignInController',
    () async {
      final sessionController = MockSessionController();
      final favoritesController = MockFavoritesController();

      when(
        (Repositories.authentication as MockAuthenticationRepository).signIn(
          any,
          any,
        ),
      ).thenAnswer(
        (invocation) async {
          final username = invocation.positionalArguments.first as String;
          final password = invocation.positionalArguments.last as String;

          if (username == 'test' && password == 'Test123@') {
            return Right(
              User(
                id: 123,
                username: username,
              ),
            );
          }
          return Left(
            SignInFailure.unauthorized(),
          );
        },
      );

      int counter = 0;

      final controller = SignInController(
        const SignInState(),
        sessionController: sessionController,
        favoritesController: favoritesController,
        authenticationRepository: Repositories.authentication,
      );

      controller.addListener(
        () {
          counter++;
        },
      );

      expect(
        () async {
          await controller.submit();
        },
        throwsAssertionError,
      );

      controller.onUsernameChanged('meedu');
      controller.onPasswordChanged('Test123@');
      expect(counter, 0);

      final result = await controller.submit();
      expect(counter > 0, true);
      expect(
        result.value,
        isA<SignInFailureUnauthorized>(),
      );
      controller.onUsernameChanged('test');
      final result2 = await controller.submit();
      expect(
        result2.value,
        isA<User>(),
      );
    },
  );
}
