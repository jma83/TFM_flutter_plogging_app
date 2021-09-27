class RegexValidator {
  static bool matchRegex(String regexRules, String value) {
    RegExp regExp = RegExp(regexRules, caseSensitive: false, multiLine: false);
    print("allMatches : " + regExp.allMatches(value).toString());
    print("firstMatch : " + regExp.firstMatch(value).toString());
    print("hasMatch : " + regExp.hasMatch(value).toString());
    print("stringMatch : " + regExp.stringMatch(value).toString());
    return false;
  }
}
