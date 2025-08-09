import 'package:flutter/material.dart';
import 'package:syncly/features/settings/presentation/pages/settings_page.dart';
import 'package:syncly/features/tasks/presentation/pages/tasks_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: IndexedStack(index: _currentIndex, children: pages),
    // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        // Handle floating action button press
      },
      child: const Icon(Icons.add),
    ),
    bottomNavigationBar: BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (int index) => setState(() => _currentIndex = index),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Tasks'),
        BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Calendar'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
    ),
  );
}

final List<Widget> pages = [
  const TasksPage(),
  const Center(child: Text('Calendar Page')),
  const SettingsPage(),
];
