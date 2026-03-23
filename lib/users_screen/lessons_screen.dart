import 'package:flutter/material.dart';

// Локальная модель урока для UI
class LessonData {
  final int id;
  final String title;
  final String content;

  const LessonData({
    required this.id,
    required this.title,
    required this.content,
  });
}

class LessonsScreen extends StatelessWidget {
  final List<LessonData> lessons;
  final bool isLoading;
  final String? errorMessage;
  final void Function(int lessonId) onLessonTap;

  const LessonsScreen({
    super.key,
    required this.lessons,
    required this.isLoading,
    this.errorMessage,
    required this.onLessonTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Уроки курса')),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(child: Text(errorMessage!));
    }

    if (lessons.isEmpty) {
      return const Center(child: Text('Уроки не найдены'));
    }

    return ListView.builder(
      itemCount: lessons.length,
      itemBuilder: (context, index) {
        final lesson = lessons[index];
        return Card(
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: ListTile(
            title: Text(lesson.title),
            subtitle: Text(
              lesson.content,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () => onLessonTap(lesson.id),
          ),
        );
      },
    );
  }
}