import 'package:flutter/material.dart';
import 'package:glowup_app/poviders/progress_provider.dart';
import 'package:provider/provider.dart';

class ProgressPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProgressProvider>(
      builder: (context, progressProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Progress'),
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProgressStats(progressProvider),
                SizedBox(height: 20),
                _buildWeightTracker(progressProvider),
                SizedBox(height: 20),
                _buildMeasurements(progressProvider),
                SizedBox(height: 20),
                _buildProgressPhotos(progressProvider),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _addProgressPhoto(context, progressProvider),
            child: Icon(Icons.add_a_photo),
          ),
        );
      },
    );
  }

  Widget _buildProgressStats(ProgressProvider progressProvider) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Progress Overview', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('Photos', '${progressProvider.progressPhotos.length}', Icons.photo),
                _buildStatItem('Weight Logs', '${progressProvider.weightHistory.length}', Icons.monitor_weight),
                _buildStatItem('Measurements', '${progressProvider.measurements.length}', Icons.straighten),
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
        Icon(icon, size: 32, color: Colors.blue),
        SizedBox(height: 8),
        Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Text(title, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildWeightTracker(ProgressProvider progressProvider) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Weight Tracker', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Current: ${progressProvider.currentWeight.toStringAsFixed(1)} kg', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _updateWeight(progressProvider),
              child: Text('Update Weight'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMeasurements(ProgressProvider progressProvider) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text('Body Measurements', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            // ...progressProvider.measurements.map((measurement) => ListTile(
            //       title: Text('${measurement.bodyPart}: ${measurement.value} cm'),
            //     )),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _addMeasurement(progressProvider),
              child: Text('Add Measurement'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressPhotos(ProgressProvider progressProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Progress Photos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        // Wrap(
        //   spacing: 10,
        //   runSpacing: 10,
        //   children: progressProvider.progressPhotos.map((photo) {
        //     return ClipRRect(
        //       borderRadius: BorderRadius.circular(8),
        //       child: Image.file(photo, width: 100, height: 100, fit: BoxFit.cover),
        //     );
        //   }).toList(),
        // ),
      ],
    );
  }

  void _addProgressPhoto(BuildContext context, ProgressProvider provider) {
    // Show image picker and add to provider
  }

  void _updateWeight(ProgressProvider provider) {
    // Show dialog/input for weight and update
  }

  void _addMeasurement(ProgressProvider provider) {
    // Show dialog/input for body measurement
  }
}
