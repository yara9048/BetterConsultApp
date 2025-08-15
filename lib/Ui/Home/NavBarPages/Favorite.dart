import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../generated/l10n.dart';

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
          padding: EdgeInsets.only(left: isArabic()? 0 :70.0,right: isArabic()?70:0),
          child: Text(
            S.of(context).favorite,
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
  bool isArabic () {
    return Intl.getCurrentLocale() == 'ar';
  }

}
