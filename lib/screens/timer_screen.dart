import 'dart:async';
import 'package:flutter/material.dart';

class TimerScreen extends StatefulWidget {
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  int _seconds = 1500; // 25 Minutes standard
  Timer? _timer;
  bool _isRunning = false;

  void _toggleTimer() {
    if (_isRunning) {
      _timer?.cancel();
    } else {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if (_seconds > 0) {
            _seconds--;
          } else {
            _timer?.cancel();
            _isRunning = false;
          }
        });
      });
    }
    setState(() => _isRunning = !_isRunning);
  }

  @override
  Widget build(BuildContext context) {
    String minutes = (_seconds ~/ 60).toString().padLeft(2, '0');
    String seconds = (_seconds % 60).toString().padLeft(2, '0');

    return Scaffold(
      appBar: AppBar(title: Text("Study Focus Timer")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$minutes:$seconds",
              style: TextStyle(fontSize: 100, fontWeight: FontWeight.bold, fontFamily: 'Courier'),
            ),
            SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: _toggleTimer,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                backgroundColor: _isRunning ? Colors.orange : Colors.green,
              ),
              icon: Icon(_isRunning ? Icons.pause : Icons.play_arrow, color: Colors.white),
              label: Text(_isRunning ? "PAUSE" : "START SESSION", style: TextStyle(color: Colors.white)),
            ),
            if (!_isRunning && _seconds < 1500) 
              TextButton(
                onPressed: () => setState(() => _seconds = 1500),
                child: Text("Reset Timer"),
              )
          ],
        ),
      ),
    );
  }
}
