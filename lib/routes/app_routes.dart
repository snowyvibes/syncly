import 'package:go_router/go_router.dart';
import 'package:syncly/features/home/presentation/pages/home_page.dart';
import 'package:syncly/features/notes/presentation/pages/notes_page.dart';
import 'package:syncly/features/settings/presentation/pages/settings_page.dart';
import 'package:syncly/features/tasks/presentation/pages/tasks_page.dart';

final GoRouter appRoutes = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomePage()),
    GoRoute(path: '/home', builder: (context, state) => const HomePage()),
    GoRoute(path: '/tasks', builder: (context, state) => const TasksPage()),
    GoRoute(path: '/notes', builder: (context, state) => const NotesPage()),
    GoRoute(path: '/settings', builder: (context, state) => const SettingsPage()),
  ],
);
