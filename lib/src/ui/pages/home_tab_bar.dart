import 'package:flutter/material.dart';

class HomeTabBar extends StatefulWidget {
  HomeTabBar(this.widgetOptions, this.navbarItems, {Key? key})
      : super(key: key);

  @override
  State<HomeTabBar> createState() => _HomeTabBarState();
  List<Widget> widgetOptions = [];
  List<BottomNavigationBarItem> navbarItems = [];
}

class _HomeTabBarState extends State<HomeTabBar> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.navbarItems[_selectedIndex].label}'),
      ),
      body: Center(
        child: widget.widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: widget.navbarItems,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black87,
        unselectedLabelStyle: const TextStyle(color: Colors.black87),
        onTap: _onItemTapped,
      ),
    );
  }
}
