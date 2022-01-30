// ignore_for_file: prefer_function_declarations_over_variables

import 'package:flutter/material.dart';

final boxDecoration = BoxDecoration(
    border:
        Border.all(width: 1, color: Colors.black54, style: BorderStyle.solid),
    borderRadius: BorderRadius.circular(10));

class InputDropdown extends StatelessWidget {
  final String value;
  final Icon icon;
  final Function onChange;
  final List<String> values;
  final double bottomHeight;

  const InputDropdown(this.value, this.values, this.icon, this.onChange,
      {Key? key, this.bottomHeight = 20})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          child: DropdownButton<String>(
            value: value,
            icon: icon,
            isExpanded: true,
            style: const TextStyle(color: Colors.black54, fontSize: 15),
            onChanged: (String? newValue) {
              onChange(newValue);
            },
            items: values.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          decoration: boxDecoration),
      SizedBox(height: bottomHeight)
    ]);
  }
}
