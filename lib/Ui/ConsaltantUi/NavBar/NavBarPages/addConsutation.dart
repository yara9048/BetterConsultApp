import 'package:flutter/material.dart';

import '../../../Home/Pages/Notifications.dart';

class addConsultation extends StatefulWidget {
  const addConsultation({super.key});

  @override
  State<addConsultation> createState() => _addConsultationState();
}

class _addConsultationState extends State<addConsultation> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
                'Add a consultant',
                style: TextStyle(
                  fontFamily: 'NotoSerifGeorgian',
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.white,

              )),
        )
      ),

    );
  }
}
