import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list/config/routes.dart';
import 'package:flutter_infinite_list/config/themes.dart';
import 'package:flutter_infinite_list/bloc_events_observer.dart';
import 'package:flutter_infinite_list/injection_container.dart';

Future<void> main() async {
  Bloc.observer = const BlocEventsObserver();
  await injectDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Infinite List',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      navigatorKey: navigatorKey,
      onGenerateRoute: AppRoutes.onGenerateRoutes
    );
  }
}
