import 'package:flutter/material.dart';

class UserAdministration extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordHashController;
  final TextEditingController roleController;
  final TextEditingController userUuidController;
  final bool isLoading;
  final bool isSaving;
  final VoidCallback onSave;

  const UserAdministration({
    super.key,
    required this.emailController,
    required this.passwordHashController,
    required this.roleController,
    required this.userUuidController,
    required this.isLoading,
    required this.isSaving,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Данные пользователя'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(labelText: 'Новый email'),
                    ),
                    TextFormField(
                      controller: passwordHashController,
                      decoration: const InputDecoration(
                        labelText: 'Новый пароль',
                      ),
                    ),
                    TextFormField(
                      controller: roleController,
                      decoration: const InputDecoration(labelText: 'Роль'),
                    ),
                    TextFormField(
                      controller: userUuidController,
                      decoration: const InputDecoration(labelText: 'User UUID'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: isSaving ? null : onSave,
                      child: Text(isSaving ? 'Изменяем...' : 'Изменить'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}