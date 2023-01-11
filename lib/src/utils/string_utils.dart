extension StringExtension on String {
  String reverse() {
    final reversedString = StringBuffer();
    for (var i = length - 1; i >= 0; i--) {
      reversedString.write(this[i]);
    }
    return reversedString.toString();
  }

  String capitalize() {
    return this[0].toUpperCase() + substring(1);
  }

  bool isPalindrome() {
    final n = length;
    var j = n - 1;
    for (var i = 0; i < n; i++) {
      if (this[i] != this[j]) {
        return false;
      }
      j--;
    }
    return true;
  }

  String titleCase() {
    return replaceAll(RegExp(' +'), ' ')
        .split(' ')
        .map((str) => str.capitalize())
        .join(' ');
  }
}
