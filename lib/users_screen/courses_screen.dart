import 'package:flutter/material.dart';
import '../theme.dart';

// Локальная модель данных для UI, не зависит от бэкенда
class CourseData {
  final int id;
  final String title;
  final String description;
  final double progress;

  const CourseData({
    required this.id,
    required this.title,
    required this.description,
    required this.progress,
  });
}

class LearningTab extends StatelessWidget {
  final List<CourseData> courses;
  final bool isLoading;
  final VoidCallback onRefresh;
  final void Function(int courseId) onCourseTap;

  const LearningTab({
    super.key,
    required this.courses,
    required this.isLoading,
    required this.onRefresh,
    required this.onCourseTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Обучение'),
        backgroundColor: AppColors.secondary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: onRefresh,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : courses.isEmpty
              ? const Center(child: Text('Курсы не найдены'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    final course = courses[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        title: Text(
                          course.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            Text(course.description),
                            const SizedBox(height: 12),
                            LinearProgressIndicator(
                              value: course.progress,
                              backgroundColor: AppColors.alternate,
                              color: AppColors.completed,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${(course.progress * 100).toInt()}% завершено',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.completed,
                              ),
                            ),
                          ],
                        ),
                        onTap: () => onCourseTap(course.id),
                      ),
                    );
                  },
                ),
    );
  }
}