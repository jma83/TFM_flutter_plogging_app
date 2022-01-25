import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/components/input_button.dart';
import 'package:image_picker/image_picker.dart';

const int maxLengthName = 20;
const int maxLengthDescription = 100;

// ignore: must_be_immutable
class UploadImage extends StatefulWidget {
  final Function uploadImage;
  XFile? image;

  UploadImage({required this.uploadImage, this.image, Key? key})
      : super(key: key);

  @override
  _UploadImage createState() => _UploadImage();
}

class _UploadImage extends State<UploadImage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 300, height: 800, child: _getForm());
  }

  Widget _getForm() {
    return ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          imageSource,
          const SizedBox(height: 15),
          InputButton(
              label: const Text("Add image from Camera"),
              buttonType: InputButtonType.elevated,
              onPress: () => updateImage(ImageSource.camera),
              icon: const Icon(Icons.camera_alt_outlined)),
          const SizedBox(height: 15),
          InputButton(
              label: const Text("Add image from Gallery"),
              buttonType: InputButtonType.outlined,
              onPress: () => updateImage(ImageSource.gallery),
              icon: const Icon(Icons.camera_alt_outlined)),
        ]);
  }

  updateImage(ImageSource imageSource) async {
    final image = await widget.uploadImage(imageSource);

    if (image == null) return;
    setState(() => widget.image = image as XFile);
  }

  Widget get imageSource {
    if (widget.image != null) {
      return Column(
        children: [
          const SizedBox(height: 15),
          const Text(
            "Uploaded Image: ",
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 5),
          Image.file(
            File(widget.image!.path),
            width: 200,
            height: 200,
          ),
          const SizedBox(height: 5),
          InputButton(
              label: const Text(""),
              width: 10,
              horizontalPadding: 0,
              buttonType: InputButtonType.elevated,
              bgColor: Colors.red,
              onPress: removeImage,
              icon: const Icon(Icons.close_rounded))
        ],
      );
    }
    return Container();
  }

  removeImage() {
    widget.uploadImage(null);
    setState(() {
      widget.image = null;
    });
  }
}
