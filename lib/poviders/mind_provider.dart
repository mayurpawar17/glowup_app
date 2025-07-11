import 'package:flutter/foundation.dart';

class JournalEntry {
  String id;
  String content;
  DateTime date;
  int mood;
  List<String> tags;

  JournalEntry({
    required this.id,
    required this.content,
    required this.date,
    required this.mood,
    required this.tags,
  });
}

class MindProvider with ChangeNotifier {
  List<JournalEntry> _journalEntries = [];
  int _currentMood = 5;
  List<String> _completedChallenges = [];
  int _meditationStreak = 0;

  List<JournalEntry> get journalEntries => _journalEntries;
  int get currentMood => _currentMood;
  List<String> get completedChallenges => _completedChallenges;
  int get meditationStreak => _meditationStreak;

  void addJournalEntry(JournalEntry entry) {
    _journalEntries.add(entry);
    notifyListeners();
  }

  void setMood(int mood) {
    _currentMood = mood;
    notifyListeners();
  }

  void completeChallenge(String challenge) {
    _completedChallenges.add(challenge);
    notifyListeners();
  }

  void incrementMeditationStreak() {
    _meditationStreak++;
    notifyListeners();
  }
}