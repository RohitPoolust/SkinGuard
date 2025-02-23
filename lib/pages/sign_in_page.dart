import 'package:firebase_auth/firebase_auth.dart';
import 'package:skin_guard_app/pages/home.dart';
import 'package:skin_guard_app/pages/sign_up_page.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscurePassword = true;

  userLogin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: mailController.text, password: passwordController.text);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => myhome()));
    } on FirebaseAuthException catch (e) {
      String message = "An error occurred. Please try again.";
      if (e.code == 'user-not-found') {
        message = "No user found for that email.";
      } else if (e.code == "wrong-password") {
        message = "Incorrect password. Please try again.";
      }
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message), backgroundColor: Colors.redAccent));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.cloud, size: 80, color: Colors.grey),
              Text("Skin Guard", style: TextStyle(fontSize: 20, color: Colors.grey)),
              SizedBox(height: 20),
              Text("Sign In", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Text("Hi there! Nice to see you again.",
                  style: TextStyle(fontSize: 16, color: Colors.grey)),
              SizedBox(height: 30),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Email", style: TextStyle(color: Colors.redAccent)),
              ),
              TextField(
                controller: mailController,
                decoration: InputDecoration(
                  hintText: "example@email.com",
                  border: UnderlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Password", style: TextStyle(color: Colors.redAccent)),
              ),
              TextField(
                controller: passwordController,
                obscureText: obscurePassword,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscurePassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                  ),
                  border: UnderlineInputBorder(),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: userLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 100),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: Text("Sign in", style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {},
                child: Text("Forgot Password?", style: TextStyle(color: Colors.grey)),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade300,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 80),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: Text("Create Account", style: TextStyle(fontSize: 18, color: Colors.grey)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
