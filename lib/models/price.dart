class Price {
  Price({this.value = 0});

  int value;
  double get decimal => value / 100;

  factory Price.fromString(String string) {
    assert(stringToInt(string) != null);
    return Price(value: stringToInt(string)!);
  }

  static int? stringToInt(String string) {
    final double? parsed = double.tryParse(string.replaceAll(',', '.'));
    if (parsed == null) return null;
    return (parsed * 100).round();
  }

  static String intToString(int value) {
    return 'R\$ ${(value / 100).toStringAsFixed(2)}';
  }

  String get formated => intToString(value);
}
