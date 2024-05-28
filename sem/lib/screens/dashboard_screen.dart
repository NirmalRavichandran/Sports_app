import 'package:flutter/material.dart';
import 'api_service.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ApiService apiService = ApiService(baseUrl: 'http://your-backend-url/api');

  List<Map<String, String>> tournaments = [];

  @override
  void initState() {
    super.initState();
    fetchTournaments();
  }

  void fetchTournaments() async {
    try {
      final fetchedTournaments = await apiService.getTournaments();
      setState(() {
        tournaments = fetchedTournaments;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load tournaments')),
      );
    }
  }

  void registerForTournament(String tournamentId) async {
    try {
      // Call the API to register the user for the tournament with the given ID
      await apiService.registerForTournament(tournamentId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Successfully registered for the tournament')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to register for the tournament')),
      );
    }
  }

  void logout() {
    // Perform logout actions here
    

    // Navigate to login screen
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

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
              Navigator.pushNamed(context, '/add-event');
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
                logout();
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
                    // Pass the tournament ID to the registration function
                    registerForTournament(tournament['id']!);
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
