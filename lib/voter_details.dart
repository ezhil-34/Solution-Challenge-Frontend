import 'package:flutter/material.dart';
import 'voting_screen.dart';

class VoterDetailsScreen extends StatelessWidget {
  final String voterID;
  final Map<String, dynamic> voterDetails;

  VoterDetailsScreen({required this.voterID, required this.voterDetails});

  @override
  Widget build(BuildContext context) {
    bool hasVoted = voterDetails["voted"];

    return Scaffold(
      appBar: AppBar(title: Text('Voter Details')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade900, Colors.blue.shade500],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Name: ${voterDetails["name"]}", style: TextStyle(fontSize: 22, color: Colors.white)),
                Text("Age: ${voterDetails["age"]}", style: TextStyle(fontSize: 20, color: Colors.white)),
                Text("Voted: ${hasVoted ? "Yes" : "No"}", style: TextStyle(fontSize: 20, color: Colors.white)),
                if (!hasVoted)
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => VotingScreen(voterID: voterID)),
                      );
                    },
                    child: Text('Proceed to Vote'),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
