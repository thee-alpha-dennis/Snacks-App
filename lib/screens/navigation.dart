
import 'package:flutter/material.dart';
import 'package:orderingapp/constants/constants.dart';
import 'package:orderingapp/screens/aboutme.dart';
import 'package:orderingapp/screens/selecteditems.dart';
import 'package:orderingapp/screens/snacksdisplayaddtocart.dart';

import '../common/reusablewidgets/appbar.dart';

class LetsNavi extends StatefulWidget {
  const LetsNavi({Key? key}) : super(key: key);

  @override
  State<LetsNavi> createState() => _LetsNaviState();
}

class _LetsNaviState extends State<LetsNavi> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _currentIndex = 0;
  final List _listPages = [];
  late Widget _currentPage;
  @override
  void initState() {
    super.initState();
    _listPages
      ..add(const ShoppingMenu())..add(const SelectedItems())..add(Me());
    _currentPage = const ShoppingMenu();
  }

  void _changePage(int selectedIndex) {
    setState(() {
      _currentIndex = selectedIndex;
      _currentPage = _listPages[selectedIndex];
    });
  }
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: appbar,
      body:_currentPage,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFFF9900),
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.greenAccent,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt,),
            label: "Selected Snacks",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "About Me",
          ),
        ],
        onTap: (selectedIndex) => _changePage(selectedIndex),
      ),
    );
  }
}
