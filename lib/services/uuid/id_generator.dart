import 'package:uuid/uuid.dart';

class IdGenerator {
  IdGenerator._();

  final Uuid _uuid = Uuid();

  static final IdGenerator _instance = IdGenerator._();
  static IdGenerator get instance => _instance;

  factory IdGenerator() {
    return _instance;
  }

  String generateStringId() => _uuid.v4();
}
