import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  String _name = '';
  int _age = 0;
  double _height = 0.0;
  double _weight = 0.0;
  String _fitnessLevel = 'Beginner';
  List<String> _goals = [];
  String _bodyType = '';
  String _skinType = '';
  bool _isOnboarded = false;

  // Getters
  String get name => _name;
  int get age => _age;
  double get height => _height;
  double get weight => _weight;
  String get fitnessLevel => _fitnessLevel;
  List<String> get goals => _goals;
  String get bodyType => _bodyType;
  String get skinType => _skinType;
  bool get isOnboarded => _isOnboarded;

  // Setters
  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setAge(int age) {
    _age = age;
    notifyListeners();
  }

  void setHeight(double height) {
    _height = height;
    notifyListeners();
  }

  void setWeight(double weight) {
    _weight = weight;
    notifyListeners();
  }

  void setFitnessLevel(String level) {
    _fitnessLevel = level;
    notifyListeners();
  }

  void setGoals(List<String> goals) {
    _goals = goals;
    notifyListeners();
  }

  void setBodyType(String type) {
    _bodyType = type;
    notifyListeners();
  }

  void setSkinType(String type) {
    _skinType = type;
    notifyListeners();
  }

  void completeOnboarding() {
    _isOnboarded = true;
    notifyListeners();
  }
}