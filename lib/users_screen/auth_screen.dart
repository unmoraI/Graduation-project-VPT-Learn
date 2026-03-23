import 'package:flutter/material.dart';
import '../theme.dart';

class AuthPage extends StatelessWidget {
  final TabController tabController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool passwordObscured;
  final bool confirmPasswordObscured;
  final VoidCallback onTogglePasswordObscure;
  final VoidCallback onToggleConfirmPasswordObscure;
  final VoidCallback onCreateAccount;
  final VoidCallback onLogin;

  const AuthPage({
    super.key,
    required this.tabController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.passwordObscured,
    required this.confirmPasswordObscured,
    required this.onTogglePasswordObscure,
    required this.onToggleConfirmPasswordObscure,
    required this.onCreateAccount,
    required this.onLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: SizedBox(
            width: 380,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 24),
                CircleAvatar(
                  radius: 48,
                  backgroundColor: AppColors.secondaryBackground,
                  child: const Icon(Icons.book, size: 48, color: Colors.white),
                ),
                const SizedBox(height: 14),
                const Text(
                  "VPTLearn",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: AppColors.secondaryText,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 18),
                TabBar(
                  controller: tabController,
                  tabs: const [
                    Tab(text: "Создать аккаунт"),
                    Tab(text: "Войти"),
                  ],
                  indicatorColor: AppColors.alternate,
                  labelColor: AppColors.alternate,
                  unselectedLabelColor: AppColors.alternate,
                ),
                const SizedBox(height: 18),
                SizedBox(
                  height: 400,
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      _buildCreateAccount(),
                      _buildLogin(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCreateAccount() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Создать аккаунт",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.secondaryText,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "Заполните форму ниже, чтобы начать.",
          style: TextStyle(fontSize: 14, color: AppColors.secondaryText),
        ),
        const SizedBox(height: 24),
        _buildInputField(
          label: "Email",
          controller: emailController,
        ),
        const SizedBox(height: 20),
        _buildInputField(
          label: "Пароль",
          isPassword: true,
          controller: passwordController,
          obscureText: passwordObscured,
          onToggleObscure: onTogglePasswordObscure,
        ),
        const SizedBox(height: 20),
        _buildInputField(
          label: "Подтверждение пароля",
          isPassword: true,
          controller: confirmPasswordController,
          obscureText: confirmPasswordObscured,
          onToggleObscure: onToggleConfirmPasswordObscure,
        ),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            onPressed: onCreateAccount,
            child: const Text(
              "Зарегистрироваться",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildLogin() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Войти",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryText,
          ),
        ),
        const SizedBox(height: 24),
        _buildInputField(
          label: "Email",
          controller: emailController,
        ),
        const SizedBox(height: 20),
        _buildInputField(
          label: "Пароль",
          isPassword: true,
          controller: passwordController,
          obscureText: passwordObscured,
          onToggleObscure: onTogglePasswordObscure,
        ),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            onPressed: onLogin,
            child: const Text(
              "Войти",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryText,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInputField({
    required String label,
    bool isPassword = false,
    TextEditingController? controller,
    bool obscureText = false,
    VoidCallback? onToggleObscure,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword ? obscureText : false,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: AppColors.secondaryBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.secondaryText,
                ),
                onPressed: onToggleObscure,
              )
            : null,
        labelStyle: TextStyle(color: AppColors.secondaryText),
      ),
      style: TextStyle(color: AppColors.primaryText),
    );
  }
}