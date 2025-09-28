class PhoneNumber {
  final String countryCode;
  final String areaCode;
  final String localNumber;

  PhoneNumber({
    this.countryCode = '55',
    this.areaCode = '21',
    required this.localNumber,
  });

  @override
  String toString() {
    final localStr = localNumber.toString().padLeft(9, '0');
    final firstPart = localStr.substring(0, 5).replaceAll('-', '');
    final secondPart = localStr.substring(5).replaceAll('-', '');
    return '+$countryCode ($areaCode) $firstPart-$secondPart';
  }

  static PhoneNumber fromString(String input) {
    final regex = RegExp(r'^\+(\d{2}) \((\d{2})\) (\d{5})-(\d{4})$');
    final match = regex.firstMatch(input);
    if (match == null) {
      throw FormatException('Formato de telefone inválido');
    }

    return PhoneNumber(
      countryCode: match.group(1)!,
      areaCode: match.group(2)!,
      localNumber: '${match.group(3)}${match.group(4)}',
    );
  }

  static String? isValid(String? input) {
    if (input == null || input.trim().isEmpty) {
      return 'O número de telefone é obrigatório.';
    }

    final regex = RegExp(r'^\+55 \(\d{2}\) \d{5}-\d{4}$');
    if (!regex.hasMatch(input)) {
      return 'Formato inválido. Use: +55 (21) 99999-9999';
    }

    return null;
  }
}
