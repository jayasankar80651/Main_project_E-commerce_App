import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user;
  String? idToken;
  @override
  void initState() {
    super.initState();
    _loadIdToken();
  }

  Future<void> _loadIdToken() async {
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final token = await user!.getIdToken();
      setState(() {
        idToken = token;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
