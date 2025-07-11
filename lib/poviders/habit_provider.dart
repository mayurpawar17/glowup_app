import 'package:flutter/foundation.dart';

class Habit {
  String id;
  String name;
  String category;
  bool isCompleted;
  DateTime date;
  int streak;

  Habit({
    required this.id,
    required this.name,
    required this.category,
    this.isCompleted = false,
    required this.date,
    this.streak = 0,
  });
}

class HabitProvider with ChangeNotifier {
  List<Habit> _habits = [];
  int _dailyScore = 0;
  int _currentStreak = 0;

  List<Habit> get habits => _habits;

  int get dailyScore => _dailyScore;

  int get currentStreak => _currentStreak;

  void addHabit(Habit habit) {
    _habits.add(habit);
    notifyListeners();
  }

  void toggleHabit(String id) {
    final habit = _habits.firstWhere((h) => h.id == id);
    habit.isCompleted = !habit.isCompleted;
    _updateDailyScore();
    notifyListeners();
  }

  void _updateDailyScore() {
    final completedCount = _habits.where((h) => h.isCompleted).length;
    _dailyScore =
        _habits.isEmpty ? 0 : (completedCount * 100 / _habits.length).round();
  }

  void initializeDefaultHabits() {
    _habits = [
      Habit(
        id: '1',
        name: 'Morning Skincare',
        category: 'Grooming',
        date: DateTime.now(),
      ),
      Habit(
        id: '2',
        name: 'Workout',
        category: 'Fitness',
        date: DateTime.now(),
      ),
      Habit(
        id: '3',
        name: 'Drink 8 Glasses Water',
        category: 'Health',
        date: DateTime.now(),
      ),
      Habit(
        id: '4',
        name: 'Evening Skincare',
        category: 'Grooming',
        date: DateTime.now(),
      ),
      Habit(
        id: '5',
        name: 'Daily Journal',
        category: 'Mental',
        date: DateTime.now(),
      ),
    ];
    notifyListeners();
  }
}
