import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../poviders/habit_provider.dart';
import '../poviders/user_provdier.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<UserProvider, HabitProvider>(
      builder: (context, userProvider, habitProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Good morning, ${userProvider.name}!'),
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildGlowUpScoreCard(habitProvider),
                SizedBox(height: 20),
                _buildQuickActions(context),
                SizedBox(height: 20),
                _buildStreakCard(habitProvider),
                SizedBox(height: 20),
                _buildTodaysTasks(habitProvider),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget _buildGlowUpScoreCard(HabitProvider habitProvider) {
  return Card(
    elevation: 4,
    child: Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'Today\'s Glow-Up Score',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          CircularProgressIndicator(
            value: habitProvider.dailyScore / 100,
            strokeWidth: 8,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
          ),
          SizedBox(height: 10),
          Text(
            '${habitProvider.dailyScore}%',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildQuickActions(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Quick Actions',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildActionCard(
            Icons.water_drop,
            'Log Water',
            Colors.blue,
            () => _logWater(context),
          ),
          _buildActionCard(
            Icons.fitness_center,
            'Start Workout',
            Colors.red,
            () => Navigator.pushNamed(context, '/fitness'),
          ),
          _buildActionCard(
            Icons.auto_awesome,
            'Skincare',
            Colors.purple,
            () => Navigator.pushNamed(context, '/style'),
          ),
          _buildActionCard(
            Icons.edit,
            'Journal',
            Colors.orange,
            () => Navigator.pushNamed(context, '/mind'),
          ),
        ],
      ),
    ],
  );
}

Widget _buildActionCard(
  IconData icon,
  String title,
  Color color,
  VoidCallback onTap,
) {
  return GestureDetector(
    onTap: onTap,
    child: Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 32, color: color),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildStreakCard(HabitProvider habitProvider) {
  return Card(
    elevation: 4,
    child: Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStreakItem(
            'Current Streak',
            '${habitProvider.currentStreak}',
            Icons.local_fire_department,
          ),
          _buildStreakItem(
            'Total Habits',
            '${habitProvider.habits.length}',
            Icons.task_alt,
          ),
          _buildStreakItem(
            'Completed',
            '${habitProvider.habits.where((h) => h.isCompleted).length}',
            Icons.check_circle,
          ),
        ],
      ),
    ),
  );
}

Widget _buildStreakItem(String title, String value, IconData icon) {
  return Column(
    children: [
      Icon(icon, size: 32, color: Colors.orange),
      SizedBox(height: 8),
      Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      Text(title, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
    ],
  );
}

Widget _buildTodaysTasks(HabitProvider habitProvider) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Today\'s Tasks',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 10),
      ...habitProvider.habits
          .take(3)
          .map(
            (habit) => Card(
              child: ListTile(
                leading: Checkbox(
                  value: habit.isCompleted,
                  onChanged: (bool? value) {
                    habitProvider.toggleHabit(habit.id);
                  },
                ),
                title: Text(habit.name),
                subtitle: Text(habit.category),
                trailing: Icon(
                  habit.isCompleted
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  color: habit.isCompleted ? Colors.green : Colors.grey,
                ),
              ),
            ),
          )
          .toList(),
    ],
  );
}

void _logWater(BuildContext context) {
  // final fitnessProvider = Provider.of<FitnessProvider>(context, listen: false);
  // fitnessProvider.addWater(1.0);
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text('Water logged! 💧')));
}
