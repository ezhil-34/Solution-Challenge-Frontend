import 'package:flutter/material.dart';

class FAQScreen extends StatefulWidget {
  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  List<Map<String, String>> faqList = [
    {
      "question": "How do I register to vote?",
      "answer": "You can register online at the official election website or visit your local registration office."
    },
    {
      "question": "Can I vote online?",
      "answer": "No, online voting is not allowed. You need to vote in person or via mail-in ballot."
    },
    {
      "question": "What do I need to bring to vote?",
      "answer": "You need to bring a valid government-issued ID or your voter registration card."
    },
  ];

  List<bool> isExpanded = [];

  @override
  void initState() {
    super.initState();
    isExpanded = List.filled(faqList.length, false);
  }

  void toggleExpand(int index) {
    setState(() {
      isExpanded[index] = !isExpanded[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FAQs')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade900, Colors.blue.shade500],
          ),
        ),
        child: ListView.builder(
          padding: EdgeInsets.all(20),
          itemCount: faqList.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.blueGrey,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ExpansionTile(
                backgroundColor: Colors.blueGrey,
                collapsedBackgroundColor: Colors.blueGrey,
                tilePadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                title: Text(
                  faqList[index]["question"]!,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                trailing: Icon(
                  isExpanded[index] ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: Colors.white,
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      faqList[index]["answer"]!,
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                  ),
                ],
                onExpansionChanged: (expanded) => toggleExpand(index),
              ),
            );
          },
        ),
      ),
    );
  }
}
