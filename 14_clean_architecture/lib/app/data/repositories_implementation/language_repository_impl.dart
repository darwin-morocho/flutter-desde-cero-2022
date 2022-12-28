import '../../domain/repositories/language_repository.dart';
import '../services/local/language_service.dart';

class LanguageRepositoryImpl implements LanguageRepository {
  final LanguageService _service;

  LanguageRepositoryImpl(this._service);

  @override
  void setLanguageCode(String code) {
    _service.setLanguageCode(code);
  }
}
