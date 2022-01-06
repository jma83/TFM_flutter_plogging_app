import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputSearch extends StatefulWidget {
  final String placeholder;
  final double maxLength;
  final Function onChange;
  final Function onSubmit;
  final double padding;
  final String value;

  const InputSearch(
      {required this.placeholder,
      required this.maxLength,
      required this.onChange,
      required this.onSubmit,
      this.value = "",
      this.padding = 15,
      Key? key})
      : super(key: key);

  @override
  _InputTextState createState() => _InputTextState();
}

class _InputTextState extends State<InputSearch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.black87),
      padding: EdgeInsets.all(widget.padding),
      child: CupertinoSearchTextField(
        controller: TextEditingController(text: widget.value),
        itemSize: widget.maxLength,
        padding: const EdgeInsets.all(8),
        backgroundColor: Colors.white,
        placeholder: widget.placeholder,
        onChanged: (String value) {
          widget.onChange(value);
        },
        onSubmitted: (String value) {
          widget.onSubmit(value);
        },
      ),
    );
  }
}
