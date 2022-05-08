// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, sized_box_for_whitespace, non_constant_identifier_names, prefer_final_fields, unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'homepage.dart';
import 'signin.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _pwdcontroller = TextEditingController();
  bool circular = false;
  //AuthClass authClass = AuthClass();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Sign Up',
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
              ButtonG(
                "assets/google.svg",
                'Continue with google',
                28,
              ),
              SizedBox(
                height: 15,
              ),
              ButtonG(
                "assets/phone.svg",
                'Continue with phone',
                30,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'or',
                style: TextStyle(color: Colors.white, fontSize: 26),
              ),
              SizedBox(
                height: 20,
              ),
              textItem("Email", _emailcontroller, false),
              SizedBox(
                height: 20,
              ),
              textItem("Password", _pwdcontroller, true),
              SizedBox(
                height: 20,
              ),
              ColorButton(),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'If you already have an account? ',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (builder) => SigninPage()),
                          (route) => false);
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget ColorButton() {
    return InkWell(
      onTap: () async {
        setState(() {
          circular = true;
        });
        try {
          UserCredential userCredential =
              await firebaseAuth.createUserWithEmailAndPassword(
                  email: _emailcontroller.text, password: _pwdcontroller.text);
          //print(userCredential.user.email);
          setState(() {
            circular = false;
          });
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (builder) => Homepage()),
              (route) => false);
        } catch (e) {
          SnackBar snackBar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          setState(() {
            circular = false;
          });
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 90,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(colors: [
            Color(0xfffd746c),
            Color(0xffff9068),
            Color(0xfffd746c)
          ]),
        ),
        child: Center(
          child: circular
              ? CircularProgressIndicator()
              : Text(
                  'Sign Up',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
        ),
      ),
    );
  }

  Widget ButtonG(String imgPath, String text, double size) {
    return InkWell(
      onTap: () {
        GoogleSignIn().signIn();
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 60,
        height: 70,
        child: Card(
          color: Colors.black,
          elevation: 8,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(width: 1, color: Colors.grey)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                imgPath,
                height: size,
                width: size,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                text,
                style: TextStyle(color: Colors.white, fontSize: 17),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget textItem(
      String labltext, TextEditingController controller, bool obtext) {
    return Container(
      width: MediaQuery.of(context).size.width - 70,
      height: 55,
      child: TextFormField(
        controller: controller,
        obscureText: obtext,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: labltext,
          labelStyle: TextStyle(fontSize: 18, color: Colors.white),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:
                BorderSide(width: 1.5, color: Color.fromARGB(255, 92, 92, 92)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(width: 1, color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
