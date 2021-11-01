import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/core/di/entities/route_coordinators.dart';
import 'package:flutter_plogging/src/core/services/authentication_service.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getIt<AuthenticationService>().signOut();

    return Container();
  }
}
