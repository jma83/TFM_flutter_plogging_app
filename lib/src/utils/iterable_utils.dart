import 'package:flutter_plogging/src/core/domain/entity_data.dart';
import 'package:flutter_plogging/src/core/domain/like/like_data.dart';
import 'package:flutter_plogging/src/core/model/interfaces/i_model.dart';
import 'package:flutter_plogging/src/core/model/like_model.dart';

class IterableUtils {
  static Future<List<EntityData>> requestProgressiveIn(
      IModel model, List<String> list, String field) async {
    List<EntityData> modelList = [];
    int cont = 0;
    double iterationsDouble = list.length / 10;
    int iterations = list.length % 10 == 0
        ? iterationsDouble.toInt()
        : iterationsDouble.toInt() + 1;
    while (iterations > 0) {
      modelList += await model.queryElementInCriteria(
          field,
          list.sublist(_getIncrement(cont, list.length),
              _getIncrement(cont + 10, list.length))) as List<EntityData>;
      cont += 10;
      iterations--;
    }

    return modelList;
  }

  static Future<List<LikeData>> requestProgressiveInMatchLikes(
      LikeModel model, List<String> list, String userId) async {
    List<LikeData> modelList = [];
    int cont = 0;
    double iterationsDouble = list.length / 10;
    int iterations = list.length % 10 == 0
        ? iterationsDouble.toInt()
        : iterationsDouble.toInt() + 1;
    while (iterations > 0) {
      modelList += await model.matchRoutesWithUserLikes(
          userId,
          list.sublist(_getIncrement(cont, list.length),
              _getIncrement(cont + 10, list.length)));
      cont += 10;
      iterations--;
    }

    return modelList;
  }

  static int _getIncrement(int length, int maxSize) {
    return length >= maxSize ? maxSize : length;
  }
}
