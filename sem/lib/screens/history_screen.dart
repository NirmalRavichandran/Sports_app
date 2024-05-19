import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  final List<Map<String, String>> registeredEvents = [
    {
      'name': 'Basketball Championship',
      'startDate': '2024-06-01',
      'endDate': '2024-06-10',
      'location': 'Sports Arena',
    },
  ];

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
