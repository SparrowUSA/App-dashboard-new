import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HyperlinkCard extends StatelessWidget {
  final String upwrite;
  final String url;
  final String subject;

  const HyperlinkCard({required this.upwrite, required this.url, required this.subject});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Icon(Icons.link, color: Colors.blue),
        title: InkWell(
          onTap: () => launchUrl(Uri.parse(url)),
          child: Text(
            upwrite,
            style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline, fontWeight: FontWeight.bold),
          ),
        ),
        subtitle: Text("Subject: $subject"),
      ),
    );
  }
}
