import 'package:flutter/material.dart';
import 'package:glowup_app/poviders/fitness_provider.dart';
import 'package:provider/provider.dart' show Consumer, Provider;

class FitnessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<FitnessProvider>(
      builder: (context, fitnessProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Fitness'),
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildNutritionCard(fitnessProvider,context),
                SizedBox(height: 20),
                _buildWorkoutSection(),
                SizedBox(height: 20),
                _buildQuickStats(fitnessProvider),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNutritionCard(FitnessProvider fitnessProvider,context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Today\'s Nutrition',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNutritionItem(
                  'Calories',
                  '${fitnessProvider.caloriesConsumed}',
                  '${fitnessProvider.caloriesTarget}',
                  Colors.orange,
                ),
                _buildNutritionItem(
                  'Water',
                  '${fitnessProvider.waterIntake.toStringAsFixed(1)}',
                  '${fitnessProvider.waterTarget.toStringAsFixed(1)}',
                  Colors.blue,
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _showAddFoodDialog(context),
                    child: Text('Add Food'),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _addWater(context),
                    child: Text('Add Water'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionItem(String title, String current, String target, Color color) {
    return Column(
      children: [
        CircularProgressIndicator(
          value: double.parse(current) / double.parse(target),
          strokeWidth: 6,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
        SizedBox(height: 8),
        Text(
          '$current/$target',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildWorkoutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Workouts',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        _buildWorkoutCard('Upper Body', 'Chest, Back, Arms', 45, Icons.fitness_center),
        _buildWorkoutCard('Lower Body', 'Legs, Glutes', 50, Icons.directions_run),
        _buildWorkoutCard('Core', 'Abs, Obliques', 30, Icons.sports_gymnastics),
        _buildWorkoutCard('Cardio', 'HIIT, Running', 35, Icons.favorite),
      ],
    );
  }

  Widget _buildWorkoutCard(String title, String description, int duration, IconData icon) {
    return Card(
      child: ListTile(
        leading: Icon(icon, size: 32, color: Colors.red),
        title: Text(title),
        subtitle: Text('$description • $duration min'),
        trailing: Icon(Icons.play_arrow),
        onTap: () => _startWorkout(title),
      ),
    );
  }

  Widget _buildQuickStats(FitnessProvider fitnessProvider) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quick Stats',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('Workouts', '${fitnessProvider.workouts.length}', Icons.fitness_center),
                _buildStatItem('This Week', '4', Icons.calendar_today),
                _buildStatItem('Streak', '7', Icons.local_fire_department),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String title, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 32, color: Colors.orange),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  void _showAddFoodDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Food'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Food Name'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Calories'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Add food logic
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  void _addWater(BuildContext context) {
    final fitnessProvider = Provider.of<FitnessProvider>(context, listen: false);
    fitnessProvider.addWater(1.0);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Water added! 💧')),
    );
  }

  void _startWorkout(String workoutName) {
    // Start workout logic
  }
}