import 'package:flutter/material.dart';
import 'package:glowup_app/poviders/mind_provider.dart';
import 'package:provider/provider.dart';

class MindPage extends StatelessWidget {
  final TextEditingController _journalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<MindProvider>(
      builder: (context, mindProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Mental Wellness'),
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMoodTracker(mindProvider),
                SizedBox(height: 20),
                _buildJournalSection(context, mindProvider),
                SizedBox(height: 20),
                _buildChallengesSection(mindProvider),
                SizedBox(height: 20),
                _buildMindfulnessSection(mindProvider),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMoodTracker(MindProvider mindProvider) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How are you feeling today?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(5, (index) {
                  final mood = index + 1;
                  final emojis = ['😢', '😕', '😐', '😊', '😄'];
                  return GestureDetector(
                    onTap: () => mindProvider.setMood(mood),
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: mindProvider.currentMood == mood
                            ? Colors.orange.withOpacity(0.3)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        emojis[index],
                        style: TextStyle(fontSize: 32),
                      ),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Current mood: ${mindProvider.currentMood}/5',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJournalSection(BuildContext context, MindProvider mindProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Daily Journal',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: _journalController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'What\'s on your mind today?',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${mindProvider.journalEntries.length} entries'),
                    ElevatedButton(
                      onPressed: () => _saveJournalEntry(context, mindProvider),
                      child: Text('Save Entry'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChallengesSection(MindProvider mindProvider) {
    final challenges = [
      'Start a conversation with a stranger',
      'Give someone a genuine compliment',
      'Practice power posing for 2 minutes',
      'Share an opinion in a group setting',
      'Take on a leadership role today',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Confidence Challenges',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        ...challenges.map((challenge) => Card(
          child: ListTile(
            leading: Icon(
              mindProvider.completedChallenges.contains(challenge)
                  ? Icons.check_circle
                  : Icons.radio_button_unchecked,
              color: mindProvider.completedChallenges.contains(challenge)
                  ? Colors.green
                  : Colors.grey,
            ),
            title: Text(challenge),
            onTap: () => mindProvider.completeChallenge(challenge),
          ),
        )).toList(),
      ],
    );
  }

  Widget _buildMindfulnessSection(MindProvider mindProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mindfulness',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Meditation Streak',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${mindProvider.meditationStreak} days',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _startMeditation(mindProvider),
                        child: Text('Start Meditation'),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _startBreathing(),
                        child: Text('Breathing Exercise'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _saveJournalEntry(BuildContext context, MindProvider mindProvider) {
    if (_journalController.text.isNotEmpty) {
      final entry = JournalEntry(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        content: _journalController.text,
        date: DateTime.now(),
        mood: mindProvider.currentMood,
        tags: [],
      );
      mindProvider.addJournalEntry(entry);
      _journalController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Journal entry saved! 📝')),
      );
    }
  }

  void _startMeditation(MindProvider mindProvider) {
    mindProvider.incrementMeditationStreak();
    // Start meditation logic
  }

  void _startBreathing() {
    // Start breathing exercise logic
  }
}