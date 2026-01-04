class Exercise {
  final int? id;
  final String category;
  final String exerciseName;
  final int sets;
  final int reps;
  final int restTime;

  Exercise({
    this.id,
    required this.category,
    required this.exerciseName,
    required this.sets,
    required this.reps,
    required this.restTime,
  });

  // Convert object to Map for SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'exercise_name': exerciseName,
      'sets': sets,
      'reps': reps,
      'rest_time': restTime,
    };
  }

  // Convert Map to object
  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      id: map['id'],
      category: map['category'],
      exerciseName: map['exercise_name'],
      sets: map['sets'],
      reps: map['reps'],
      restTime: map['rest_time'],
    );
  }
}
