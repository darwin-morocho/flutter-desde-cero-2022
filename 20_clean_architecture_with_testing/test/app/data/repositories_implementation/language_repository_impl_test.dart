import 'package:flutter_test/flutter_test.dart';
import 'package:tv/app/data/repositories_implementation/language_repository_impl.dart';
import 'package:tv/app/data/services/local/language_service.dart';

void main() {
  test(
    'LanguageRepositoryImpl',
    () {
      final repository = LanguageRepositoryImpl(
        LanguageService('es'),
      );
      expect(repository.languageCode, 'es');
      repository.setLanguageCode('en');
      expect(repository.languageCode, 'en');
    },
  );
}
