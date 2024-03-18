import 'package:dating_app/controller/profilecontroller.dart';
import 'package:dating_app/tabScreens/SearchPerson.dart';
import 'package:flutter/material.dart';
import 'package:dating_app/tabScreens/favoritesent_favoriterecieved_screen.dart';
import 'package:dating_app/tabScreens/likeandlikerecieved.dart';
import 'package:dating_app/tabScreens/swippingscreen.dart';
import 'package:dating_app/tabScreens/userdetails.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int screenIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  List tabScreensList = [
    SwappingScreen(),
    SearchPerson(),
    LikeScreen(),
    UserDetailScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            screenIndex = index;
          });
        },
        backgroundColor: Colors.black,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.white,
        currentIndex: screenIndex,
        type: BottomNavigationBarType.fixed,
        selectedIconTheme: IconThemeData(color: Colors.blue, size: 35),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.swap_horiz),
            label: 'Swap',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.thumb_up),
            label: 'Likes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      body: Center(
        child: tabScreensList[screenIndex],
      ),
    );
  }
}
