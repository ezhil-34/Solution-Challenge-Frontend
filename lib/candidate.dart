import 'package:flutter/material.dart';

class CandidateScreen extends StatelessWidget {
  final List<Map<String, String>> candidates = [
    {"name": "Alice Johnson", "party": "Democratic"},
    {"name": "Bob Williams", "party": "Republican"},
    {"name": "Charlie Brown", "party": "Independent"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Candidate List')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade900, Colors.blue.shade500],
          ),
        ),
        child: ListView.builder(
          padding: EdgeInsets.all(20),
          itemCount: candidates.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.blueGrey,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                title: Text(
                  candidates[index]["name"]!,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                subtitle: Text(
                  "Party: ${candidates[index]["party"]}",
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
                leading: Icon(Icons.person, color: Colors.white, size: 40),
              ),
            );
          },
        ),
      ),
    );
  }
}
