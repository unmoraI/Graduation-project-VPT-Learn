// Замените содержимое information_base_screen.dart на этот код

import 'package:flutter/material.dart';
import '../theme.dart';

class KnowledgeBasePage extends StatelessWidget {
  const KnowledgeBasePage({super.key});

  final List<Map<String, dynamic>> languages = const [
    {
      'name': 'Dart',
      'description': 'Dart — язык программирования, оптимизированный для создания пользовательских интерфейсов. Разработан Google. Используется во Flutter.',
      'features': '• Кроссплатформенность\n• Асинхронность (Future/Stream)\n• Null safety\n• JIT и AOT компиляция',
      'example': 'void main() {\n  print("Hello, Dart!");\n}',
    },
    {
      'name': 'Python',
      'description': 'Python — высокоуровневый язык с простым синтаксисом. Широко используется в науке, AI, вебе.',
      'features': '• Динамическая типизация\n• Огромное количество библиотек\n• Интерпретируемость\n• Поддержка ООП и функционального стиля',
      'example': 'print("Hello, Python!")',
    },
    {
      'name': 'JavaScript',
      'description': 'JavaScript — язык для веб-разработки. Работает в браузерах и на сервере (Node.js).',
      'features': '• Событийно-ориентированный\n• Прототипное наследование\n• Асинхронность (Promise/async)\n• NPM экосистема',
      'example': 'console.log("Hello, JS!");',
    },
    {
      'name': 'C#',
      'description': 'C# — современный объектно-ориентированный язык от Microsoft. Используется в Unity, .NET.',
      'features': '• Строгая типизация\n• LINQ\n• Асинхронность (async/await)\n• Управление памятью (GC)',
      'example': 'Console.WriteLine("Hello, C#!");',
    },
    {
      'name': 'Java',
      'description': 'Java — классический язык для корпоративных приложений и Android.',
      'features': '• JVM (кроссплатформенность)\n• Многопоточность\n• Богатая экосистема\n• Строгая типизация',
      'example': 'System.out.println("Hello, Java!");',
    },
    {
      'name': 'C++',
      'description': 'C++ — язык для системного программирования, игр, высокопроизводительных приложений.',
      'features': '• Ручное управление памятью\n• Множественное наследование\n• Шаблоны (templates)\n• RAII',
      'example': 'std::cout << "Hello, C++!" << std::endl;',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('База знаний'),
        backgroundColor: AppColors.secondary,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: languages.length,
        itemBuilder: (context, index) {
          final language = languages[index];
          return Card(
            color: AppColors.secondary.withValues(alpha: 0.8),
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text(
                language['name']!,
                style: const TextStyle(fontSize: 20, color: Colors.white70),
              ),
              trailing: const Icon(Icons.chevron_right, color: Colors.white54),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LanguageDetailScreen(
                      name: language['name']!,
                      description: language['description']!,
                      features: language['features']!,
                      example: language['example']!,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class LanguageDetailScreen extends StatelessWidget {
  final String name;
  final String description;
  final String features;
  final String example;

  const LanguageDetailScreen({
    super.key,
    required this.name,
    required this.description,
    required this.features,
    required this.example,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        title: Text(name),
        backgroundColor: AppColors.secondary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero анимация для названия
            Hero(
              tag: 'language_$name',
              child: Material(
                color: Colors.transparent,
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: AppColors.alternate,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // Описание
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.secondary.withAlpha(40), AppColors.primary.withAlpha(30)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.alternate.withAlpha(40)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline, color: AppColors.alternate, size: 22),
                      const SizedBox(width: 10),
                      Text(
                        'Описание',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryText,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.primaryText.withAlpha(220),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Особенности
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.secondaryBackground,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.secondaryText.withAlpha(40)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.stars, color: AppColors.alternate, size: 22),
                      const SizedBox(width: 10),
                      Text(
                        'Ключевые особенности',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryText,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    features,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.secondaryText,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Пример кода
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.primaryBackground,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.alternate.withAlpha(60)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.code, color: AppColors.alternate, size: 22),
                      const SizedBox(width: 10),
                      Text(
                        'Пример кода',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryText,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: SelectableText(
                      example,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 14,
                        color: AppColors.alternate,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Кнопка назад
            Center(
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Назад к списку'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.alternate,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}