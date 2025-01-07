import 'package:flutter/material.dart';

class TournamentDetailsPage extends StatelessWidget {
  final Map<String, dynamic> tournament = {
    "name": "Abc",
    "totalAverage": "00:00:00",
    "start": "07 January 2025",
    "end": "14 January 2025",
    "flyingRecords": [
      {
        "totalBirds": 7,
        "start": "07 January 2025 12:00 AM",
      }
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PigeonsTracker"),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tournament['name'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.pink),
            ),
            SizedBox(height: 8),
            Text(
              "Total Average: ${tournament['totalAverage']}",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "Start: ${tournament['start']}",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "End: ${tournament['end']}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              "Flying Day Record",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: tournament['flyingRecords'].length,
                itemBuilder: (context, index) {
                  final record = tournament['flyingRecords'][index];
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Icon(Icons.access_time, color: Colors.black),
                      title: Text("Total Birds: ${record['totalBirds']}"),
                      subtitle: Text("Start: ${record['start']}"),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          // Add your delete functionality here
                          print("Delete Record $index");
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
