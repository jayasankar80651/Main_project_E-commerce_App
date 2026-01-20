import 'package:e_commerce_app/singin_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class SignupPageScreen extends StatefulWidget {
  const SignupPageScreen({super.key});

  @override
  State<SignupPageScreen> createState() => _SignupPageScreenState();
}

class _SignupPageScreenState extends State<SignupPageScreen> {
  TextEditingController fullnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();

  Future<void> signUp() async {
    if (fullnameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmpasswordController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please fill all fields")));
      return;
    }
    if (passwordController.text != confirmpasswordController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Password do not match")));
      return;
    }
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
       Navigator.pop(context);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("signup successful")));
     
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message ?? "Signup failed")));
    }
  }

  @override
  void dispose() {
    fullnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Fashion Store",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.amber[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Create Account",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Sign up to get Started",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 50),
            TextField(
              controller: fullnameController,
              decoration: InputDecoration(
                labelText: "Full Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "email",
                hintText: "example@gmail.com",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: confirmpasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "confirm Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    signUp();
                  },
                  child: Text(
                    "signup",
                    style: TextStyle(color: Colors.amber[900]),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have Account ?"),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SigninPage()),
                    );
                  },
                  child: Text(
                    " Sign in",
                    style: TextStyle(color: Colors.amber[900]),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
