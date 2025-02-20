import 'package:flutter/material.dart';
import 'package:ele_1/widgets/voter_id_input.dart';
import 'package:ele_1/widgets/voter_details_display.dart';
import 'package:ele_1/widgets/fingerprint_verification.dart';
import 'package:ele_1/widgets/verification_result.dart';
import 'package:ele_1/models/voter.dart';

void main() {
  runApp(const VoterVerificationApp());
}

class VoterVerificationApp extends StatelessWidget {
  const VoterVerificationApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Voter Verification',
      theme: ThemeData(
        brightness: Brightness.dark, // Dark Mode
        primarySwatch: Colors.blue,
      ),
      home: const VoterVerificationScreen(),
    );
  }
}

class VoterVerificationScreen extends StatefulWidget {
  const VoterVerificationScreen({Key? key}) : super(key: key);

  @override
  State<VoterVerificationScreen> createState() =>
      _VoterVerificationScreenState();
}

class _VoterVerificationScreenState extends State<VoterVerificationScreen> {
  String voterId = '';
  Voter? voterDetails;
  VerificationStatus verificationStatus = VerificationStatus.pending;
  bool _isFingerprintVerified = false; // New state variable

  // This function simulates fetching voter details from an API
  void fetchVoterDetails(String id) {
    setState(() {
      voterId = id;
      voterDetails = _simulateFetchVoterDetails(id);
    });
  }

  Voter? _simulateFetchVoterDetails(String id) {
    // Simulate fetching voter data from a database.
    if (id == '12345') {
      return Voter(
        id: '12345',
        name: 'John Doe',
        photoUrl: 'https://via.placeholder.com/150',
        age: 45,
        gender: 'Male',
        pollingNumber: 'Polling Station A',
        address: '123 Main Street',
        hasVoted: false,
      );
    } else if (id == '67890') {
      return Voter(
        id: '67890',
        name: 'Jane Smith',
        photoUrl: 'https://via.placeholder.com/150',
        age: 32,
        gender: 'Female',
        pollingNumber: 'Polling Station B',
        address: '456 Oak Avenue',
        hasVoted: true,
      );
    } else {
      return null;
    }
  }

  // This callback is called from the fingerprint verification widget.
  // If verification is successful, we update our state to show the voter details screen.
  void onFingerprintVerified(bool success) {
    if (success) {
      setState(() {
        _isFingerprintVerified = true;
      });
    } else {
      setState(() {
        verificationStatus = VerificationStatus.failure;
      });
    }
  }

  // Reset the whole verification process.
  void resetVerification() {
    setState(() {
      voterId = '';
      voterDetails = null;
      verificationStatus = VerificationStatus.pending;
      _isFingerprintVerified = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Voter Verification Terminal',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isFingerprintVerified
        // If fingerprint is verified, show the voter details UI.
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            VoterIdInput(onIdEntered: fetchVoterDetails, reset: resetVerification),
            const SizedBox(height: 20),
            if (voterDetails != null) VoterDetailsDisplay(voter: voterDetails!),
            if (voterDetails != null) const SizedBox(height: 20),
            if (voterDetails != null)
              VerificationResult(status: verificationStatus, voter: voterDetails!),
          ],
        )
        // Otherwise, display the fingerprint verification widget.
            : Center(
          child: FingerprintVerification(onVerified: onFingerprintVerified),
        ),
      ),
    );
  }
}
