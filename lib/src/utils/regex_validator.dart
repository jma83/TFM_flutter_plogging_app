class RegexValidator {
  static bool matchRegex(String regexRules, String value) {
    RegExp regExp = RegExp(regexRules, caseSensitive: true, multiLine: false);

    return regExp.hasMatch(value);
  }
}
