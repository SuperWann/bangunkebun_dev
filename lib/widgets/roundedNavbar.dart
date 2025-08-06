import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NavBarItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  NavBarItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}

class FloatingNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<NavBarItem> items;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? backgroundColor;
  final double? bottomMargin;

  const FloatingNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    this.activeColor,
    this.inactiveColor,
    this.backgroundColor,
    this.bottomMargin,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 20.w,
      right: 20.w,
      bottom: bottomMargin ?? 40.h, // Gunakan bottomMargin jika ada, default 40.h
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 14.h),
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 2,
              spreadRadius: 1,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: items.asMap().entries.map((entry) {
            int index = entry.key;
            NavBarItem item = entry.value;
            bool isSelected = currentIndex == index;
            
            return GestureDetector(
              onTap: () => onTap(index),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? (activeColor ?? Color(0xFF007B29))
                      : Colors.grey[100],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isSelected ? item.activeIcon : item.icon,
                  color: isSelected
                      ? Colors.white
                      : (inactiveColor ?? Colors.grey[600]),
                  size: 30,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}