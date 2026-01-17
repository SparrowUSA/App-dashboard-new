import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../widgets/hyperlink_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedUni = "University A";

  @override
  Widget build(BuildContext context) {
    var resBox = Hive.box('resources');
    var filtered = resBox.values.where((r) => r['uni'] == selectedUni).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedUni),
        actions: [
          PopupMenuButton<String>(
            onSelected: (v) => setState(() => selectedUni = v),
            itemBuilder: (ctx) => [PopupMenuItem(value: "University A", child: Text("Uni A")), PopupMenuItem(value: "University B", child: Text("Uni B"))],
          )
        ],
      ),
      body: filtered.isEmpty ? Center(child: Text("Empty Dash")) : ListView.builder(
        itemCount: filtered.length,
        itemBuilder: (ctx, i) => HyperlinkCard(upwrite: filtered[i]['upwrite'], url: filtered[i]['url'], subject: filtered[i]['subject']),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    final sC = TextEditingController(); final uC = TextEditingController(); final lC = TextEditingController();
    showDialog(context: context, builder: (ctx) => AlertDialog(
      title: Text("Add Resource/Exam"),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(controller: sC, decoration: InputDecoration(hintText: "Subject")),
        TextField(controller: uC, decoration: InputDecoration(hintText: "Upwrite / Exam Title")),
        TextField(controller: lC, decoration: InputDecoration(hintText: "URL (Leave blank for Exam)")),
      ]),
      actions: [
        TextButton(onPressed: () { // Save as Exam
          Hive.box('dates').add({'uni': selectedUni, 'subject': sC.text, 'title': uC.text, 'date': DateTime.now().add(Duration(days: 7))});
          Navigator.pop(ctx); setState(() {});
        }, child: Text("Add as Exam")),
        ElevatedButton(onPressed: () { // Save as Link
          Hive.box('resources').add({'uni': selectedUni, 'subject': sC.text, 'upwrite': uC.text, 'url': lC.text});
          Navigator.pop(ctx); setState(() {});
        }, child: Text("Save Link")),
      ],
    ));
  }
}
