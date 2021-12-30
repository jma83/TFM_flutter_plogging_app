import 'package:flutter/material.dart';

class DetailContentContainer extends StatelessWidget {
  final Widget childWidget;
  const DetailContentContainer(this.childWidget, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Colors.green[300]!,
            Colors.green,
          ],
        )),
        width: MediaQuery.of(context).size.width,
        child: Card(
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.all(8),
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.green, width: 1)),
                child: InkWell(child: childWidget))));
  }
}
