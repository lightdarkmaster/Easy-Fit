import 'package:flutter/material.dart';
import '../db/exercise_db_helper.dart';
import '../models/exercise_model.dart';

class AddExerciseScreen extends StatefulWidget {
  final String category;

  const AddExerciseScreen({super.key, required this.category});

  @override
  State<AddExerciseScreen> createState() => _AddExerciseScreenState();
}

class _AddExerciseScreenState extends State<AddExerciseScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController setsController = TextEditingController();
  final TextEditingController repsController = TextEditingController();
  final TextEditingController restController = TextEditingController();

  void _saveExercise() async {
    if (_formKey.currentState!.validate()) {
      final exercise = Exercise(
        category: widget.category,
        exerciseName: nameController.text.trim(),
        sets: int.parse(setsController.text),
        reps: int.parse(repsController.text),
        restTime: int.parse(restController.text),
      );

      await ExerciseDBHelper.instance.insertExercise(exercise);

      Navigator.pop(context, true); // return success
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Exercise')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildField(
                controller: nameController,
                label: 'Exercise Name',
                icon: Icons.fitness_center,
              ),
              _buildField(
                controller: setsController,
                label: 'Sets',
                icon: Icons.repeat,
                keyboardType: TextInputType.number,
              ),
              _buildField(
                controller: repsController,
                label: 'Reps',
                icon: Icons.loop,
                keyboardType: TextInputType.number,
              ),
              _buildField(
                controller: restController,
                label: 'Rest Time (seconds)',
                icon: Icons.timer,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _saveExercise,
                child: const Text('Save Exercise'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: (value) =>
            value == null || value.isEmpty ? 'Required' : null,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
    );
  }
}
