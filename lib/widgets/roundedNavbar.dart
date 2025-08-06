import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NavbarItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  NavbarItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}

class FloatingNavbar ({
  super.key,
  required this.currentIndex,
  required this.onTap,
  required this.items,
  this.activeColor,
  this,inactiveColor,
  this.backgroundColor,
  this.bottomMargin,
});

@override


