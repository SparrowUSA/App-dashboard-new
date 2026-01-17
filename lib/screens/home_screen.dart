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
    var resourceBox = Hive.box('resources');
    var filtered = resourceBox.values.where((r) => r['uni'] == selectedUni).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedUni),
        actions: [
          PopupMenuButton<String>(
            onSelected: (val) => setState(() => selectedUni = val),
            itemBuilder: (context) => [
              PopupMenuItem(value: "University A", child: Text("Uni A")),
              PopupMenuItem(value: "University B", child: Text("Uni B")),
            ],
          )
        ],
      ),
      body: filtered.isEmpty 
          ? Center(child: Text("No links yet for $selectedUni"))
          : ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final item = filtered[index];
                return HyperlinkCard(upwrite: item['upwrite'], url: item['url'], subject: item['subject']);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addResource(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _addResource(BuildContext context) {
    final sC = TextEditingController(); final uC = TextEditingController(); final lC = TextEditingController();
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Text("Add Resource"),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(controller: sC, decoration: InputDecoration(hintText: "Subject")),
        TextField(controller: uC, decoration: InputDecoration(hintText: "Upwrite (Notes)")),
        TextField(controller: lC, decoration: InputDecoration(hintText: "Paste URL")),
      ]),
      actions: [ElevatedButton(onPressed: () {
        Hive.box('resources').add({'uni': selectedUni, 'subject': sC.text, 'upwrite': uC.text, 'url': lC.text});
        Navigator.pop(context); setState(() {});
      }, child: Text("Save Offline"))],
    ));
  }
}
