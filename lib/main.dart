import 'package:flutter/material.dart';
import 'users_screen/auth_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VPT Learn',
      theme: ThemeData.dark(),
      home: const AuthPageMock(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Заглушка-контейнер, чтобы передать все обязательные параметры в AuthPage
class AuthPageMock extends StatefulWidget {
  const AuthPageMock({super.key});

  @override
  State<AuthPageMock> createState() => _AuthPageMockState();
}

class _AuthPageMockState extends State<AuthPageMock> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirm = TextEditingController();
  bool _passObscure = true;
  bool _confirmObscure = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  void _mockCreate() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Регистрация (демо)')),
    );
  }

  void _mockLogin() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Вход (демо)')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthPage(
      tabController: _tabController,
      emailController: _email,
      passwordController: _password,
      confirmPasswordController: _confirm,
      passwordObscured: _passObscure,
      confirmPasswordObscured: _confirmObscure,
      onTogglePasswordObscure: () => setState(() => _passObscure = !_passObscure),
      onToggleConfirmPasswordObscure: () => setState(() => _confirmObscure = !_confirmObscure),
      onCreateAccount: _mockCreate,
      onLogin: _mockLogin,
    );
  }
}