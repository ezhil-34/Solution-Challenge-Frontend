import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class FingerprintVerification extends StatefulWidget {
  final Function(bool) onVerified;

  const FingerprintVerification({Key? key, required this.onVerified})
      : super(key: key);

  @override
  State<FingerprintVerification> createState() => _FingerprintVerificationState();
}

class _FingerprintVerificationState extends State<FingerprintVerification> {
  final LocalAuthentication auth = LocalAuthentication()
  ;
  bool _isScanning = false;
  bool _biometricAvailable = false;
  String _statusMessage = 'Tap fingerprint to authenticate';

  @override
  void initState() {
    super.initState();
    _checkBiometricAvailability();
  }

  // Check if biometric authentication is available
  Future<void> _checkBiometricAvailability() async {
    try {
      _biometricAvailable = await auth.canCheckBiometrics;
      if (_biometricAvailable) {
        setState(() {
          _statusMessage = 'Tap fingerprint to authenticate';
        });
      } else {
        setState(() {
          _statusMessage = 'Biometric not available. Tap to use system password';
        });
      }
    } catch (e) {
      setState(() {
        _statusMessage = 'Error checking biometrics: ${e.toString()}';
      });
    }
  }

  // Authenticate using biometric or device credentials (PIN/password)
  Future<void> _authenticate() async {
    setState(() {
      _isScanning = true;
      _statusMessage = 'Scanning...';
    });

    try {
      final authenticated = await auth.authenticate(
        localizedReason: 'Authenticate to verify your identity',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false, // Allows fallback to system credentials (PIN/password)
        ),
      );

      setState(() {
        _isScanning = false;
        if (authenticated) {
          _statusMessage = 'Authentication Successful!';
          widget.onVerified(true);
        } else {
          _statusMessage = 'Authentication Failed!';
          widget.onVerified(false);
        }
      });
    } catch (e) {
      setState(() {
        _isScanning = false;
        _statusMessage = 'Authentication Error: ${e.toString()}';
        widget.onVerified(false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Fingerprint Verification',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          _statusMessage,
          style: const TextStyle(color: Colors.white70, fontSize: 16),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: !_isScanning ? _authenticate : null,  // Trigger authentication on tap
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue.withOpacity(0.2),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.6),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: _isScanning
                ? const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
                : const Icon(
              Icons.fingerprint,
              size: 80,
              color: Colors.blue,
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
