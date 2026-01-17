import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/home_screen.dart';
import 'screens/priority_matrix.dart';
import 'screens/timer_screen.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('resources');
  await Hive.openBox('dates');
  runApp(MaterialApp(
    theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
    home: MainNav(),
  ));
}

class MainNav extends StatefulWidget {
  @override
  _MainNavState createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  int _idx = 0;
  final _p = [HomeScreen(), PriorityMatrixScreen(), TimerScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _p[_idx],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _idx,
        onTap: (i) => setState(() => _idx = i),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Dash"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Priority"),
          BottomNavigationBarItem(icon: Icon(Icons.timer), label: "Timer"),
        ],
      ),
    );
  }
}
