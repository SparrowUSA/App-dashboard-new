import 'dart:async';
import 'package:flutter/material.dart';

class TimerScreen extends StatefulWidget {
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  int _sec = 1500; Timer? _t;
  void _start() {
    _t = Timer.periodic(Duration(seconds: 1), (t) => setState(() { if (_sec > 0) _sec--; else _t?.cancel(); }));
  }
  @override
  Widget build(BuildContext context) {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text("${(_sec ~/ 60)}:${(_sec % 60).toString().padLeft(2, '0')}", style: TextStyle(fontSize: 80)),
      ElevatedButton(onPressed: _start, child: Text("START FOCUS")),
    ]));
  }
}
