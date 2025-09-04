import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  String? email;
  final _formkey=GlobalKey<FormState>();
  TextEditingController mailcontroller = new TextEditingController();

  resetPassword() async {
    try {
      (await FirebaseAuth.instance.sendPasswordResetEmail(email: email!));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email send Sucessfully")),
      );
    } on FirebaseAuthException catch(e){
      if(e.code=="user not found"){
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("User not Found")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 70.0),
            Container(
              alignment: Alignment.topCenter,
              child: Text(
                "Password Recovery",
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              "Enter Your Email",
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 50.0),
            Form(
              key: _formkey,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                padding: EdgeInsets.only(left: 30.0, right: 10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white70, width: 2.0),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextFormField(
                  controller: mailcontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Email';
                    }
                    return null;
                  },
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Enter Email",
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.white, fontSize: 18.0),
                    prefixIcon: Icon(
                      Icons.mail,
                      color: Colors.white70,
                      size: 18.0,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 50.0),
            GestureDetector(
              onTap: () async {
                if(_formkey.currentState!.validate()){
                  setState(() {
                    email = mailcontroller.text;
                  });
                  resetPassword();
                }
              },
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.deepOrangeAccent,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text(
                  "Send Email!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
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
