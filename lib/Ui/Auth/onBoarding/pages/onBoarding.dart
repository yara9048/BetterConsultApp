import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../generated/l10n.dart';
import '../../Login/pages/login.dart';
import '../components/indicator.dart';
import '../components/mainWidget.dart';

class onboarding extends StatefulWidget {
  @override
  _onboardingState createState() => _onboardingState();
}

class _onboardingState extends State<onboarding> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  bool isLast = false;
  List<Color> dotColor = [Color(0xffAAC9CE),Color(0xffB6B4C2),Color(0xffC9BBC8),Color(0xffF3DBCF),Color(0xffE5C1CD)];


  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> onboardingData = [
      {
        "image": "assets/images/undraw_questions_g2px.png",
        "title": S.of(context).title1,
        "description": S.of(context).description1,
      },
      {
        "image": "assets/images/undraw_chat-bot_c8iw (1).png",
        "title": S.of(context).title2,
        "description": S.of(context).description2,
      },
      {
        "image": "assets/images/undraw_chat-with-ai_ir62.png",
        "title": S.of(context).title3,
        "description": S.of(context).description3,
      },
      {
        "image": "assets/images/undraw_selection_7hy6.png",
        "title": S.of(context).title4,
        "description": S.of(context).description4,
      },
      {
        "image": "assets/images/undraw_security-on_btwg.png",
        "title": S.of(context).title5,
        "description": S.of(context).description5,
      },
    ];
    isLast = _currentPage == onboardingData.length - 1;
    return Scaffold(
      backgroundColor:Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: isArabic()? 0 :280, top: 20.0, right: isArabic()?270:0),
              child: isLast
                  ? SizedBox(
                width: 40,
                height: 20,
              )
                  : GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){return Login();}));
                },
                child: Text(S.of(context).skip,
                  style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'NotoSerifGeorgian'
                  ),),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingData.length,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (context, index) {
                  return mainWidget(
                    image: onboardingData[index]["image"]!,
                    title: onboardingData[index]["title"]!,
                    description: onboardingData[index]["description"]!,
                  );
                },
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(bottom: 30.0,right: isLast? 10:0),
              child:
              isLast
                  ? Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 50,
                      width: 120,
                      child: Center(
                        child: Text(
                            S.of(context).start,
                          style: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'NotoSerifGeorgian'
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Indicator(
                      currentPage: _currentPage,
                      pageCount: onboardingData.length,
                      selectedColor: Theme.of(context).colorScheme.primary,
                      unselectedColor: Colors.grey[300]!,
                    ),
                  ),
                   ])
                      : Column(
                        children: [
                          Indicator(
                            currentPage: _currentPage,
                            pageCount: onboardingData.length,
                            selectedColor: Theme.of(context).colorScheme.primary,
                            unselectedColor: Colors.grey[300]!,
                          ),
                          Container(color:Colors.white,height: 10,),
                        ],
                      ),

            ),
          ],
        ),
      ),
    );
  }
  bool isArabic () {
    return Intl.getCurrentLocale() == 'ar';
  }
}
