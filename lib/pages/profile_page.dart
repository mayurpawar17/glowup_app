import 'package:flutter/material.dart';
import 'package:glowup_app/poviders/user_provdier.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(userProvider),
            SizedBox(height: 20),
            _buildUserInfo(userProvider),
            SizedBox(height: 20),
            _buildGoalSummary(userProvider),
            SizedBox(height: 20),
            _buildSettings(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(UserProvider provider) {
    return Row(
      children: [
        // CircleAvatar(
        //   radius: 40,
        //   backgroundImage: provider.profileImage != null
        //       ? FileImage(provider.profileImage!)
        //       : AssetImage('assets/default_avatar.png') as ImageProvider,
        // ),
        SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              provider.name ?? 'User Name',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('user@email.com', style: TextStyle(color: Colors.grey[700])),
            // Text(provider.email ?? 'user@email.com',
            //     style: TextStyle(color: Colors.grey[700])),
          ],
        ),
      ],
    );
  }

  Widget _buildUserInfo(UserProvider provider) {
    return Card(
      child: ListTile(
        title: Text('Basic Info'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text('Age: ${provider.age}'),
            Text('Height: ${provider.height} cm'),
            Text('Weight: ${provider.weight} kg'),
            // Text('Location: ${provider.location ?? 'Not set'}'),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            // Navigate to Edit Profile page
          },
        ),
      ),
    );
  }

  Widget _buildGoalSummary(UserProvider provider) {
    return Card(
      child: ListTile(
        title: Text('Primary Goals'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: provider.goals.map((goal) => Text('• $goal')).toList(),
        ),
      ),
    );
  }

  Widget _buildSettings(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Settings',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        ListTile(
          leading: Icon(Icons.language),
          title: Text('Language'),
          onTap: () {
            // Navigate to language settings
          },
        ),
        ListTile(
          leading: Icon(Icons.dark_mode),
          title: Text('Theme Mode'),
          onTap: () {
            // Toggle dark/light mode
          },
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text('Logout'),
          onTap: () {
            // Call logout method
          },
        ),
      ],
    );
  }
}
