import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_tracker/services/auth_service.dart';
import 'package:vehicle_tracker/screens/splash_screen.dart';
import 'package:vehicle_tracker/screens/home_screen.dart';
import 'package:vehicle_tracker/screens/alerts_screen.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vehicle Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/alerts': (context) => const AlertsScreen(),
        
      },
    );
  }
}
