import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../poviders/habit_provider.dart';
import '../poviders/user_provdier.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  String _selectedFitnessLevel = 'Beginner';
  List<String> _selectedGoals = [];
  String _selectedBodyType = '';
  String _selectedSkinType = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                _buildWelcomePage(),
                _buildBasicInfoPage(),
                _buildGoalsPage(),
                _buildAssessmentPage(),
                _buildCompletePage(),
              ],
            ),
          ),
          _buildNavigationBar(),
        ],
      ),
    );
  }

  Widget _buildWelcomePage() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.waving_hand,
            size: 80,
            color: Theme.of(context).primaryColor,
          ),
          SizedBox(height: 30),
          Text(
            'Welcome to Grit & Glow!',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Text(
            'Let\'s start your transformation journey. We\'ll help you become the best version of yourself.',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInfoPage() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tell us about yourself',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(height: 30),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Age',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your age';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _heightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Height (cm)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Weight (kg)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedFitnessLevel,
              decoration: InputDecoration(
                labelText: 'Fitness Level',
                border: OutlineInputBorder(),
              ),
              items:
                  ['Beginner', 'Intermediate', 'Advanced']
                      .map(
                        (level) =>
                            DropdownMenuItem(value: level, child: Text(level)),
                      )
                      .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedFitnessLevel = value!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalsPage() {
    List<String> goals = [
      'Build Muscle',
      'Lose Weight',
      'Improve Grooming',
      'Boost Confidence',
      'Better Style',
      'Mental Wellness',
    ];

    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'What are your main goals?',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Select all that apply',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          SizedBox(height: 30),
          Expanded(
            child: ListView.builder(
              itemCount: goals.length,
              itemBuilder: (context, index) {
                final goal = goals[index];
                return CheckboxListTile(
                  title: Text(goal),
                  value: _selectedGoals.contains(goal),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        _selectedGoals.add(goal);
                      } else {
                        _selectedGoals.remove(goal);
                      }
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssessmentPage() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'Assessment',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(height: 30),
          _buildSelectionCard(
            'Body Type',
            ['Ectomorph', 'Mesomorph', 'Endomorph'],
            _selectedBodyType,
            (value) => setState(() => _selectedBodyType = value),
          ),
          SizedBox(height: 20),
          _buildSelectionCard(
            'Skin Type',
            ['Oily', 'Dry', 'Combination', 'Normal'],
            _selectedSkinType,
            (value) => setState(() => _selectedSkinType = value),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionCard(
    String title,
    List<String> options,
    String selected,
    Function(String) onSelect,
  ) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children:
                  options.map((option) {
                    return ChoiceChip(
                      label: Text(option),
                      selected: selected == option,
                      onSelected: (bool isSelected) {
                        if (isSelected) {
                          onSelect(option);
                        }
                      },
                    );
                  }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompletePage() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.check_circle, size: 100, color: Colors.green),
          SizedBox(height: 30),
          Text(
            'You\'re all set!',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Your personalized transformation journey is ready to begin.',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationBar() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _currentPage > 0
              ? TextButton(
                onPressed: () {
                  _pageController.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: Text('Back'),
              )
              : SizedBox(),
          Row(
            children: List.generate(
              5,
              (index) => Container(
                width: 8,
                height: 8,
                margin: EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      _currentPage == index
                          ? Theme.of(context).primaryColor
                          : Colors.grey[300],
                ),
              ),
            ),
          ),
          _currentPage < 4
              ? ElevatedButton(
                onPressed: () {
                  if (_currentPage == 1 && !_formKey.currentState!.validate()) {
                    return;
                  }
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: Text('Next'),
              )
              : ElevatedButton(
                onPressed: _completeOnboarding,

                child: Text('Get Started'),
              ),
        ],
      ),
    );
  }

  void _completeOnboarding() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final habitProvider = Provider.of<HabitProvider>(context, listen: false);

    userProvider.setName(_nameController.text);
    userProvider.setAge(int.parse(_ageController.text));
    userProvider.setHeight(double.parse(_heightController.text));
    userProvider.setWeight(double.parse(_weightController.text));
    userProvider.setFitnessLevel(_selectedFitnessLevel);
    userProvider.setGoals(_selectedGoals);
    userProvider.setBodyType(_selectedBodyType);
    userProvider.setSkinType(_selectedSkinType);
    userProvider.completeOnboarding();

    habitProvider.initializeDefaultHabits();

    Navigator.pushReplacementNamed(context, '/home');
  }
}
