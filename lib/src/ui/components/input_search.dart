import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputSearch extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.black87),
      padding: EdgeInsets.all(padding),
      child: CupertinoSearchTextField(
        controller: TextEditingController(text: value),
        itemSize: maxLength,
        padding: const EdgeInsets.all(8),
        backgroundColor: Colors.white,
        placeholder: placeholder,
        onChanged: (String value) {
          onChange(value);
        },
        onSubmitted: (String value) {
          onSubmit(value);
        },
      ),
    );
  }
}
