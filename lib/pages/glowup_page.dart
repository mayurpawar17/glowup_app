import 'package:flutter/material.dart';
import 'package:glowup_app/poviders/habit_provider.dart';
import 'package:provider/provider.dart';

class GlowUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HabitProvider>(
      builder: (context, habitProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Daily Glow-Up'),
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRoutineSection('Morning Routine', [
                  'Skincare Routine',
                  'Hair Styling',
                  'Grooming Check',
                  'Outfit Selection',
                ]),
                SizedBox(height: 20),
                _buildRoutineSection('Evening Routine', [
                  'Evening Skincare',
                  'Grooming Maintenance',
                  'Tomorrow\'s Outfit',
                  'Reflection',
                ]),
                SizedBox(height: 20),
                _buildHabitsList(habitProvider),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRoutineSection(String title, List<String> tasks) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        ...tasks.map((task) => Card(
          child: ListTile(
            leading: Icon(Icons.auto_awesome),
            title: Text(task),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () => _showTaskDetails(task),
          ),
        )).toList(),
      ],
    );
  }

  Widget _buildHabitsList(HabitProvider habitProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'All Habits',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        ...habitProvider.habits.map((habit) => Card(
          child: ListTile(
            leading: Checkbox(
              value: habit.isCompleted,
              onChanged: (bool? value) {
                habitProvider.toggleHabit(habit.id);
              },
            ),
            title: Text(habit.name),
            subtitle: Text(habit.category),
            trailing: Text('${habit.streak} days'),
          ),
        )).toList(),
      ],
    );
  }

  void _showTaskDetails(String task) {
    // Show detailed task instructions
  }
}