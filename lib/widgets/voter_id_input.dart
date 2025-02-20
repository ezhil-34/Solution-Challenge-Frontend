import 'package:flutter/material.dart';

class VoterIdInput extends StatefulWidget {
  final Function(String) onIdEntered;
  final VoidCallback reset;

  const VoterIdInput({Key? key, required this.onIdEntered, required this.reset})
      : super(key: key);

  @override
  State<VoterIdInput> createState() => _VoterIdInputState();
}

class _VoterIdInputState extends State<VoterIdInput> {
  final _controller = TextEditingController();
  bool _isFetching = false; // Track fetching state

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.grey[900], // Dark background
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Enter Voter ID Number:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _controller,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'e.g., 1234567890', // Example ID
              hintStyle: TextStyle(color: Colors.grey[600]),
              fillColor: Colors.grey[800],
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none, // No border line
              ),
              prefixIcon:
              const Icon(Icons.person, color: Colors.white38), // Icon
              contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _isFetching
                ? null
                : () {
              if (_controller.text.isNotEmpty) {
                setState(() {
                  _isFetching = true; // Start fetching
                });
                // Simulate a delay to show loading state
                Future.delayed(const Duration(seconds: 1), () {
                  widget.onIdEntered(_controller.text);
                  setState(() {
                    _isFetching = false; // Stop fetching
                  });
                });
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              padding: const EdgeInsets.symmetric(vertical: 15),
              textStyle: const TextStyle(fontSize: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: _isFetching
                ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
                : const Text('Fetch Details', style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(height: 10),
          OutlinedButton(
            onPressed: _isFetching
                ? null
                : () {
              widget.reset();
              _controller.clear();
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.blueAccent),
              padding: const EdgeInsets.symmetric(vertical: 15),
              textStyle: const TextStyle(fontSize: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              foregroundColor: Colors.blueAccent,
            ),
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}
