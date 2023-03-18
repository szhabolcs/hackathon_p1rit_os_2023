import 'package:flutter/material.dart';
import 'package:frontend/services/user_service.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: const [
            Text("Hi, Robi!")
            // Text("Hi, ${UserService().getUser().name}")
          ],
        ),
      ),
    );
  }
}
