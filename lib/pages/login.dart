import 'package:barberbookingapp/pages/SignUp.dart';
import 'package:barberbookingapp/pages/admin_login.dart';
import 'package:barberbookingapp/pages/home.dart';
import 'package:barberbookingapp/services/forgot_password.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String? mail, password;
  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();

  final _formkey = GlobalKey <FormState>();

  userLogin () async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: mail!, password: password!);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>home()));
    }
    on FirebaseAuthException catch(e){
      if (e.code=='user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No User Found')));
      }
      else if(e.code=='wrong-password'){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Wrong Password')));
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: 40.0, left: 20.0),
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.blueGrey],
                ),
              ),
              child: Text(
                'Hello\nSign in!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                top: 20.0,
                left: 25.0,
                right: 25.0,
                bottom: 280.0,
              ),
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 4,
              ),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gmail',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      validator: (value){
                        if (value == null || value.isEmpty) {
                          return "please enter email";
                        }
                        return null;
                      },
                      controller: emailcontroller,
                      decoration: InputDecoration(
                        hintText: 'Enter Gmail',
                        suffixIcon: Icon(Icons.mail),
                      ),
                    ),
                    SizedBox(height: 40.0),
                    Text(
                      'Password',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter password";
                        }
                        return null;
                      },
                      controller: passwordcontroller,
                      decoration: InputDecoration(
                        hintText: 'Enter Password',
                        suffixIcon: Icon(Icons.password),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 30.0),
                    GestureDetector( onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPassword()));
                    },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30.0),
                    GestureDetector( onTap: (){
                      if (_formkey.currentState!.validate()) {
                        setState(() {
                          mail=emailcontroller.text;
                          password=passwordcontroller.text;
                        });
                        userLogin();
                      }
                    },
                      child: Container(
                        padding: EdgeInsets.all(18.0),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          gradient: LinearGradient(
                            colors: [Colors.blue, Colors.blueGrey],
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 23.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Do not Have Account",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUp()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Sign Up!",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AdminLogin()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Admin Login",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                    Text(
                      "Terms and Conditions",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
