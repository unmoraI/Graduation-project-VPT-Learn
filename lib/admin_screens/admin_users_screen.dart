import 'package:flutter/material.dart';
import '/theme.dart'; // предполагается, что файл темы существует

// Модель данных (только описание, без логики)
class AdminUser {
  final String userUuid;
  final String email;
  final String role;

  AdminUser({
    required this.userUuid,
    required this.email,
    required this.role,
  });
}

// Чистый UI-виджет
class AdminUsers extends StatelessWidget {
  final List<AdminUser> users;
  final bool isLoading;
  final VoidCallback onRefresh;           // действие при обновлении
  final void Function(AdminUser user) onUserTap; // действие при нажатии на пользователя

  const AdminUsers({
    super.key,
    required this.users,
    required this.isLoading,
    required this.onRefresh,
    required this.onUserTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Список пользователей'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: onRefresh,
            tooltip: 'Обновить',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => onRefresh(),
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (users.isEmpty) {
      return Center(
        child: Text(
          'Пользователи не найдены',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.secondaryText,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        final email = user.email;
        return Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.secondaryText,
              child: Text(
                email[0].toUpperCase(),
                style: const TextStyle(
                  color: AppColors.secondary,
                ),
              ),
            ),
            title: Text(
              email,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            onTap: () => onUserTap(user),
          ),
        );
      },
    );
  }
}