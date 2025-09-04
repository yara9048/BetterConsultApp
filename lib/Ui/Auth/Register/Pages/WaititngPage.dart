import 'package:flutter/material.dart';
import 'package:untitled6/Ui/Auth/Register/Compoenets/text.dart';

class WaititngPage extends StatefulWidget {
  const WaititngPage({super.key});

  @override
  State<WaititngPage> createState() => _WaititngPageState();
}

class _WaititngPageState extends State<WaititngPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Center(child: text(label: "Your application has been made.\nplease wait for the admin's confirmation \nto login as a consultant", fontSize: 16, color: Theme.of(context).colorScheme.primary),),
      ),
    );
  }
}
