import 'package:flutter/material.dart';
import 'api_service.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final ApiService apiService = ApiService(baseUrl: 'http://your-backend-url/api');

  List<Map<String, String>> registeredEvents = [];

  @override
  void initState() {
    super.initState();
    fetchRegisteredEvents();
  }

  void fetchRegisteredEvents() async {
    try {
      final fetchedEvents = await apiService.getRegisteredEvents();
      setState(() {
        registeredEvents = fetchedEvents;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load registered events')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: registeredEvents.length,
          itemBuilder: (context, index) {
            final event = registeredEvents[index];
            return Card(
              child: ListTile(
                title: Text(event['name']!),
                subtitle: Text(
                  'Start: ${event['startDate']}\n'
                  'End: ${event['endDate']}\n'
                  'Location: ${event['location']}',
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
