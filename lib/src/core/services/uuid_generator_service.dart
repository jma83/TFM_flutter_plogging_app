import 'package:uuid/uuid.dart';

class UiidGeneratorService {
  final Uuid _uuid;
  UiidGeneratorService(this._uuid);

  String generate() {
    return _uuid.v4();
  }
}
