import 'package:flutter/material.dart';

class InputText extends StatefulWidget {
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
  _InputTextState createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextField(
        readOnly: widget.readonly,
        controller: widget.textController ?? defaultTextEditingController,
        textAlignVertical: TextAlignVertical.center,
        maxLines: widget.maxLines,
        maxLength: widget.maxLength == 0 ? null : widget.maxLength,
        obscureText: widget.isPasswordField,
        keyboardType: widget.inputType,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            labelText: widget.label,
            hintText: widget.hint,
            suffixIcon: widget.icon),
        onChanged: (value) => widget.onChange(value),
      ),
      SizedBox(height: widget.bottomHeight)
    ]);
  }

  get defaultTextEditingController {
    return TextEditingController(text: "");
  }
}
