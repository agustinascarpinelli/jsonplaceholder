import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomNavigator extends StatelessWidget {
  final onTap;
  final int index;
  const CustomNavigator({super.key, required this.onTap, required this.index});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: onTap,
      currentIndex: index,
      selectedItemColor: Colors.black,
      selectedIconTheme:const IconThemeData(color: Colors.black),
      elevation: 0,
      unselectedIconTheme:const IconThemeData(color: Colors.deepPurple),
      unselectedItemColor: Colors.deepPurple,
    items: const[
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Users'),
        BottomNavigationBarItem(
        icon: Icon(Icons.star),
        label: 'Post')
    ],
    
    );
  }
}