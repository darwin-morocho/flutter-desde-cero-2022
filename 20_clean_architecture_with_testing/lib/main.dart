import 'dart:ui' as ui;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_strategy/url_strategy.dart';

import 'app/data/http/http.dart';
import 'app/data/services/remote/internet_checker.dart';
import 'app/domain/repositories/preferences_repository.dart';
import 'app/generated/translations.g.dart';
import 'app/inject_repositories.dart';
import 'app/my_app.dart';
import 'app/presentation/global/controllers/favorites/favorites_controller.dart';
import 'app/presentation/global/controllers/favorites/state/favorites_state.dart';
import 'app/presentation/global/controllers/session_controller.dart';
import 'app/presentation/global/controllers/theme_controller.dart';
import 'app/presentation/routes/routes.dart';

// coverage:ignore-start
void main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale();
  Intl.defaultLocale = LocaleSettings.currentLocale.languageTag;

  final http = Http(
    client: Client(),
    baseUrl: 'https://api.themoviedb.org/3',
    apiKey: '4248991ee7e5702debde74e854effa57',
  );

  final systemDarkMode = ui.window.platformBrightness == Brightness.dark;

  await injectRepositories(
    systemDarkMode: systemDarkMode,
    http: http,
    languageCode: LocaleSettings.currentLocale.languageCode,
    secureStorage: const FlutterSecureStorage(),
    preferences: await SharedPreferences.getInstance(),
    connectivity: Connectivity(),
    internetChecker: InternetChecker(),
  );

  runApp(
    const Root(),
  );
}
// coverage:ignore-end

class Root extends StatelessWidget {
  const Root({
    super.key,
    this.initialRoute = Routes.splash,
    this.appRoutes,
  });
  final String initialRoute;
  final Map<String, WidgetBuilder>? appRoutes;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeController>(
          create: (context) {
            final PreferencesRepository preferencesRepository =
                Repositories.preferences;
            return ThemeController(
              preferencesRepository.darkMode,
              preferencesRepository: preferencesRepository,
            );
          },
        ),
        ChangeNotifierProvider<SessionController>(
          create: (context) => SessionController(
            authenticationRepository: Repositories.authentication,
          ),
        ),
        ChangeNotifierProvider<FavoritesController>(
          create: (context) => FavoritesController(
            FavoritesState.loading(),
            accountRepository: Repositories.account,
          ),
        ),
      ],
      child: TranslationProvider(
        child: MyApp(
          initialRoute: initialRoute,
          appRoutes: appRoutes,
        ),
      ),
    );
  }
}
