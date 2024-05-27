extension StringExtension on String{

  String get capitalizedFirst{
    if(isEmpty) return '';
    String string = trim();
    return '${string[0].toUpperCase()}${string.substring(1)}';
  }

  String capitalizeFirstLetterEveryWord() {
    if (isEmpty) return this;

    List<String> words = split(" ");
    for (int i = 0; i < words.length; i++) {
      if (words[i].isNotEmpty) {
        words[i] = words[i][0].toUpperCase() + words[i].substring(1);
      }
    }
    return words.join(" ");
  }

  String get minuteAndSecond{
    if(isEmpty) return '';
    String string = trim();
    return string.substring(0, 5);
  }

  bool get isValidEmail {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  bool get isValidPhone {
    return RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
        .hasMatch(this);
  }
}