import 'package:flutter/material.dart';
import 'package:qrscan/screens/main_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:qrscan/models/students.dart';

Future<void> main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(StudentsAdapter());
  await Hive.openBox<Students>("students");
  runApp(const MyApp());
}

var kColorScheme = ColorScheme.fromSeed(seedColor: const Color(0xFF14B8A6));

ThemeData darkTheme = ThemeData.dark().copyWith(
  colorScheme: kColorScheme,
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white70),
  )
);

ThemeData lightTheme = ThemeData().copyWith(
  colorScheme: kColorScheme,
  useMaterial3: true,
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Scan',
      darkTheme: darkTheme,
      theme: lightTheme,
      home: const MainScreen(),
    );
  }
}
