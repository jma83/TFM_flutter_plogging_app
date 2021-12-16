import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoadingService {
  bool _isLoading = false;

  LoadingService();

  dynamic init() {
    return EasyLoading.init();
  }

  toggleLoading({bool showLoadIcon = true}) {
    if (showLoadIcon) {
      _isLoading
          ? EasyLoading.dismiss()
          : EasyLoading.show(status: 'loading...');
    }
    _isLoading = !_isLoading;
  }

  get isLoading {
    return _isLoading;
  }
}
