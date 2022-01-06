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
    _isLoading = !_isLoading;

    if (showLoadIcon) {
      _showLoadIcon();
    }
    _verifyTimeout();
  }

  setLoading(bool value, {bool showLoadIcon = true}) {
    _isLoading = value;
    if (showLoadIcon) {
      _showLoadIcon();
    }
    _verifyTimeout();
  }

  get isLoading {
    return _isLoading;
  }

  _showLoadIcon() {
    !_isLoading
        ? EasyLoading.dismiss()
        : EasyLoading.show(status: 'loading...');
  }

  _verifyTimeout() {
    if (!_isLoading) {
      return _clearTimeout();
    }
    _timer = Timer(const Duration(seconds: 6), () => _clearTimeout());
  }

  _clearTimeout() {
    EasyLoading.dismiss();
    _isLoading = false;
    _timer?.cancel();
    _timer = null;
  }
}
