extension FirstCapital on String {
  String firstCapital() {
    List<String> words = split(' ');
    List<String> result = [];
    words.forEach((word) {
      result.add(word[0].toUpperCase() + word.substring(1));
    });
    return result.join(' ');
  }
}
