import 'package:flutter/material.dart';

class TempLogin extends StatefulWidget {
  const TempLogin({Key? key}) : super(key: key);

  @override
  State<TempLogin> createState() => _TempLoginState();
}

class _TempLoginState extends State<TempLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Stack(
        children: [
          SafeArea(
            child: Container(
                color: Colors.blue,
                child: const Text(
                  "Welcome back new app",
                  textAlign: TextAlign.center,
                )),
          ),
        ],
      ),
    );
  }
}
