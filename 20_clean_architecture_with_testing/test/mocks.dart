import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:tv/app/data/services/remote/internet_checker.dart';

@GenerateMocks(
  [
    Client,
    FlutterSecureStorage,
    Connectivity,
    InternetChecker,
  ],
)
export 'mocks.mocks.dart';
