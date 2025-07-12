import 'package:flutter/material.dart';
import 'package:glowup_app/poviders/style_provider.dart';
import 'package:provider/provider.dart';

class StylePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<StyleProvider>(
      builder: (context, styleProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Style & Grooming'),
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSkincareSection(styleProvider),
                SizedBox(height: 20),
                _buildHaircareSection(styleProvider),
                SizedBox(height: 20),
                _buildStyleSection(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSkincareSection(StyleProvider styleProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Skincare Routine',
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Skin Type: ${styleProvider.skinType}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10),
                ...styleProvider.skinCareRoutine.map((step) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green, size: 20),
                      SizedBox(width: 10),
                      Text(step),
                    ],
                  ),
                )).toList(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHaircareSection(StyleProvider styleProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Haircare Routine',
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Hair Type: ${styleProvider.hairType}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10),
                ...styleProvider.hairCareRoutine.map((step) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green, size: 20),
                      SizedBox(width: 10),
                      Text(step),
                    ],
                  ),
                )).toList(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStyleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Style Guide',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        _buildStyleCard('Casual Wear', 'Everyday comfort and style', Icons.shopping_bag),
        _buildStyleCard('Formal Wear', 'Business and formal occasions', Icons.business_center),
        _buildStyleCard('Date Night', 'Romantic and impressive looks', Icons.favorite),
        _buildStyleCard('Workout Gear', 'Functional and stylish activewear', Icons.fitness_center),
      ],
    );
  }

  Widget _buildStyleCard(String title, String description, IconData icon) {
    return Card(
      child: ListTile(
        leading: Icon(icon, size: 32, color: Colors.purple),
        title: Text(title),
        subtitle: Text(description),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () => _showStyleDetails(title),
      ),
    );
  }

  void _showStyleDetails(String styleType) {
    // Show style details
  }
}