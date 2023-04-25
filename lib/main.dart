import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker/screens/habit_detail.dart';
import 'package:habit_tracker/screens/habits.dart';
import 'package:habit_tracker/screens/sign_in.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:habit_tracker/screens/create_habit.dart';
import 'package:habit_tracker/screens/update_habit.dart';
import 'package:habit_tracker/widgets/bottomnavigationbar.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(initialLocation: '/', routes: <RouteBase>[
  GoRoute(
    path: '/',
    builder: (context, state) => const SignIn(),
  ),
  ShellRoute(
      builder: (context, state, child) {
        return Scaffold(
          body: child,
          bottomNavigationBar: const BottomNavigation(),
        );
      },
      routes: [
        GoRoute(
          path: '/home',
          builder: (BuildContext context, GoRouterState state) {
            return const Habits();
          },
        ),
        GoRoute(
          path: '/update-habit/:habitId',
          builder: (BuildContext context, GoRouterState state) {
            return UpdateHabit(
              idHabit: state.params['habitId']!,
            );
          },
        ),
        GoRoute(
          path: '/create-habit',
          builder: (BuildContext context, GoRouterState state) {
            return const CreateHabit();
          },
        ),
        GoRoute(
          path: '/detail/:habitId',
          builder: (context, state) {
            return HabitDetail(
              idHabit: state.params['habitId']!,
            );
          },
        ),
      ]),
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Habit tracker',
      routerConfig: _router,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
    );
  }
}
