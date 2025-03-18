import 'package:flutter/material.dart';
import 'home.dart';
import 'user.dart';
import 'voter_id.dart';
import 'qr_code.dart';
import 'candidate.dart';
import 'faq.dart';
import 'fingerprint.dart';
import 'voter_details.dart';
import 'voting_screen.dart';

void main() {
  runApp(VoterVerificationApp());
}

class VoterVerificationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Voter Verification',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/user': (context) => UserScreen(),
        '/voter_id': (context) => VoterIDScreen(),
        '/qr_code': (context) => QRCodeScreen(),
        '/candidate': (context) => CandidateScreen(),
        '/faq': (context) => FAQScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/fingerprint') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => FingerprintScreen(
              voterID: args['voterID'],
              voterDetails: args['voterDetails'],
            ),
          );
        }
        if (settings.name == '/voter_details') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => VoterDetailsScreen(
              voterID: args['voterID'],
              voterDetails: args['voterDetails'],
            ),
          );
        }
        if (settings.name == '/vote') {
          final args = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) => VotingScreen(voterID: args),
          );
        }
        return null;
      },
    );
  }
}
