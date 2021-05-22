import 'package:flutter/material.dart';

import 'screens/chats_screen.dart';
import 'screens/home_screen.dart';
import 'screens/matches_screen.dart';
import 'screens/news_screen.dart';
import 'screens/profile_screen.dart';
import 'utils/app_colors.dart';

class MainLayoutScreen extends StatefulWidget {
  @override
  _MainLayoutScreenState createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {

  int _currentIndex = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  final tabs = [
    HomeScreen(),
    MatchesScreen(),
    ChatScreen(),
    NewsScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test'),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
        body: tabs[_currentIndex]);
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      key: _bottomNavigationKey ,
        selectedItemColor: Color(int.parse(AppColors.primaryColor)),
        unselectedLabelStyle: TextStyle(
          color: Color(int.parse(AppColors.primaryColor))
        ),
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled,color: Color(int.parse(AppColors.primaryColor))),
            label: 'Home',
            ),
          BottomNavigationBarItem(icon: Icon(Icons.rss_feed,color: Color(int.parse(AppColors.primaryColor))),
            label: 'News',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.sports_soccer_outlined,color: Color(int.parse(AppColors.primaryColor))),
            label: 'Matches',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.chat_sharp,color: Color(int.parse(AppColors.primaryColor))),
            label: 'Chat',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person,color: Color(int.parse(AppColors.primaryColor))),
            label: 'Profile',
          ),
        ],
        type: BottomNavigationBarType.shifting,
        currentIndex: _currentIndex,
        iconSize: 30,
        onTap: _onItemTapped,
        elevation: 5
    );
  }
}
