import 'package:flutter/material.dart';
import '../../theme.dart';

Future<Map<String, dynamic>?> showCourseDialog({
  required BuildContext context,
  Map<String, dynamic>? course,
}) async {
  final isEditing = course != null;
  final titleController = TextEditingController(text: course?['title'] ?? '');
  final descriptionController =
      TextEditingController(text: course?['description'] ?? '');

  return showDialog<Map<String, dynamic>>(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: Text(isEditing ? 'Редактировать курс' : 'Новый курс'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Название курса',
                border: OutlineInputBorder(),
              ),
              autofocus: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Описание',
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
                const SnackBar(content: Text('Введите название курса')),
              );
              return;
            }

            Navigator.pop(
              context,
              {
                'course_id': course?['course_id'] ?? DateTime.now().millisecondsSinceEpoch,
                'title': title,
                'description': descriptionController.text.trim().isEmpty ? null : descriptionController.text.trim(),
              },
            );
          },
          child: Text(isEditing ? 'Сохранить' : 'Создать'),
        ),
      ],
    ),
  );
}