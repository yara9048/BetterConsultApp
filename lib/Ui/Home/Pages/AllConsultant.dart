import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../Providers/Home/User/NavBarProviders/GetSubDomainsProvider.dart';
import '../../../generated/l10n.dart';
import '../../Auth/Register/Compoenets/text.dart';
import '../Components/AllConsultantCard.dart';
import 'ConsultantDetails.dart';
import 'GeneralChat.dart';

class AllConsultant extends StatefulWidget {
  final int id;
  const AllConsultant({super.key, required this.id});

  @override
  State<AllConsultant> createState() => _AllConsultantState();
}

class _AllConsultantState extends State<AllConsultant> {
  late String selectedSubDomain;
  late GetSubDomainsProvider _subDomainsProvider;

  @override
  void initState() {
    super.initState();
    selectedSubDomain = S.of(context).all;
    _subDomainsProvider = Provider.of<GetSubDomainsProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          selectedSubDomain = S.of(context).all;
        });
      }
      _subDomainsProvider.fetchSubDomains(id: widget.id);
    });
  }

  List<Map<String, dynamic>> get filteredConsultants {
    if (selectedSubDomain == S.of(context).all) return allConsultants;
    return allConsultants
        .where((consultant) => consultant['specializing'] == selectedSubDomain)
        .toList();
  }
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f7fa),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Center(
          child: Padding(
            padding: EdgeInsets.only(right: isArabic() ? 0 : 50.0, left: isArabic() ? 50 : 0),
            child: Text(
              S.of(context).allConsultant,
              style: const TextStyle(
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
            // Subdomain chips
            Consumer<GetSubDomainsProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const SizedBox(
                    height: 40,
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (provider.errorMessage != null) {
                  return  SnackBar(
                    content: text(
                      label: provider.errorMessage!,
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                  );
                } else {
                  final subDomains = [S.of(context).all, ...provider.domains.map((e) => e.name)];

                  return SizedBox(
                    height: 40,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: subDomains.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final subDomain = subDomains[index];
                        final isSelected = selectedSubDomain == subDomain;

                        return ChoiceChip(
                          label: Text(
                            subDomain,
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
                              selectedSubDomain = subDomain;
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
                  );
                }
              },
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ConsultantDetails())
                      );
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
              offset: const Offset(0, -2),
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
                TextSpan(text: S.of(context).generalChat1),
                TextSpan(text: S.of(context).generalChat2),
                TextSpan(
                  text: S.of(context).generalChat3,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Generalchat())
                      );
                    },
                ),
                TextSpan(text: S.of(context).generalChat4),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isArabic() {
    return Intl.getCurrentLocale() == 'ar';
  }
}