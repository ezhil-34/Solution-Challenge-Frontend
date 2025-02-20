import 'package:flutter/material.dart';
import 'package:ele_1/models/voter.dart';

class VoterDetailsDisplay extends StatelessWidget {
  final Voter voter;

  const VoterDetailsDisplay({Key? key, required this.voter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Name: ${voter.name}'),
          Text('Age: ${voter.age}'),
          Text('Gender: ${voter.gender}'),
          Text('Polling Number: ${voter.pollingNumber}'),
          Text('Address: ${voter.address}'),
          Text('Voter Status: ${voter.hasVoted ? "Already Voted" : "Eligible"}',
              style: TextStyle(
                  color: voter.hasVoted ? Colors.red : Colors.green)),
        ],
      ),
    );
  }
}