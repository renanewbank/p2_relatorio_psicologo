import 'package:flutter/material.dart';
import 'patients/patients_page.dart';
import 'reports/reports_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final _pages = [const PatientsPage(), const ReportsPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Pacientes'),
          BottomNavigationBarItem(icon: Icon(Icons.description), label: 'Relatórios'),
        ],
        onTap: (i) => setState(() => _currentIndex = i),
      ),
    );
  }
}
