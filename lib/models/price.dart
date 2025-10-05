class Price {
  Price({this.value = 0});

  factory Price.sum(Iterable<Price> toSum) {
    final int sum = toSum.fold(
      0,
      (previousValue, element) => previousValue += element.value,
    );
    return Price(value: sum);
  }

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

  @override
  String toString() {
    return intToString(value);
  }

  String get formated => intToString(value);

  Price operator *(int other) {
    return Price(value: value * other);
  }
}
