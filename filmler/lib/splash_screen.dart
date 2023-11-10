import 'dart:async';

import 'package:flutter/material.dart';

import 'movies/pages/movie_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MoviePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [
              Color(0xFF01bd64),
              Color(0xFF4888b3),
              Color(0xFF8855fb),
            ],
          ),
        ),
        child:const Center(
          child: Text(
            'Flux: Filmler',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'assets/font/FilmLetters.ttf',
            ),
          ),
        ),
      ),
    );
  }
}
