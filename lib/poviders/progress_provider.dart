import 'package:flutter/foundation.dart';

class ProgressPhoto {
  String id;
  String imagePath;
  DateTime date;
  String category;
  String notes;

  ProgressPhoto({
    required this.id,
    required this.imagePath,
    required this.date,
    required this.category,
    required this.notes,
  });
}

class ProgressProvider with ChangeNotifier {
  List<ProgressPhoto> _progressPhotos = [];
  double _currentWeight = 0.0;
  List<double> _weightHistory = [];
  Map<String, int> _measurements = {};

  List<ProgressPhoto> get progressPhotos => _progressPhotos;
  double get currentWeight => _currentWeight;
  List<double> get weightHistory => _weightHistory;
  Map<String, int> get measurements => _measurements;

  void addProgressPhoto(ProgressPhoto photo) {
    _progressPhotos.add(photo);
    notifyListeners();
  }

  void updateWeight(double weight) {
    _currentWeight = weight;
    _weightHistory.add(weight);
    notifyListeners();
  }

  void updateMeasurement(String part, int measurement) {
    _measurements[part] = measurement;
    notifyListeners();
  }
}