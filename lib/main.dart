import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/home_screen.dart';
import 'screens/priority_matrix.dart';
import 'screens/timer_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('resources');
  await Hive.openBox('dates');
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MainNav(),
  ));
}

class MainNav extends StatefulWidget {
  @override
  _MainNavState createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  int _idx = 0;
  final _pages = [HomeScreen(), PriorityMatrixScreen(), TimerScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_idx],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _idx,
        onTap: (i) => setState(() => _idx = i),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Dash"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Agenda"),
          BottomNavigationBarItem(icon: Icon(Icons.timer), label: "Timer"),
        ],
      ),
    );
  }
}
