import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/core/domain/gender/gender_data.dart';
import 'package:flutter_plogging/src/ui/components/input_button.dart';
import 'package:flutter_plogging/src/ui/components/input_dropdown.dart';
import 'package:flutter_plogging/src/ui/components/input_text.dart';

class ProfileFormFields extends StatelessWidget {
  final String? username;
  final String? age;
  final String? gender;
  final String? email;
  final String? password;
  final String? confirmPassword;
  final String? oldPassword;
  final Function? callbackSetEmail;
  final Function? callbackSetUsername;
  final Function? callbackSetPassword;
  final Function? callbackSetConfirmPassword;
  final Function? callbackSetOldPassword;
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
      this.password,
      this.confirmPassword,
      this.oldPassword,
      this.callbackSetEmail,
      this.callbackSetUsername,
      this.callbackSetPassword,
      this.callbackSetConfirmPassword,
      this.callbackSetOldPassword,
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
        getOldPassword(),
        InputText(
            textController: TextEditingController(text: password ?? ""),
            label: isRegister ? "Password" : "New Password",
            hint: "Type your password",
            icon: const Icon(Icons.lock_outline),
            maxLength: 25,
            onChange: callbackSetPassword ?? emptyFunction,
            isPasswordField: true,
            bottomHeight: 10),
        InputText(
            textController: TextEditingController(text: confirmPassword ?? ""),
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

  getOldPassword() {
    return isRegister
        ? Container()
        : InputText(
            textController: TextEditingController(text: oldPassword ?? ""),
            label: "Old Password",
            hint: "Type your current password",
            icon: const Icon(Icons.lock_rounded),
            maxLength: 25,
            onChange: callbackSetOldPassword ?? emptyFunction,
            isPasswordField: true,
            bottomHeight: 10);
  }

  emptyFunction() {}
}
