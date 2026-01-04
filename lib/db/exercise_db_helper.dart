import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/exercise_model.dart';

class ExerciseDBHelper {
  static final ExerciseDBHelper instance = ExerciseDBHelper._internal();
  static Database? _database;

  ExerciseDBHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'exercise.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE exercises (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            category TEXT,
            exercise_name TEXT,
            sets INTEGER,
            reps INTEGER,
            rest_time INTEGER
          )
        ''');
      },
    );
  }

  // READ exercises by category
  Future<List<Exercise>> getExercisesByCategory(String category) async {
    final db = await database;
    final result = await db.query(
      'exercises',
      where: 'category = ?',
      whereArgs: [category],
    );
    return result.map((e) => Exercise.fromMap(e)).toList();
  }

  // OPTIONAL: Add exercise
  Future<int> insertExercise(Exercise exercise) async {
    final db = await database;
    return await db.insert('exercises', exercise.toMap());
  }
}
