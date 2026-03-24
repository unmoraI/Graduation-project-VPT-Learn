import 'package:flutter/material.dart';
import '../../theme.dart';
import 'package:test1/widgets/lesson_dialog.dart';

class AdminLessonsScreen extends StatefulWidget {
  final int courseId;

  const AdminLessonsScreen({
    super.key,
    required this.courseId,
  });

  @override
  State<AdminLessonsScreen> createState() => _AdminLessonsScreenState();
}

class _AdminLessonsScreenState extends State<AdminLessonsScreen> {
  final List<Map<String, dynamic>> _lessons = [
    {'id': 1, 'title': 'Мастурбашенс', 'content': 'Описание первого урока'},
    {'id': 2, 'title': '********', 'content': null},
    {'id': 3, 'title': 'кс гошка', 'content': 'Практическое задание'},
  ];

  bool _isLoading = false;

  void _addLesson(Map<String, dynamic> lesson) {
    setState(() {
      _lessons.add({
        ...lesson,
        'courseId': widget.courseId,
      });
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Урок создан')),
    );
  }

  void _updateLesson(int index, Map<String, dynamic> updatedLesson) {
    setState(() {
      _lessons[index] = {
        ...updatedLesson,
        'courseId': widget.courseId,
      };
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Урок обновлён')),
    );
  }

  void _deleteLesson(int index) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Удалить урок?'),
        content: Text('Вы уверены, что хотите удалить "${_lessons[index]['title']}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Удалить'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() {
      _lessons.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Урок удалён')),
    );
  }

  Future<void> _refresh() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Список уроков'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refresh,
            tooltip: 'Обновить',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newLesson = await showLessonDialog(context: context);
          if (newLesson != null) _addLesson(newLesson);
        },
        backgroundColor: AppColors.alternate,
        child: const Icon(Icons.add),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_lessons.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.menu_book, size: 64, color: AppColors.secondaryText),
            const SizedBox(height: 16),
            Text(
              'Уроки не найдены',
              style: TextStyle(fontSize: 16, color: AppColors.secondaryText),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final newLesson = await showLessonDialog(context: context);
                if (newLesson != null) _addLesson(newLesson);
              },
              child: const Text('Создать первый урок'),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: _lessons.length,
      itemBuilder: (context, index) {
        final lesson = _lessons[index];
        return Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            title: Text(
              lesson['title'] as String,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: lesson['content'] != null
                ? Text(
                    lesson['content'] as String,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                : null,
            trailing: PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              onSelected: (value) async {
                if (value == 'edit') {
                  final updated = await showLessonDialog(
                    context: context,
                    lesson: lesson,
                  );
                  if (updated != null) _updateLesson(index, updated);
                } else if (value == 'delete') {
                  _deleteLesson(index);
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit, size: 20),
                      SizedBox(width: 12),
                      Text('Редактировать'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete, size: 20, color: Colors.red),
                      SizedBox(width: 12),
                      Text('Удалить', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ],
            ),
            onTap: () {
              // TODO: открыть экран упражнений для админа
            },
          ),
        );
      },
    );
  }
}