import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:async';

class LoadingService {
  bool _isLoading = false;
  Timer? _timer;
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
    verifyTimeout();
  }

  setLoading(bool value) {
    _isLoading = value;
  }

  verifyTimeout() {
    if (!_isLoading) {
      return;
    }
    _timer = Timer(const Duration(seconds: 6), () => clearTimeout());
  }

  clearTimeout() {
    EasyLoading.dismiss();
    _isLoading = false;
    _timer?.cancel();
    _timer = null;
  }

  get isLoading {
    return _isLoading;
  }
}
