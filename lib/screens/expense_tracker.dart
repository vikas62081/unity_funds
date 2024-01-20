import 'package:flutter/material.dart';
import 'package:unity_funds/screens/activities.dart';
import 'package:unity_funds/screens/people.dart';
import 'package:unity_funds/screens/group/groups.dart';
import 'package:unity_funds/screens/home.dart';
import 'package:unity_funds/screens/user_profile.dart';

class ExpenseTrackerScreen extends StatefulWidget {
  const ExpenseTrackerScreen({super.key, required this.title});
  final String title;

  @override
  State<ExpenseTrackerScreen> createState() => _ExpenseTrackerScreenState();
}

class _ExpenseTrackerScreenState extends State<ExpenseTrackerScreen> {
  int _activeTab = 0;
  final _screens = const [
    HomeScreen(),
    GroupsScreen(),
    FriendsScreen(),
    ActivitiesScreen(),
    UserProfileScreen()
  ];

  void _onTabPressed(int tab) {
    setState(() {
      _activeTab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: _screens[_activeTab],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _activeTab,
          onTap: _onTabPressed,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: "Groups",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "People"),
            BottomNavigationBarItem(
                icon: Icon(Icons.auto_graph), label: "Activity"),
            BottomNavigationBarItem(
                icon: CircleAvatar(
                  radius: 14,
                ),
                label: "Account")
          ]),
    );
  }
}
