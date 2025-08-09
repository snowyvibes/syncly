import 'package:flutter/material.dart';
import 'package:syncly/core/theme/theme.dart';
import 'package:syncly/routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    title: 'Syncly',
    theme: lightTheme,
    routerDelegate: appRoutes.routerDelegate,
    routeInformationParser: appRoutes.routeInformationParser,
    routeInformationProvider: appRoutes.routeInformationProvider,
    builder: (context, child) => child!,
  );
}
