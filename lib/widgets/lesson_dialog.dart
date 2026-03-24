import 'package:flutter/material.dart';
import '../../theme.dart';

Future<Map<String, dynamic>?> showLessonDialog({
  required BuildContext context,
  Map<String, dynamic>? lesson,
}) async {
  final isEditing = lesson != null;
  final titleController = TextEditingController(text: lesson?['title'] ?? '');
  final contentController = TextEditingController(text: lesson?['content'] ?? '');

  return showDialog<Map<String, dynamic>>(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: Text(isEditing ? 'Редактировать урок' : 'Новый урок'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Название урока',
                border: OutlineInputBorder(),
              ),
              autofocus: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(
                labelText: 'Содержание',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Отмена'),
        ),
        ElevatedButton(
          onPressed: () {
            final title = titleController.text.trim();
            if (title.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Введите название урока')),
              );
              return;
            }

            Navigator.pop(
              context,
              {
                'id': lesson?['id'] ?? DateTime.now().millisecondsSinceEpoch,
                'title': title,
                'content': contentController.text.trim().isEmpty
                    ? null
                    : contentController.text.trim(),
              },
            );
          },
          child: Text(isEditing ? 'Сохранить' : 'Создать'),
        ),
      ],
    ),
  );
}