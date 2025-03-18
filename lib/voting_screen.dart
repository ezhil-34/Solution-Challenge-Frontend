import 'package:flutter/material.dart';

class VotingScreen extends StatefulWidget {
  final String voterID;
  VotingScreen({required this.voterID});

  @override
  _VotingScreenState createState() => _VotingScreenState();
}

class _VotingScreenState extends State<VotingScreen> {
  String? selectedParty;

  final List<String> parties = ["Party A", "Party B", "Party C"];

  void submitVote() {
    if (selectedParty != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Vote submitted for $selectedParty!")),
      );
      Navigator.popUntil(context, ModalRoute.withName('/'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Vote for a Candidate')),
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
                Text("Select a party to vote", style: TextStyle(fontSize: 20, color: Colors.white)),
                ...parties.map((party) => RadioListTile<String>(
                  title: Text(party, style: TextStyle(color: Colors.white)),
                  value: party,
                  groupValue: selectedParty,
                  onChanged: (value) {
                    setState(() {
                      selectedParty = value;
                    });
                  },
                )),
                ElevatedButton(
                  onPressed: submitVote,
                  child: Text('Submit Vote'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
