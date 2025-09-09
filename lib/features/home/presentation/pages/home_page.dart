import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:syncly/core/utils/sizes.dart';
import 'package:syncly/features/notes/presentation/pages/add_note_page.dart';
import 'package:syncly/features/notes/presentation/pages/notes_page.dart';
import 'package:syncly/features/settings/presentation/pages/settings_page.dart';
import 'package:syncly/features/tasks/presentation/pages/add_task_page.dart';
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
    body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary],
        ),
      ),
      child: IndexedStack(index: _currentIndex, children: pages),
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    floatingActionButton: FloatingActionButton(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      foregroundColor: Theme.of(context).colorScheme.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      onPressed: () {
        if (_currentIndex == 0) {
          // Navigate to add task page
          showModalBottomSheet(
            context: context,
            builder: (context) => const SizedBox(height: 700, child: AddTaskPage()),
          );
        } else if (_currentIndex == 1) {
          // Navigate to add note page
          showModalBottomSheet(
            context: context,
            builder: (context) => const SizedBox(height: 700, child: AddNotePage()),
          );
        }
      },
      child: const Icon(Icons.add),
    ),
    bottomNavigationBar: SizedBox(
      height: 90,
      child: StylishBottomBar(
        currentIndex: _currentIndex,
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary,
          ],
        ),
        onTap: (int index) => setState(() => _currentIndex = index),
        option: AnimatedBarOptions(),
        fabLocation: StylishBarFabLocation.end,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppSizes.borderRadius),
          topRight: Radius.circular(AppSizes.borderRadius),
        ),
        elevation: 10,

        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        hasNotch: true,
        notchStyle: NotchStyle.circle,

        items: [
          BottomBarItem(
            icon: const Icon(FontAwesomeIcons.circleCheck),
            title: const SizedBox.shrink(),
            showBadge: true,
            badge: const Text('3', style: TextStyle(color: Colors.white)),
            badgeColor: Colors.redAccent,
            selectedColor: Colors.white,
            unSelectedColor: Colors.grey[400]!,
          ),
          BottomBarItem(
            icon: const Icon(FontAwesomeIcons.calendar),
            title: const SizedBox.shrink(),
            selectedColor: Colors.white,
            unSelectedColor: Colors.grey[300]!,
          ),
          BottomBarItem(
            icon: const Icon(FontAwesomeIcons.gears),
            title: const SizedBox.shrink(),
            selectedColor: Colors.white,
            unSelectedColor: Colors.grey[300]!,
          ),
        ],
      ),
    ),
  );
}

final List<Widget> pages = [
  const TasksPage(),
  const NotesPage(),
  const SettingsPage(),
];
