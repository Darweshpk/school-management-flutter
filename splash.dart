import 'dart:async';
import 'package:flutter/material.dart';
import 'package:aqsa_school/login.dart';

class SecondSplashScreen extends StatefulWidget {
  const SecondSplashScreen({super.key});

  @override
  State<SecondSplashScreen> createState() => _SecondSplashScreenState();
}

class _SecondSplashScreenState extends State<SecondSplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 10), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const FixedLoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF311B92), Color(0xFF7E57C2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Glowing Circular Avatar
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.35),
                        spreadRadius: 5,
                        blurRadius: 20,
                      ),
                    ],
                  ),
                  child: const CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage('images/aqsda.jpeg'),
                  ),
                ),

                const SizedBox(height: 30),

                const Text(
                  'AqsA Model School Sattoki Kasur',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 1.5,
                    fontFamily: 'Arial',
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 10),

                const Text(
                  'An Institute With All Educational Solutions',
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.amberAccent,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 50),

                // Eye-catching Indicator
                const LinearProgressIndicator(
                  backgroundColor: Color(0xFFB388FF),
                  color: Colors.amberAccent,
                  minHeight: 5,
                ),

                const SizedBox(height: 20),

                const Text(
                  'Loading... Excellence is on its way!',
                  style: TextStyle(
                    color: Colors.amberAccent,
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
