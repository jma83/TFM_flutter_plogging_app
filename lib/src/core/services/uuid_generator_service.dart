import 'package:uuid/uuid.dart';

class UuidGeneratorService {
  final Uuid _uuid;
  UuidGeneratorService(this._uuid);

  String generate() {
    return _uuid.v4();
  }
}
