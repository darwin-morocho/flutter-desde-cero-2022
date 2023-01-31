import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'generated/translations.g.dart';
import 'inject_repositories.dart';
import 'presentation/global/controllers/theme_controller.dart';
import 'presentation/global/theme.dart';
import 'presentation/modules/splash/views/splash_view.dart';
import 'presentation/routes/router.dart';

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
    required this.initialRoute,
    this.overrideRoutes,
  });
  final String? initialRoute;
  final List<GoRoute>? overrideRoutes;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>
    with WidgetsBindingObserver, RouterMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    if (locales?.isNotEmpty ?? false) {
      final locale = locales!.first;
      Repositories.language.setLanguageCode(
        locale.languageCode,
      );
      Intl.defaultLocale = locale.toLanguageTag();
      LocaleSettings.setLocaleRaw(
        locale.languageCode,
      );
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = context.watch();

    if (loading) {
      return const SplashView();
    }

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp.router(
        theme: getTheme(themeController.darkMode),
        routerConfig: router,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: LocaleSettings.supportedLocales,
        locale: TranslationProvider.of(context).flutterLocale,
      ),
    );
  }
}
