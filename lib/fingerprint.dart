import 'package:flutter/material.dart';
import 'voter_details.dart';

class FingerprintScreen extends StatelessWidget {
  final String voterID;
  final Map<String, dynamic> voterDetails;

  FingerprintScreen({required this.voterID, required this.voterDetails});

  void verifyFingerprint(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VoterDetailsScreen(voterID: voterID, voterDetails: voterDetails),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fingerprint Authentication')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade900, Colors.blue.shade500],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.fingerprint, size: 100, color: Colors.white),
              SizedBox(height: 20),
              Text("Place your finger to verify", style: TextStyle(color: Colors.white, fontSize: 18)),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => verifyFingerprint(context),
                child: Text('Verify Fingerprint'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
