import 'package:flutter/material.dart';

class FormContainer extends StatelessWidget {
  final List<Widget> widgetList;
  const FormContainer({required this.widgetList, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Colors.white38,
            Colors.green,
          ],
        )),
        child: Center(
            child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                children: widgetList)));
  }
}
