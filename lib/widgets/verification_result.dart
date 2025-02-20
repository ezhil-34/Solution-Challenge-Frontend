import 'package:flutter/material.dart';
import 'package:ele_1/models/voter.dart';

enum VerificationStatus {
  pending,
  success,
  failure
}

class VerificationResult extends StatelessWidget {
  final VerificationStatus status;
  final Voter voter;

  const VerificationResult({Key? key, required this.status, required this.voter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (status == VerificationStatus.pending) {
      return Container(); // Don't show anything if verification is pending
    }

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        children: [
          if (status == VerificationStatus.success) ...[
            const Icon(Icons.check_circle, color: Colors.green, size: 48),
            const Text('Verified Successfully!', style: TextStyle(color: Colors.green)),
            if(!voter.hasVoted)
              const Text('Proceed to Vote'),
            if(voter.hasVoted)
              const Text('Voter Already Voted', style: TextStyle(color: Colors.red)),
          ] else if (status == VerificationStatus.failure) ...[
            const Icon(Icons.error, color: Colors.red, size: 48),
            const Text('Verification Failed!', style: TextStyle(color: Colors.red)),
            const Text('Contact Official'),
          ],
        ],
      ),
    );
  }
}