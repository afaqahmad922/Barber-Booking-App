import 'package:barberbookingapp/pages/home.dart';
import 'package:flutter/material.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(top: 200.0),
        child: Column(
          children: [
            Image.asset("images/barber.png"),
            SizedBox(height: 80.0),
            GestureDetector( onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> home()));
            },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Get a Stylish Hair Cut',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
