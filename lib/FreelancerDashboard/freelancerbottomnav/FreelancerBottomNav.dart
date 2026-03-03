import 'package:flutter/material.dart';

class FreelancerCustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const FreelancerCustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: const Color.fromARGB(0, 0, 0, 0),
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.white,       // full white
      unselectedItemColor: Colors.white70,   // slightly dim white
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard_outlined),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search_outlined),
          label: 'Find Job',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.description_outlined),
          label: 'My Proposals',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        ),
      ],
    );
  }
}