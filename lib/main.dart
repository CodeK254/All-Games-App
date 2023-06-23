import 'package:all_games/Screens/home_screen.dart';
import 'package:all_games/Screens/games.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/":(context) => const AllGames(),
        "/categories": (context) => const HomeScreen()
      }
    )
  );
}