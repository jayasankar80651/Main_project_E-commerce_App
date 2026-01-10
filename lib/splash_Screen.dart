import 'package:e_commerce_app/singin_Screen.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>with SingleTickerProviderStateMixin {
  AnimationController?_controller;
  Animation<double>?_animation;
  void initState(){
    super.initState();
    _controller=AnimationController(vsync: this,
    duration: Duration(seconds: 3));
    _animation = Tween<double>(
      begin: 0,
      end:1,
    ).animate(CurvedAnimation(parent: _controller!, curve: Curves.bounceInOut));
    _controller!.forward();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>SigninPage()));
      },
      child: Scaffold(
        backgroundColor: Colors.amber[900],
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child:ScaleTransition(
                    scale:_animation! ,
                    child: Positioned(
                      child: CircleAvatar(
                        radius: 80,
                        backgroundImage: AssetImage("assets/images/shoppinglogos.jpeg"),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Positioned(
                  child: Text(
                    "FASHION",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
                SizedBox(height: 5),
                Positioned(
                  child: Text(
                    "STORE",
                    style: TextStyle(fontSize: 20, color: Colors.white,fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 355),
                Positioned(
                  child: Text(
                    "Style Meets Simplicity",
                    style: TextStyle(fontSize: 13, color: Colors.white),
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
