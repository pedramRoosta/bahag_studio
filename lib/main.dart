import 'package:flutter/material.dart';
import 'package:studio/widgets/side_menu.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(),
        body: const Home(),
      ),
    ),
  );
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SideMenu(
          parentContext: context,
        ),
        SideMenu(
          parentContext: context,
          position: SideMenuPosition.right,
        ),
        SideMenu(
          parentContext: context,
          position: SideMenuPosition.top,
        ),
      ],
    );
  }
}
