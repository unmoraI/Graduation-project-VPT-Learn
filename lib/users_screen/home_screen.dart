import 'package:flutter/material.dart';
import '../theme.dart';

class HomeScreen extends StatelessWidget {
  final int currentIndex;
  final List<Widget> pages;
  final void Function(int) onTap;

  const HomeScreen({
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
        onTap: onTap,
        backgroundColor: AppColors.primaryBackground,
        selectedItemColor: AppColors.alternate,
        unselectedItemColor: AppColors.secondaryText,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Обучение',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'База знаний',
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