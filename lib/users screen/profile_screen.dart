// Замените содержимое profile_screen.dart на этот код

import 'package:flutter/material.dart';
import 'auth_screen.dart';
import '../theme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // ЗАГЛУШКА: данные из БД
  final String userEmail = "user@example.com";
  String userPassword = "••••••••";
  String _originalPassword = "password123";

  bool _isEditing = false;
  final TextEditingController _passwordController = TextEditingController();

  void _startEdit() {
    setState(() {
      _isEditing = true;
      _passwordController.text = _originalPassword;
    });
  }

  void _savePassword() {
    setState(() {
      _originalPassword = _passwordController.text;
      userPassword = '••••••••';
      _isEditing = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Пароль обновлён (заглушка)')),
    );
  }

  void _cancelEdit() {
    setState(() {
      _isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white12,
              child: Icon(Icons.person, size: 60, color: AppColors.secondaryText),
            ),
            const SizedBox(height: 16),
            Text(
              'name',
              style: TextStyle(
                fontSize: 22,
                color: AppColors.primaryText,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              userEmail,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.secondaryText.withAlpha(153),
              ),
            ),
            const SizedBox(height: 32),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Settings',
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.primaryText.withAlpha(204),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildProfileSettingsCard(),
            _buildSettingsItem(
              icon: Icons.logout,
              title: 'Log out of account',
              trailingText: 'Log Out?',
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const AuthPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSettingsCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.secondaryBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.person_outline, size: 20, color: AppColors.secondaryText),
                const SizedBox(width: 8),
                Text(
                  'Profile Settings',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryText,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Email (только чтение)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.primaryBackground,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.email, size: 18, color: AppColors.secondaryText),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Email', style: TextStyle(fontSize: 11, color: AppColors.secondaryText)),
                        Text(userEmail, style: TextStyle(fontSize: 14, color: AppColors.primaryText)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Password с редактированием
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.primaryBackground,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.lock, size: 18, color: AppColors.secondaryText),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Password', style: TextStyle(fontSize: 11, color: AppColors.secondaryText)),
                            if (!_isEditing)
                              Text(userPassword, style: TextStyle(fontSize: 14, color: AppColors.primaryText))
                            else
                              TextField(
                                controller: _passwordController,
                                obscureText: true,
                                style: TextStyle(fontSize: 14, color: AppColors.primaryText),
                                decoration: const InputDecoration(
                                  isDense: true,
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ),
                          ],
                        ),
                      ),
                      if (!_isEditing)
                        TextButton(
                          onPressed: _startEdit,
                          child: Text('Изменить', style: TextStyle(color: AppColors.alternate)),
                        )
                      else
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextButton(
                              onPressed: _cancelEdit,
                              child: const Text('Отмена', style: TextStyle(color: Colors.red)),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: _savePassword,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.alternate,
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                              ),
                              child: const Text('Сохранить', style: TextStyle(color: Colors.black)),
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    String? trailingText,
    IconData? trailingIcon,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(icon, color: AppColors.secondaryText),
          title: Text(title, style: TextStyle(color: AppColors.primaryText)),
          trailing: trailingIcon != null
              ? Icon(trailingIcon, color: AppColors.secondaryText, size: 20)
              : (trailingText != null
                  ? Text(trailingText, style: TextStyle(color: AppColors.secondaryText))
                  : null),
          onTap: onTap,
        ),
        const Divider(color: Colors.white12, height: 1),
      ],
    );
  }
}