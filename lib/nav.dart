import 'package:cs4750_app/pomodoro.dart';
import 'package:cs4750_app/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'home.dart';

class Nav extends StatefulWidget{
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    Home(),
    Todo(),
    Pomodoro(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),

      bottomNavigationBar: BottomNavigationBar(items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.checklist), label: 'Todo'),
        BottomNavigationBarItem(icon: Icon(Icons.emoji_food_beverage), label: 'Pomodoro'),
      ],
      backgroundColor: Color(0xFFFAF9F9),
        selectedItemColor: Color(0xFF89B0AE),
        unselectedItemColor: Color(0xFF555B6E),
      currentIndex: _selectedIndex,
      onTap: _onItemTap,
      ),
    );
  }
}