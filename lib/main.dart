import 'package:entertainmenttracker/screens/login_screen.dart';
import 'package:entertainmenttracker/screens/movie_screen.dart';
import 'package:entertainmenttracker/screens/registration_screen.dart';
import 'package:entertainmenttracker/screens/search_list_screen.dart';
import 'package:entertainmenttracker/screens/series_screen.dart';
import 'package:entertainmenttracker/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(EntertainmentTracker());
}

class EntertainmentTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: HomeScreen(),
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        MovieScreen.id: (context) => MovieScreen(),
        SeriesScreen.id: (context) => SeriesScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
      },
    );
  }
}
