import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/components/input_button.dart';
import 'package:flutter_plogging/src/ui/components/input_text.dart';

const int maxLengthName = 20;
const int maxLengthDescription = 100;

class CreateRouteConfirmation extends StatefulWidget {
  final Function setName;
  final Function setDescription;
  final Function setImage;

  const CreateRouteConfirmation(
      {required this.setName,
      required this.setDescription,
      required this.setImage,
      Key? key})
      : super(key: key);

  @override
  _CreateRouteConfirmation createState() => _CreateRouteConfirmation();
}

class _CreateRouteConfirmation extends State<CreateRouteConfirmation> {
  @override
  Widget build(BuildContext context) {
    return Container(width: 300, height: 800, child: _getForm());
  }

  Widget _getForm() {
    return Column(
      children: [
        InputText(
            label: "Name",
            hint: "Your email account",
            icon: const Icon(Icons.alternate_email),
            maxLength: 0,
            onChange: widget.setName),
        const SizedBox(height: 15),
        InputText(
            label: "Description",
            hint: "Description of the route (optional)",
            icon: const Icon(Icons.lock_outline),
            maxLength: 0,
            inputType: TextInputType.multiline,
            onChange: widget.setDescription,
            isPasswordField: false,
            maxLines: 8),
        const SizedBox(height: 15),
        InputButton(
            label: const Text("Add image from Camera"),
            buttonType: InputButtonType.elevated,
            onPress: () {
              widget.setImage();
            },
            icon: const Icon(Icons.camera_alt_outlined)),
        const SizedBox(height: 15),
        InputButton(
            label: const Text("Add image from Gallery"),
            buttonType: InputButtonType.outlined,
            onPress: widget.setImage,
            icon: const Icon(Icons.camera_alt_outlined)),
      ],
    );
  }
}
