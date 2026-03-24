import 'package:flutter/material.dart';
import '../theme.dart';

class CodeExerciseScreen extends StatefulWidget {
  /// Заголовок задания
  final String title;
  /// Описание задачи
  final String description;
  /// Начальный код (шаблон)
  final String initialCode;

  const CodeExerciseScreen({
    super.key,
    required this.title,
    required this.description,
    this.initialCode = '// Напишите свой код здесь\n',
  });

  @override
  State<CodeExerciseScreen> createState() => _CodeExerciseScreenState();
}

class _CodeExerciseScreenState extends State<CodeExerciseScreen> {
  late TextEditingController _codeController;
  bool _isLoading = false;
  String _output = '';
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _codeController = TextEditingController(text: widget.initialCode);
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _runCode() async {
    final code = _codeController.text;

    setState(() {
      _isLoading = true;
      _output = '';
      _hasError = false;
    });

    // Эмуляция отправки кода на сервер
    await Future.delayed(const Duration(seconds: 1));

    // TODO: заменить на реальный API вызов
    // Пример ответа:
    final success = true; // для демо всегда успех
    final result = 'Вывод программы:\nHello, World!\n\nКод выполнен успешно.';

    setState(() {
      _isLoading = false;
      _output = result;
      _hasError = !success;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: AppColors.secondary,
      ),
      body: Column(
        children: [
          // Описание задачи
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: AppColors.secondaryBackground,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Задача',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryText,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.secondaryText,
                  ),
                ),
              ],
            ),
          ),

          // Редактор кода
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                  child: Text(
                    'Ваш код',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryText,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.secondaryText.withOpacity(0.3),
                      ),
                    ),
                    child: TextField(
                      controller: _codeController,
                      maxLines: null,
                      expands: true,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 14,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Кнопка запуска
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _runCode,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.alternate,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        'Запустить код',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ),

          // Область вывода
          Container(
            width: double.infinity,
            constraints: const BoxConstraints(minHeight: 120),
            padding: const EdgeInsets.all(16),
            color: AppColors.secondaryBackground,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Результат',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryText,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: _output.isEmpty
                      ? Text(
                          'Нажмите "Запустить код", чтобы увидеть результат',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.secondaryText,
                          ),
                        )
                      : Text(
                          _output,
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 12,
                            color: _hasError ? Colors.red : AppColors.primaryText,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}