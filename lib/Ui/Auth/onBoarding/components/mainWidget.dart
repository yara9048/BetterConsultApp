import 'package:flutter/material.dart';
import 'package:untitled6/Ui/Auth/Register/Compoenets/text.dart';

class mainWidget extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const mainWidget({
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    List<Color> dotColor = [Color(0xffAAC9CE),Color(0xffB6B4C2),Color(0xffC9BBC8),Color(0xffF3DBCF),Color(0xffE5C1CD)];
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image
          Container(
            height: 300,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(height: 30),
          // Title
          text(
            label:title,
              color: Theme.of(context).colorScheme.primary,
              fontSize: 24,
          ),
          SizedBox(height: 15),
          // Description
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontFamily: 'NotoSerifGeorgian'
            ),
          ),
        ],
      ),
    );
  }
}