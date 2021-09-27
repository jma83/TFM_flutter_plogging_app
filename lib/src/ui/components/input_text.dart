import 'package:flutter/material.dart';

class InputText {
  static Widget createInput(
      String label, String hint, Icon icon, Function onChange,
      {bool emailField = false,
      bool passwordField = false,
      bool numericField = false,
      bool dateField = false}) {
    final keyboardType = emailField
        ? TextInputType.emailAddress
        : numericField
            ? TextInputType.number
            : dateField
                ? TextInputType.datetime
                : TextInputType.name;
    return Stack(children: [
      TextField(
          maxLength: 50,
          obscureText: passwordField,
          keyboardType: keyboardType,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              labelText: label,
              hintText: hint,
              suffixIcon: icon),
          onChanged: (value) => onChange(value)),
      const SizedBox(height: 15)
    ]);
  }
}
