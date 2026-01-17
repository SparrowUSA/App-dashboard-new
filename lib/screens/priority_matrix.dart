import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class PriorityMatrixScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var dateBox = Hive.box('dates');
    
    // Get all exams and sort them by date (Closest first)
    var allExams = dateBox.values.toList();
    allExams.sort((a, b) => (a['date'] as DateTime).compareTo(b['date'] as DateTime));

    return Scaffold(
      appBar: AppBar(
        title: Text("Master Agenda"),
        backgroundColor: Colors.redAccent,
      ),
      body: allExams.isEmpty
          ? Center(child: Text("No upcoming exams registered."))
          : ListView.builder(
              itemCount: allExams.length,
              itemBuilder: (context, index) {
                final exam = allExams[index];
                final daysLeft = (exam['date'] as DateTime).difference(DateTime.now()).inDays;

                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  // If exam is in less than 3 days, make it red
                  color: daysLeft <= 3 ? Colors.red[50] : Colors.white,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.redAccent,
                      child: Text(exam['uni'][0], style: TextStyle(color: Colors.white)),
                    ),
                    title: Text("${exam['title']} - ${exam['subject']}"),
                    subtitle: Text("Date: ${DateFormat('yMMMd').format(exam['date'])}"),
                    trailing: Text("$daysLeft Days", 
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                  ),
                );
              },
            ),
    );
  }
}
