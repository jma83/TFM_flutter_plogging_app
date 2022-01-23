import 'package:flutter/material.dart';

const List<BottomNavigationBarItem> bottomNavBarItems =
    <BottomNavigationBarItem>[
  BottomNavigationBarItem(
    activeIcon: Icon(Icons.home),
    icon: Icon(Icons.home_outlined),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    activeIcon: Icon(Icons.search),
    icon: Icon(Icons.search_outlined),
    label: 'Search',
  ),
  BottomNavigationBarItem(
    activeIcon: Icon(Icons.near_me_sharp),
    icon: Icon(Icons.near_me_outlined),
    label: 'Plogging',
  ),
  BottomNavigationBarItem(
    activeIcon: Icon(Icons.map_sharp),
    icon: Icon(Icons.map_outlined),
    label: 'My Routes',
  ),
  BottomNavigationBarItem(
    activeIcon: Icon(Icons.person_pin_circle_rounded),
    icon: Icon(Icons.person_pin_circle_outlined),
    label: 'Profile',
  ),
];
