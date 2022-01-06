import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/core/domain/gender_data.dart';
import 'package:flutter_plogging/src/ui/components/input_button.dart';
import 'package:flutter_plogging/src/ui/components/input_dropdown.dart';
import 'package:flutter_plogging/src/ui/components/input_text.dart';

class ProfileFormFields extends StatelessWidget {
  final String? username;
  final String? age;
  final String? gender;
  final String? email;
  final Function? callbackSetEmail;
  final Function? callbackSetUsername;
  final Function? callbackSetPassword;
  final Function? callbackSetConfirmPassword;
  final Function? callbackSetAge;
  final Function? callbackSetGender;
  final Function callbackValidateForm;
  final bool isRegister;

  const ProfileFormFields(
      {required this.callbackValidateForm,
      required this.isRegister,
      this.username,
      this.age,
      this.gender,
      this.email,
      this.callbackSetEmail,
      this.callbackSetUsername,
      this.callbackSetPassword,
      this.callbackSetConfirmPassword,
      this.callbackSetAge,
      this.callbackSetGender,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputText(
          textController: TextEditingController(text: email ?? ""),
          readonly: !isRegister,
          inputType: TextInputType.emailAddress,
          bottomHeight: 10,
          label: "Email",
          hint: "Type your email",
          icon: const Icon(Icons.alternate_email),
          maxLength: 50,
          onChange: callbackSetEmail ?? emptyFunction,
        ),
        InputText(
          textController: TextEditingController(text: username ?? ""),
          inputType: TextInputType.name,
          label: "Username",
          hint: "Type your username",
          icon: const Icon(Icons.person_outline),
          maxLength: 25,
          onChange: callbackSetUsername ?? emptyFunction,
          bottomHeight: 10,
        ),
        InputText(
            label: "Password",
            hint: "Type your password",
            icon: const Icon(Icons.lock_outline),
            maxLength: 25,
            onChange: callbackSetPassword ?? emptyFunction,
            isPasswordField: true,
            bottomHeight: 10),
        InputText(
            label: "Confirm password",
            hint: "Confirm your password",
            icon: const Icon(Icons.lock_outline),
            maxLength: 25,
            onChange: callbackSetConfirmPassword ?? emptyFunction,
            isPasswordField: true,
            bottomHeight: 10),
        InputText(
          textController: TextEditingController(text: age ?? ""),
          label: "Age",
          hint: "Type your age",
          icon: const Icon(Icons.date_range),
          maxLength: 3,
          onChange: callbackSetAge ?? emptyFunction,
          inputType: TextInputType.number,
          bottomHeight: 10,
        ),
        InputDropdown(
            gender ?? Gender.NotDefined,
            const [Gender.NotDefined, Gender.Female, Gender.Male],
            const Icon(Icons.all_inclusive_sharp),
            callbackSetGender ?? emptyFunction),
        InputButton(
            label: isRegister ? const Text("Register") : const Text("Update"),
            buttonType: InputButtonType.elevated,
            onPress: callbackValidateForm,
            icon: const Icon(Icons.login)),
      ],
    );
  }

  emptyFunction() {}
}
