import 'package:flutter/material.dart';
import '../models/exam.dart';

class ExamCard extends StatelessWidget {
  final Exam exam;
  final VoidCallback onTap;

  const ExamCard({super.key, required this.exam, required this.onTap});

  @override
  Widget build(BuildContext context) {
    bool isPast = exam.dateTime.isBefore(DateTime.now());
    Color cardColor = isPast ? Colors.green[100]! : Colors.red[100]!;

    return Card(
      color: cardColor,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: ListTile(
        leading: const Icon(Icons.school, color: Colors.blue),
        title: Text(exam.subject, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16),
                const SizedBox(width: 4),
                Text('${exam.dateTime.day}.${exam.dateTime.month}.${exam.dateTime.year}'),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.access_time, size: 16),
                const SizedBox(width: 4),
                Text('${exam.dateTime.hour}:${exam.dateTime.minute.toString().padLeft(2, '0')}'),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.room, size: 16),
                const SizedBox(width: 4),
                Text(exam.rooms.join(", ")),
              ],
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
