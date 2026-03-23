import 'package:flutter/material.dart';
import '../theme.dart';

class AdminScreen extends StatelessWidget {
  final int currentIndex;
  final List<Widget> pages;
  final void Function(int) onTap;

  const AdminScreen({
    super.key,
    required this.currentIndex,
    required this.pages,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor: AppColors.primaryBackground,
        selectedItemColor: AppColors.alternate,
        unselectedItemColor: AppColors.secondaryText,
        onTap: onTap,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Пользователи',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Курсы',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }
}