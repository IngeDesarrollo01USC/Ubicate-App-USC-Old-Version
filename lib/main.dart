import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ubicate_usc/providers/providers.dart';
import 'package:ubicate_usc/screens/init_screen.dart';
import 'package:ubicate_usc/screens/screens.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UiProvider()),
        ChangeNotifierProvider(create: (_) => EventsProvider()),
        ChangeNotifierProvider(create: (_) => ClassroomProvider())
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ubícate USC',
      initialRoute: 'init',
      routes: {
        'init': (_) => const InitScreen(),
        'home': (_) => const HomeScreen(),
        'route': (_) => const RouteScreen(),
        'panorama': (_) => const PanoramaScreen(),
      },
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Color.fromRGBO(130, 4, 16, 1),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color.fromRGBO(216, 3, 3, 1),
        ),
      ),
    );
  }
}
