import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tv/app/data/services/remote/internet_checker.dart';
import 'package:tv/app/domain/repositories/account_repository.dart';
import 'package:tv/app/domain/repositories/authentication_repository.dart';
import 'package:tv/app/domain/repositories/connectivity_repository.dart';
import 'package:tv/app/domain/repositories/movies_repository.dart';
import 'package:tv/app/domain/repositories/preferences_repository.dart';
import 'package:tv/app/domain/repositories/trending_repository.dart';

@GenerateMocks(
  [
    Client,
    FlutterSecureStorage,
    Connectivity,
    InternetChecker,
    SharedPreferences,
    PreferencesRepository,
    AuthenticationRepository,
    AccountRepository,
    ConnectivityRepository,
    TrendingRepository,
    MoviesRepository,
  ],
)
export 'mocks.mocks.dart';
