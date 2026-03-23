import 'package:flutter/material.dart';

// Локальная модель для отображения упражнения
class ExerciseData {
  final String taskDescription;
  final List<String> options;

  const ExerciseData({
    required this.taskDescription,
    required this.options,
  });
}

class ExercisesScreen extends StatelessWidget {
  final bool isLoading;
  final String? errorMessage;
  final bool showResult;
  final int score;
  final int totalExercises;
  final int currentIndex;
  final ExerciseData? currentExercise;
  final String? selectedAnswer;
  final VoidCallback onRestart;
  final void Function(String answer) onAnswerSelected;
  final VoidCallback onSubmit;

  const ExercisesScreen({
    super.key,
    required this.isLoading,
    this.errorMessage,
    required this.showResult,
    required this.score,
    required this.totalExercises,
    required this.currentIndex,
    this.currentExercise,
    this.selectedAnswer,
    required this.onRestart,
    required this.onAnswerSelected,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    // Состояние загрузки
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Ошибка загрузки
    if (errorMessage != null) {
      return Scaffold(
        body: Center(child: Text(errorMessage!)),
      );
    }

    // Нет упражнений
    if (totalExercises == 0) {
      return const Scaffold(
        body: Center(child: Text('Задания не найдены')),
      );
    }

    // Показ результата
    if (showResult) {
      return Scaffold(
        appBar: AppBar(title: const Text('Результат теста')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Вы набрали $score из $totalExercises',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onRestart,
                child: const Text('Пройти заново'),
              ),
            ],
          ),
        ),
      );
    }

    // Если currentExercise отсутствует (не должно быть, но на всякий случай)
    if (currentExercise == null) {
      return const Scaffold(
        body: Center(child: Text('Данные упражнения недоступны')),
      );
    }

    // Теперь мы уверены, что currentExercise не null
    final exercise = currentExercise!;

    return Scaffold(
      appBar: AppBar(
        title: Text('Вопрос ${currentIndex + 1} из $totalExercises'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              exercise.taskDescription,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 24),
            ...exercise.options.map(
              (option) => RadioListTile<String>(
                title: Text(option),
                value: option,
                groupValue: selectedAnswer,
                onChanged: (value) {
                  if (value != null) {
                    onAnswerSelected(value);
                  }
                },
              ),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: selectedAnswer == null ? null : onSubmit,
                child: Text(
                  currentIndex + 1 == totalExercises ? 'Завершить' : 'Далее',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}