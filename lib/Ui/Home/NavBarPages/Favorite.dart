import 'package:flutter/material.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f7fa),

      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: Container(),
        title:  Padding(
          padding: const EdgeInsets.only(left: 70.0),
          child: Text(
            'Favorite',
            style: TextStyle(
              fontFamily: 'NotoSerifGeorgian',
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),),

      body: Center(child: Text("Favorite"),),
    );
  }
}
