import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../Components/AllConsultantCard.dart';
import 'ConsultantDetails.dart';
import 'GeneralChat.dart';

class AllConsultant extends StatefulWidget {
  const AllConsultant({super.key});

  @override
  State<AllConsultant> createState() => _AllConsultantState();
}

class _AllConsultantState extends State<AllConsultant> {
  final List<String> categories = [
    'All',
    'Cardiologist',
    'Dentist',
    'Psychiatrist',
    'Dermatologist',
    'Neurologist',
    'Pediatrician',
  ];

  String selectedCategory = 'All';

  final List<Map<String, dynamic>> allConsultants = [
    {
      'name': 'Dr. Thomas Michael',
      'specializing': 'Cardiologist',
      'imageUrl': 'assets/images/R.jpg',
      'rate': 4.8,
      'fee': '\$30',
    },
    {
      'name': 'Dr. Sarah Lee',
      'specializing': 'Dentist',
      'imageUrl': 'assets/images/R.jpg',
      'rate': 4.6,
      'fee': '\$25',
    },
    {
      'name': 'Dr. Maya Khan',
      'specializing': 'Psychiatrist',
      'imageUrl': 'assets/images/R.jpg',
      'rate': 4.9,
      'fee': '\$40',
    },
    {
      'name': 'Dr. Alex Chen',
      'specializing': 'Dermatologist',
      'imageUrl': 'assets/images/R.jpg',
      'rate': 4.5,
      'fee': '\$35',
    },
    {
      'name': 'Dr. Omar Haddad',
      'specializing': 'Cardiologist',
      'imageUrl': 'assets/images/R.jpg',
      'rate': 4.7,
      'fee': '\$32',
    },
  ];

  List<Map<String, dynamic>> get filteredConsultants {
    if (selectedCategory == 'All') return allConsultants;
    return allConsultants
        .where((consultant) =>
    consultant['specializing'] == selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f7fa),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Center(
          child: Padding(
            padding: EdgeInsets.only(right: 50.0),
            child: Text(
              'All Consultant',
              style: TextStyle(
                fontFamily: 'NotoSerifGeorgian',
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category chips
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = selectedCategory == category;

                  return ChoiceChip(
                    label: Text(
                      category,
                      style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'NotoSerifGeorgian',
                      ),
                    ),
                    selected: isSelected,
                    onSelected: (bool selected) {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                    selectedColor: Theme.of(context).colorScheme.primary,
                    backgroundColor: Theme.of(context).colorScheme.onSurface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    showCheckmark: false,
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            // Consultant cards
            Expanded(
              child: GridView.builder(
                itemCount: filteredConsultants.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  final consultant = filteredConsultants[index];
                  return AllConsultantCard(
                    name: consultant['name'],
                    imageUrl: consultant['imageUrl'],
                    rate: consultant['rate'],
                    specializing: consultant['specializing'],
                    fee: consultant['fee'],
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context){return ConsultantDetails();}));
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.primary,
                fontFamily: 'NotoSerifGeorgian',
              ),
              children: [
                const TextSpan(
                  text: 'Need help finding the right consultant? ',
                ),
                const TextSpan(
                  text: 'Our team is available to assist you — ',
                ),
                TextSpan(
                  text: 'start a chat',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(context, MaterialPageRoute(builder: (context){return Generalchat();}));
                    },
                ),
                const TextSpan(
                  text: ' for personalized recommendations.',
                ),
              ],
            ),
          ),
        ),
      )
      ,
    );
  }
}
