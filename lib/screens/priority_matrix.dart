import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class PriorityMatrixScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var exams = Hive.box('dates').values.toList();
    exams.sort((a, b) => (a['date'] as DateTime).compareTo(b['date'] as DateTime));

    return Scaffold(
      appBar: AppBar(title: Text("Priority Matrix")),
      body: ListView.builder(
        itemCount: exams.length,
        itemBuilder: (ctx, i) {
          final days = (exams[i]['date'] as DateTime).difference(DateTime.now()).inDays;
          return Card(
            color: days < 3 ? Colors.red[50] : Colors.white,
            child: ListTile(
              title: Text("${exams[i]['title']} (${exams[i]['uni']})"),
              subtitle: Text(DateFormat('yMMMd').format(exams[i]['date'])),
              trailing: Text("$days Days Left", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            ),
          );
        },
      ),
    );
  }
}
