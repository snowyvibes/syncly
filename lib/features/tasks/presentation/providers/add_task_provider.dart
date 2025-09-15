import 'package:flutter_riverpod/legacy.dart';

final addTaskSegmentIndexProvider = StateProvider<int>((ref) => 0);

final addTaskCategoryProvider = StateProvider<String?>((ref) => null);

final addTaskDateProvider = StateProvider<DateTime?>((ref) => null);

final addTaskTimeProvider = StateProvider<DateTime?>((ref) => null);
