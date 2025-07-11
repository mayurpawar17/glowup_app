import 'package:flutter/foundation.dart';

class Workout {
  String id;
  String name;
  String type;
  int duration;
  List<Exercise> exercises;
  DateTime date;

  Workout({
    required this.id,
    required this.name,
    required this.type,
    required this.duration,
    required this.exercises,
    required this.date,
  });
}

class Exercise {
  String name;
  int sets;
  int reps;
  double weight;

  Exercise({
    required this.name,
    required this.sets,
    required this.reps,
    this.weight = 0.0,
  });
}

class FitnessProvider with ChangeNotifier {
  final List<Workout> _workouts = [];
  int _caloriesConsumed = 0;
  final int _caloriesTarget = 2000;
  double _waterIntake = 0.0;
  final double _waterTarget = 8.0;

  List<Workout> get workouts => _workouts;
  int get caloriesConsumed => _caloriesConsumed;
  int get caloriesTarget => _caloriesTarget;
  double get waterIntake => _waterIntake;
  double get waterTarget => _waterTarget;

  void addWorkout(Workout workout) {
    _workouts.add(workout);
    notifyListeners();
  }

  void updateCalories(int calories) {
    _caloriesConsumed = calories;
    notifyListeners();
  }

  void updateWaterIntake(double glasses) {
    _waterIntake = glasses;
    notifyListeners();
  }

  void addWater(double glasses) {
    _waterIntake += glasses;
    notifyListeners();
  }
}