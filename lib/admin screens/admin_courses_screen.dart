import 'package:flutter/material.dart';
import 'admin_lessons_screen.dart';
import 'package:test1/widgets/course_dialog_screen.dart';
import '../../theme.dart';

class AdminCoursesScreen extends StatefulWidget {
  const AdminCoursesScreen({super.key});

  @override
  State<AdminCoursesScreen> createState() => _AdminCoursesScreenState();
}

class _AdminCoursesScreenState extends State<AdminCoursesScreen> {
  final List<Map<String, dynamic>> _courses = [
    {'course_id': 1, 'title': 'Курс 1', 'description': 'извинись.'},
    {'course_id': 2, 'title': 'Курс 2', 'description': null},
    {'course_id': 3, 'title': 'Курс 666', 'description': 'извинись.'},
  ];

  bool _isLoading = false;

  void _addCourse(Map<String, dynamic> course) {
    setState(() {
      _courses.add(course);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Курс создан')),
    );
  }

  void _updateCourse(int index, Map<String, dynamic> updatedCourse) {
    setState(() {
      _courses[index] = updatedCourse;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Курс обновлён')),
    );
  }

  void _deleteCourse(int index) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Удалить курс?'),
        content: Text('Вы уверены, что хотите удалить "${_courses[index]['title']}"?'),
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
      _courses.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Курс удалён')),
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
        title: const Text('Список курсов'),
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
          final newCourse = await showCourseDialog(context: context);
          if (newCourse != null) _addCourse(newCourse);
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

    if (_courses.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.menu_book, size: 64, color: AppColors.secondaryText),
            const SizedBox(height: 16),
            Text(
              'Курсы не найдены',
              style: TextStyle(fontSize: 16, color: AppColors.secondaryText),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final newCourse = await showCourseDialog(context: context);
                if (newCourse != null) _addCourse(newCourse);
              },
              child: const Text('Создать первый курс'),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: _courses.length,
      itemBuilder: (context, index) {
        final course = _courses[index];
        return Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: ListTile(
            title: Text(
              course['title'] as String,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: course['description'] != null
                ? Text(
                    course['description'] as String,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                : null,
            trailing: PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              onSelected: (value) async {
                if (value == 'edit') {
                  final updated = await showCourseDialog(
                    context: context,
                    course: course,
                  );
                  if (updated != null) _updateCourse(index, updated);
                } else if (value == 'delete') {
                  _deleteCourse(index);
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdminLessonsScreen(
                    courseId: course['course_id'] as int,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}