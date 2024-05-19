import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  final List<Map<String, String>> tournaments = [
    {
      'name': 'Basketball Championship',
      'startDate': '2024-06-01',
      'endDate': '2024-06-10',
      'location': 'Sports Arena',
    },
    {
      'name': 'Soccer League',
      'startDate': '2024-07-15',
      'endDate': '2024-07-30',
      'location': 'City Stadium',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to add event screen
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('User Name'),
              accountEmail: Text('user@example.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text('U', style: TextStyle(fontSize: 24.0)),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('History'),
              onTap: () {
                Navigator.pushNamed(context, '/history');
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                // Handle logout
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: tournaments.length,
          itemBuilder: (context, index) {
            final tournament = tournaments[index];
            return Card(
              child: ListTile(
                title: Text(tournament['name']!),
                subtitle: Text(
                  'Start: ${tournament['startDate']}\n'
                  'End: ${tournament['endDate']}\n'
                  'Location: ${tournament['location']}',
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    // Handle registration logic
                  },
                  child: Text('Register'),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
