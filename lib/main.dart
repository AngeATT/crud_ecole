import 'package:crud_ecole/pages/MyHomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:crud_ecole/globals.dart' as globals;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await globals.db.initializedDB();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarContrastEnforced: false,
      systemStatusBarContrastEnforced: false,
    );

    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
    );

    return MaterialApp(
      title: 'CRUD ECOLE',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        splashColor: Colors.transparent,
        highlightColor: Colors.teal,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Colors.teal,
          onPrimary: Colors.white,
          secondary: Colors.teal,
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          background: Color.fromARGB(255, 3, 213, 192),
          onBackground: Colors.black26,
          surface: Colors.teal,
          tertiary: Colors.black38,
          onSurface: Colors.black,
        ),
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.teal,
        primaryColor: Colors.teal,
        primaryColorLight: const Color.fromARGB(80, 0, 150, 135),
        primaryColorDark: const Color.fromARGB(200, 0, 150, 135),
        splashColor: Colors.transparent,
        highlightColor: const Color.fromARGB(255, 3, 213, 192),
        colorScheme: const ColorScheme(
            brightness: Brightness.dark,
            primary: Colors.teal,
            onPrimary: Colors.black45,
            secondary: Colors.teal,
            onSecondary: Colors.white,
            error: Colors.red,
            onError: Colors.white,
            background: Color.fromARGB(255, 3, 213, 192),
            onBackground: Colors.white24,
            surface: Color.fromARGB(255, 0, 110, 99),
            tertiary: Colors.white38,
            onSurface: Colors.white70),
      ),
      home: const MyHomePage(),
      themeMode: ThemeMode.system,
    );
  }
}
