import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:watchlist/src/features/dashboard/presentation/views/search_screen.dart';
import 'package:watchlist/src/features/dashboard/presentation/views/watchlist_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _screens = <Widget>[
    SearchScreen(),
    WatchlistScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedLabelStyle: GoogleFonts.montserrat(),
          unselectedLabelStyle: GoogleFonts.montserrat(),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.tv),
              label: 'Watchlist',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      );
}
