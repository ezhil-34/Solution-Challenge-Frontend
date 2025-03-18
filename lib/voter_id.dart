import 'package:flutter/material.dart';

class VoterIDScreen extends StatefulWidget {
  @override
  _VoterIDScreenState createState() => _VoterIDScreenState();
}

class _VoterIDScreenState extends State<VoterIDScreen> {
  TextEditingController voterIDController = TextEditingController();
  bool voterFound = true; // Default to true for smoother user experience

  // Dummy voter data
  final Map<String, Map<String, dynamic>> voterData = {
    "123456": {"name": "John Doe", "age": 30, "voted": false, "party": ""},
    "654321": {"name": "Jane Smith", "age": 28, "voted": true, "party": "Party A"},
  };

  void checkVoter() {
    String voterID = voterIDController.text.trim();

    if (voterData.containsKey(voterID)) {
      Navigator.pushNamed(
        context,
        '/fingerprint',
        arguments: {"voterID": voterID, "voterDetails": voterData[voterID]},
      );
    } else {
      setState(() {
        voterFound = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Voter ID Verification')),
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
                Text(
                  "Enter Your Voter ID",
                  style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: voterIDController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Voter ID',
                    labelStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Colors.blueGrey.shade700,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: checkVoter,
                  icon: Icon(Icons.verified_user),
                  label: Text('Proceed to Fingerprint Scan'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    textStyle: TextStyle(fontSize: 18),
                    backgroundColor: Colors.greenAccent.shade700,
                  ),
                ),
                if (!voterFound)
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("Voter ID not found!", style: TextStyle(color: Colors.red, fontSize: 18)),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
