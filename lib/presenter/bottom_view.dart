import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meeting_app/presenter/pages/activity/activity_page.dart';
import 'package:meeting_app/presenter/pages/home/home_page.dart';
import 'package:meeting_app/presenter/pages/order/order_page.dart';
import 'package:meeting_app/presenter/pages/profile/profile_page.dart';

class BottomView extends StatefulWidget {
  const BottomView({Key? key}) : super(key: key);

  @override
  State<BottomView> createState() => _BottomViewState();
}

class _BottomViewState extends State<BottomView> {

  List<Widget> pages = const [
    HomePage(),
    ActivityPage(),
    OrderPage(),
    ProfilePage()
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: indexBottom,
        backgroundColor: Colors.indigo,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'My Activity',
            icon: Icon(Icons.calendar_month_rounded),
          ),
          BottomNavigationBarItem(
            label: 'Orders',
            icon: Icon(Icons.fact_check_outlined),
          ),
          BottomNavigationBarItem(
            label: 'My Profile',
            icon: Icon(Icons.account_circle_outlined),
          ),
        ],
      ),
      body: pages[_currentIndex],
    );
  }

  void indexBottom(int index){
    setState((){
      _currentIndex = index;
    });
  }
}
