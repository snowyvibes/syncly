import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:syncly/core/utils/sizes.dart';
import 'package:syncly/features/notes/presentation/pages/add_note_page.dart';
import 'package:syncly/features/notes/presentation/pages/notes_page.dart';
import 'package:syncly/features/settings/presentation/pages/settings_page.dart';
import 'package:syncly/features/tasks/presentation/pages/add_task/add_task_page.dart';
import 'package:syncly/features/tasks/presentation/pages/task_calendar/tasks_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> pages = [
    const TasksPage(),
    const NotesPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
      ),
      child: IndexedStack(index: _currentIndex, children: pages),
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    floatingActionButton: FloatingActionButton(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      foregroundColor: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      onPressed: () {
        if (_currentIndex == 0) {
          // Navigate to add task page
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            showDragHandle: true,
            useSafeArea: true,
            builder: (context) => AddTaskPage(),
          );
        } else if (_currentIndex == 1) {
          // Navigate to add note page
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            showDragHandle: true,
            useSafeArea: true,
            builder: (context) =>  AddNotePage(),
          );
        }
      },
      child: const Icon(Icons.add),
    ),
    bottomNavigationBar: SizedBox(
      // height: 110,
      child: StylishBottomBar(
        currentIndex: _currentIndex,
        // Applied gradient instead of bg color because bg color makes the borders disappear
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primary,
          ],
        ),
        onTap: (int index) => setState(() => _currentIndex = index),
        option: AnimatedBarOptions(
          barAnimation: BarAnimation.drop,
          iconSize: AppSizes.iconSize,
          iconStyle: IconStyle.animated,
          opacity: 0.3,
          padding: const EdgeInsets.only(top: 14, bottom: 14),
        ),

        fabLocation: StylishBarFabLocation.end,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppSizes.borderRadius),
          topRight: Radius.circular(AppSizes.borderRadius),
        ),
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
