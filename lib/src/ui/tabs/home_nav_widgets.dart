import 'package:flutter/material.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/home_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/my_routes_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/profile_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/search_page.dart';
import 'package:flutter_plogging/src/ui/pages/home_tab_pages/start_plogging_page.dart';

const List<Widget> widgetOptions = <Widget>[
  HomePage(),
  SearchPage(),
  StartPloggingPage(),
  MyRoutesPage(),
  ProfilePage(),
];
