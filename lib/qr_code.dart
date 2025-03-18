import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCodeScreen extends StatefulWidget {
  @override
  _QRCodeScreenState createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String? scannedCode;
  bool fingerprintVerified = false;

  void verifyFingerprint() {
    setState(() {
      fingerprintVerified = true;
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scan QR Code')),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: (controller) {
                this.controller = controller;
                controller.scannedDataStream.listen((scanData) {
                  setState(() {
                    scannedCode = scanData.code;
                  });
                });
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (scannedCode != null)
                  Column(
                    children: [
                      Text("Scanned Code: $scannedCode", style: TextStyle(fontSize: 18)),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: verifyFingerprint,
                        child: Text("Verify Fingerprint"),
                      ),
                      if (fingerprintVerified)
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text("Voter: John Doe", style: TextStyle(fontSize: 20)),
                              Text("Voted: No", style: TextStyle(fontSize: 20)),
                            ],
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
