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
      body: Center(child: text(label: "Your application has been made successfully, please wait for the admin's confirmation to login as a consultant", fontSize: 20, color: Theme.of(context).colorScheme.primary),),
    );
  }
}
