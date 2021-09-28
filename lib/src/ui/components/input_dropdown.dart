// ignore_for_file: prefer_function_declarations_over_variables

import 'package:flutter/material.dart';

final boxDecoration = BoxDecoration(
    border:
        Border.all(width: 1, color: Colors.black54, style: BorderStyle.solid),
    borderRadius: BorderRadius.circular(10));

class InputDropdown extends StatefulWidget {
  String value;
  Icon icon;
  Function onChange;
  List<String> values;
  double bottomHeight;

  InputDropdown(this.value, this.values, this.icon, this.onChange,
      {Key? key, this.bottomHeight = 20})
      : super(key: key);

  @override
  _InputDropdownState createState() => _InputDropdownState();
}

class _InputDropdownState extends State<InputDropdown> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          child: DropdownButton<String>(
            value: widget.value,
            icon: widget.icon,
            isExpanded: true,
            style: const TextStyle(color: Colors.black54, fontSize: 15),
            onChanged: (String? newValue) {
              setState(() => widget.value = newValue!);
              widget.onChange(newValue);
            },
            items: widget.values.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          decoration: boxDecoration),
      SizedBox(height: widget.bottomHeight)
    ]);
  }
}
