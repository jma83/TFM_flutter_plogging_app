import 'package:flutter/material.dart';
import 'package:property_change_notifier/property_change_notifier.dart';

abstract class PageWidget extends StatelessWidget {
  final PropertyChangeNotifier<String> viewModel;
  const PageWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context);
}
