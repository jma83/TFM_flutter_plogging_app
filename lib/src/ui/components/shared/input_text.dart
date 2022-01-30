import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final String label;
  final String hint;
  final Icon icon;
  final int maxLength;
  final int? maxLines;
  final Function onChange;
  final double bottomHeight;
  final TextInputType inputType;
  final bool isPasswordField;
  final bool readonly;
  final TextEditingController? textController;

  const InputText(
      {required this.label,
      required this.hint,
      required this.icon,
      required this.maxLength,
      required this.onChange,
      this.textController,
      this.inputType = TextInputType.name,
      this.isPasswordField = false,
      this.bottomHeight = 5,
      this.maxLines = 1,
      this.readonly = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextField(
        readOnly: readonly,
        controller: textController ?? defaultTextEditingController,
        textAlignVertical: TextAlignVertical.center,
        maxLines: maxLines,
        maxLength: maxLength == 0 ? null : maxLength,
        obscureText: isPasswordField,
        keyboardType: inputType,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            labelText: label,
            hintText: hint,
            suffixIcon: icon),
        onChanged: (value) => onChange(value),
      ),
      SizedBox(height: bottomHeight)
    ]);
  }

  get defaultTextEditingController {
    return TextEditingController(text: "");
  }
}
