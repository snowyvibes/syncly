import 'package:go_router/go_router.dart';
import 'package:syncly/features/home/presentation/pages/home_page.dart';
import 'package:syncly/features/notes/domain/entities/note.dart';
import 'package:syncly/features/notes/presentation/pages/note_details_page.dart';
import 'package:syncly/features/notes/presentation/pages/notes_page.dart';
import 'package:syncly/features/settings/presentation/pages/privacy_policy.dart';
import 'package:syncly/features/settings/presentation/pages/settings_page.dart';
import 'package:syncly/features/settings/presentation/pages/support_page.dart';
import 'package:syncly/features/tasks/presentation/pages/task_calendar/tasks_page.dart';

final GoRouter appRoutes = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomePage()),

    // Auth
    // GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    // GoRoute(path: '/register', builder: (context, state) => const RegisterPage()),

    // Home
    GoRoute(path: '/home', builder: (context, state) => const HomePage()),

    // Tasks
    GoRoute(path: '/tasks', builder: (context, state) => const TasksPage()),

    // Notes
    GoRoute(path: '/notes', builder: (context, state) => const NotesPage()),
    GoRoute(
      path: '/note/:id',
      builder: (context, state) {
        final note = state.extra as Note;
        return NoteDetailsPage(note);
      },
    ),

    // Settings
    GoRoute(path: '/settings', builder: (context, state) => const SettingsPage()),
    GoRoute(path: '/support', builder: (context, state) => const SupportPage()),
    GoRoute(path: '/privacy', builder: (context, state) => const PrivacyPolicyPage()),
  ],
);
