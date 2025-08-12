import 'package:flutter/material.dart';

import '../Components/CategoryCard.dart';
import '../Pages/AllConsultant.dart';


class Categories extends StatefulWidget {
  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final List<Map<String, String>> categories = [
    {
      'name': 'Medical',
      'image': 'https://source.unsplash.com/400x300/?spa,nature',
    },
    {
      'name': 'Technical',
      'image': 'https://source.unsplash.com/400x300/?fitness,gym',
    },
    {
      'name': 'Psychological',
      'image': 'https://source.unsplash.com/400x300/?meditation,calm',
    },
    {
      'name': 'Health',
      'image': 'https://source.unsplash.com/400x300/?healthy,food',
    },
    {
      'name': 'Judical',
      'image': 'https://source.unsplash.com/400x300/?yoga,relax',
    },

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
             backgroundColor: const Color(0xfff5f7fa),

      appBar: AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
        leading: Container(),             // override any default leading widget
        title:  Padding(
          padding: const EdgeInsets.only(left: 60.0),
          child: Text(
          'Categories',
          style: TextStyle(
            fontFamily: 'NotoSerifGeorgian',
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),),
      body: Padding(
      padding: const EdgeInsets.only(left: 12.0,right: 12,top: 12),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: categories.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 columns
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.8, // height/width ratio
        ),
        itemBuilder: (context, index) {
          final category = categories[index];
          return CategoryCard(
            name: category['name']!,
            imageUrl: category['image']!,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return AllConsultant();
              }));
            },
          );
        },
      ),
    ),);
  }
}
