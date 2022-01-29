import 'dart:io';

import 'package:flutter_plogging/src/core/model/interfaces/i_model.dart';
import 'package:injectable/injectable.dart';

@injectable
abstract class IMediaModel<T> extends IModel<T> {
  Future<void> setAndSaveImage(String id, T data, String image);
  Future<void> setImage(String id, File file);
  Future<String> getImage(String id);
}
