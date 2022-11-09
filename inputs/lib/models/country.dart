class Country {
  final String name;
  final String code;
  final String dialCode;

  Country({
    required this.name,
    required this.code,
    required this.dialCode,
  });

  factory Country.fromJson(Map<String, String> json) {
    return Country(
      name: json['name']!,
      code: json['code']!,
      dialCode: json['dial_code']!,
    );
  }
}
