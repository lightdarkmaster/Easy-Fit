import 'package:easyfit/screens/add_exercise_screen.dart';
import 'package:flutter/material.dart';
import '../db/exercise_db_helper.dart';
import '../models/exercise_model.dart';

class WorkoutDetailScreen extends StatelessWidget {
  final String category;

  const WorkoutDetailScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(category)),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddExerciseScreen(category: category),
            ),
          );

          if (result == true) {
            // refresh screen
            (context as Element).markNeedsBuild();
          }
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<Exercise>>(
        future: ExerciseDBHelper.instance.getExercisesByCategory(category),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Empty state UI
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.inbox, size: 64, color: Colors.grey),
                  SizedBox(height: 12),
                  Text('No exercises added yet'),
                ],
              ),
            );
          }

          final exercises = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: exercises.length,
            itemBuilder: (context, index) {
              final ex = exercises[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: ListTile(
                  title: Text(ex.exerciseName),
                  subtitle: Text(
                    '${ex.sets} sets • ${ex.reps} reps • ${ex.restTime}s rest',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
