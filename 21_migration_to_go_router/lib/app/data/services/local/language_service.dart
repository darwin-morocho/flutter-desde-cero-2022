class LanguageService {
  LanguageService(this._languageCode);

  String _languageCode;

  String get languageCode => _languageCode;

  void setLanguageCode(String code) {
    _languageCode = code;
  }
}
