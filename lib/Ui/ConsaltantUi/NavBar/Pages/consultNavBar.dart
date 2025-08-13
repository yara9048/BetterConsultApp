import 'package:flutter/material.dart';
import 'package:untitled6/Ui/ConsaltantUi/NavBar/NavBarPages/profile.dart';
import '../NavBarPages/addConsutation.dart';
import '../NavBarPages/home.dart';

class consultNavBar extends StatefulWidget {

  const consultNavBar({super.key});

  @override
  State<consultNavBar> createState() => _consultNavBarState();
}

class _consultNavBarState extends State<consultNavBar> {
  int _currentIndex = 1;

  final List<Widget> _pages = [
    ProfileCons(),
    HomeCons(),
    AddConsultation()
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: _pages[_currentIndex],
      backgroundColor: colorScheme.onSurface,
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: colorScheme.onSurface,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, -3),
            ),
          ],
          border: Border(
            top: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: colorScheme.onSurface,
          selectedItemColor: colorScheme.primary,
          unselectedItemColor: colorScheme.onPrimary,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontFamily: 'NotoSerifGeorgian',
          ),
          unselectedLabelStyle: TextStyle(fontFamily: 'NotoSerifGeorgian'),
          items: const [


          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            activeIcon: Icon(Icons.add),
            label: 'Add Consultation',
          ),

          ],
        ),
      ),
    );
  }
}
