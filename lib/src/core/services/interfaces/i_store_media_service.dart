import 'dart:io';

import 'package:flutter_plogging/src/core/services/interfaces/i_store_service.dart';
import 'package:injectable/injectable.dart';

@injectable
abstract class IStoreMediaService<T> extends IStoreService<T> {
  Future<void> setImage(String id, File file);
  Future<String> getImage(String id);
}
