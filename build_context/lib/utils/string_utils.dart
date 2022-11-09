extension StringExtension on String {
  bool get isEmail {
    return contains("@");
  }
}
 