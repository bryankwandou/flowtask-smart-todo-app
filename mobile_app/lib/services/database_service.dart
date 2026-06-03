import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';
import '../core/constants.dart';
import '../features/tasks/models/task_model.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static Database? _database;
  
  final _taskStreamController = StreamController<List<Task>>.broadcast();

  factory DatabaseService() => _instance;

  DatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'flowtask_production.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${AppConstants.usersTable} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT UNIQUE,
        name TEXT,
        created_at TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE ${AppConstants.tasksTable} (
        id TEXT PRIMARY KEY,
        title TEXT,
        description TEXT,
        priority INTEGER,
        status TEXT,
        deadline TEXT,
        created_at TEXT,
        completed_at TEXT,
        category TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE ${AppConstants.statsTable} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT UNIQUE,
        tasks_completed INTEGER,
        focus_minutes INTEGER,
        streak INTEGER
      )
    ''');
  }

  // --- Task Operations ---

  Stream<List<Task>> getTasksStream(String userId) {
    _refreshTasks();
    return _taskStreamController.stream;
  }

  Future<void> _refreshTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(AppConstants.tasksTable, orderBy: 'created_at DESC');
    final tasks = List.generate(maps.length, (i) => Task.fromMap(maps[i]));
    _taskStreamController.add(tasks);
  }

  Future<String> createTask(Task task) async {
    final db = await database;
    final id = const Uuid().v4();
    final taskWithId = task.copyWith(id: id);
    await db.insert(AppConstants.tasksTable, taskWithId.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    _refreshTasks();
    return id;
  }

  Future<void> updateTaskStatus(String id, String status, DateTime? completedAt) async {
    final db = await database;
    await db.update(
      AppConstants.tasksTable,
      {
        'status': status,
        'completed_at': completedAt?.toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
    _refreshTasks();
  }

  Future<void> deleteTask(String id) async {
    final db = await database;
    await db.delete(AppConstants.tasksTable, where: 'id = ?', whereArgs: [id]);
    _refreshTasks();
  }

  // --- Auth & User (Local) ---
  
  Future<void> saveUserLocally(String email, String name) async {
    final db = await database;
    await db.insert(
      AppConstants.usersTable,
      {
        'email': email,
        'name': name,
        'created_at': DateTime.now().toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // --- Stats & Analytics ---

  Future<Map<String, dynamic>?> getTodayStats() async {
    final db = await database;
    final today = DateTime.now().toIso8601String().split('T')[0];
    final results = await db.query(AppConstants.statsTable, where: 'date = ?', whereArgs: [today]);
    return results.isNotEmpty ? results.first : null;
  }

  Future<void> incrementCompletedTasks() async {
    final db = await database;
    final today = DateTime.now().toIso8601String().split('T')[0];
    final stats = await getTodayStats();
    
    if (stats == null) {
      await db.insert(AppConstants.statsTable, {
        'date': today,
        'tasks_completed': 1,
        'focus_minutes': 0,
        'streak': 1, // Logic for streak would be more complex, simplified for now
      });
    } else {
      await db.update(
        AppConstants.statsTable,
        {'tasks_completed': (stats['tasks_completed'] as int) + 1},
        where: 'date = ?',
        whereArgs: [today],
      );
    }
  }

  Future<void> clearAllData() async {
    final db = await database;
    await db.delete(AppConstants.tasksTable);
    await db.delete(AppConstants.statsTable);
    await db.delete(AppConstants.usersTable);
    _refreshTasks();
  }
}
