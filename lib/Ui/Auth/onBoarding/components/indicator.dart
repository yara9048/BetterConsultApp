import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  final int currentPage;
  final int pageCount;
  final Color selectedColor;
  final Color unselectedColor;

  const Indicator({
    required this.currentPage,
    required this.pageCount,
    this.selectedColor = Colors.blue,
    this.unselectedColor = Colors.grey,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pageCount,
            (index) => AnimatedContainer(
          duration: Duration(milliseconds: 200),
          height: currentPage == index ? 14 : 10,
          width: currentPage == index ? 14 : 10,
          margin: EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentPage == index ? selectedColor : unselectedColor,
            boxShadow: currentPage == index
                ? [
              BoxShadow(
                color: selectedColor.withOpacity(0.5),
                blurRadius: 4,
                spreadRadius: 1,
                offset: Offset(0, 2),
              )
            ]
                : null,
          ),
        ),
      ),
    );
  }
}