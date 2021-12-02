import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

@injectable
class ImagePickerService {
  ImagePicker _imagePicker;

  ImagePickerService(this._imagePicker);

  Future<XFile?> pickImage(ImageSource source) async {
    try {
      return await _imagePicker.pickImage(source: source);
    } catch (e) {
      rethrow;
    }
  }

  Future<XFile?> pickVideo({ImageSource source = ImageSource.camera}) async {
    try {
      return await _imagePicker.pickVideo(source: source);
    } catch (e) {
      rethrow;
    }
  }
}
