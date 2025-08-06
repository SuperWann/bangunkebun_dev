import 'package:bangunkebun_dev/widgets/roundedNavbar.dart';
import 'package:flutter/material.dart';

class ApiConfig {
  static const String baseUrl = 'http://192.168.1.95:7203/bangunKebun';
}

class NavBarConfig {
  static List<NavBarItem> get mainNavItems => [
    NavBarItem(
      icon: Icons.home_rounded,
      activeIcon: Icons.home_rounded,
      label: 'Home',
    ),
    NavBarItem(
      icon: Icons.shopping_bag_rounded,
      activeIcon: Icons.shopping_bag_rounded,
      label: 'Shop',
    ),
    NavBarItem(
      icon: Icons.menu_book_rounded,
      activeIcon: Icons.menu_book_rounded,
      label: 'Articles',
    ),
    NavBarItem(
      icon: Icons.people_rounded,
      activeIcon: Icons.people_rounded,
      label: 'Community',
    ),
    NavBarItem(
      icon: Icons.person_rounded,
      activeIcon: Icons.person_rounded,
      label: 'Profile',
    ),
  ];

  static const Color primaryColor = Color(0xFF007B29);
  static final Color inactiveColor = Colors.grey[600]!;
}