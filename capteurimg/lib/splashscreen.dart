import 'dart:async';
import 'package:capteurimg/homepage.dart';
import 'package:flutter/material.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  void initState() {
    super.initState();
    // Démarre un délai de 10 secondes avant de naviguer vers Homepage
    Timer(Duration(seconds: 10), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 7, 8, 22), // Fond d'écran noir
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Chargement
                Image.asset(
                  'assets/rasengan3.gif', // Chemin de votre image PNG de chargement
                  height: 150.0, // Hauteur souhaitée de l'image de chargement
                  width: 150.0, // Largeur souhaitée de l'image de chargement
                ),
                SizedBox(height: 20.0), // Espacement entre l'image et le texte
                Text(
                  'Chargement en cours...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
