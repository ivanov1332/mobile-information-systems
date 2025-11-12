import 'package:flutter/material.dart';
import '../models/exam.dart';
import '../widgets/exam_card.dart';
import 'details_screen.dart';

class ExamListScreen extends StatelessWidget {
  const ExamListScreen({super.key});

  List<Exam> getExams() {
    final now = DateTime.now();
    return List.generate(10, (index) {
      return Exam(
        subject: 'Предмет ${index + 1}',
        dateTime: now.add(Duration(days: index * 3, hours: index * 2)),
        rooms: ['A${index + 1}', 'B${index + 2}'],
        isPassed: index < 3,
      );
    })
      ..sort((a, b) => a.dateTime.compareTo(b.dateTime));
  }

  @override
  Widget build(BuildContext context) {
    final exams = getExams();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Распоред за испити - 223130'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: exams.length,
        itemBuilder: (context, index) {
          final exam = exams[index];
          return ExamCard(
            exam: exam,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ExamDetailScreen(exam: exam),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            'Вкупно испити: ${exams.length}',
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
