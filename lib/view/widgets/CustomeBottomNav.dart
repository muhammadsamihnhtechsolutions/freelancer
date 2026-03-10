// import 'package:flutter/material.dart';

// class CustomBottomNav extends StatelessWidget {
//   final int currentIndex;
//   final Function(int) onTap;

//   const CustomBottomNav({
//     super.key,
//     required this.currentIndex,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//    return BottomNavigationBar(
//   currentIndex: currentIndex,
//   onTap: onTap,
//   backgroundColor: const Color.fromARGB(0, 233, 17, 17),
//   elevation: 0,
//   type: BottomNavigationBarType.fixed,
//   selectedItemColor: Colors.white,      // full white
//   unselectedItemColor: Colors.white70,  // slightly dim white
//   showUnselectedLabels: true,
//   items: const [
//     BottomNavigationBarItem(
//       icon: Icon(Icons.dashboard_outlined),
//       label: 'Dashboard',
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(Icons.work_outline),
//       label: 'Jobs',
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(Icons.group_outlined),
//       label: 'Freelancer',
//     ),
//         BottomNavigationBarItem(
//     icon: Icon(Icons.post_add_outlined),
//       label: 'PostJob',
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(Icons.person_outline),
//       label: 'Profile',
//     ),


//   ],
// );
//   }
// }

import 'package:flutter/material.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65, // 👈 thoda height increase
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        backgroundColor: const Color.fromARGB(0, 233, 17, 17),
        elevation: 0,
        type: BottomNavigationBarType.fixed,

        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,

        showUnselectedLabels: true,

        iconSize: 22, // 👈 thoda chota icon

        selectedFontSize: 11, // 👈 font size adjust
        unselectedFontSize: 10,

        selectedLabelStyle: const TextStyle(
          overflow: TextOverflow.ellipsis,
        ),

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work_outline),
            label: 'Jobs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group_outlined),
            label: 'Freelancer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.post_add_outlined),
            label: 'PostJob',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}