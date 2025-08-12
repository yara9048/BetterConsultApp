import 'package:flutter/material.dart';

import 'ChatPage.dart';

class ConsultantDetails extends StatefulWidget {
  const ConsultantDetails({super.key});

  @override
  State<ConsultantDetails> createState() => _ConsultantDetailsState();
}

class _ConsultantDetailsState extends State<ConsultantDetails> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: const Color(0xfff9f9f9),
      appBar: AppBar(
        backgroundColor: theme.primary,
        elevation: 0,
        title: const Center(
          child: Padding(
            padding: EdgeInsets.only(right: 50.0),
            child: Text(
              'Consultant Details',
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
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            Container(
              height: 250,
              decoration: BoxDecoration(
                color: theme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Center(
                child: Icon(
                  Icons.person,
                  size: 100,
                  color: theme.primary,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr. Vargo Ho',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'NotoSerifGeorgian',
                        color: theme.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Neurologist',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'NotoSerifGeorgian',
                        color: theme.surface.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 20),
                    const SizedBox(width: 4),
                    Text(
                      '4.8',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'NotoSerifGeorgian',
                        color: theme.surface.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 22),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: theme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                   Icon(Icons.location_on, size: 20,color: Theme.of(context).colorScheme.primary,),
                   SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Old Town District, Tbilisi 0105, Georgia',
                      style: TextStyle(
                        color: theme.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        fontFamily: 'NotoSerifGeorgian',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            Text(
              "About me",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'NotoSerifGeorgian',
                color: theme.surface.withOpacity(0.5),
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'IT Services Companies - Quick and easily found! We provide top-level neurological consulting with modern diagnostic methods and a client-first approach...',
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Colors.grey,
                fontFamily: 'NotoSerifGeorgian',
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, -3),
            ),
          ],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor:Theme.of(context).colorScheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context){return ChatPage();}));
          },
          child: const Text(
            'Chat with me',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'NotoSerifGeorgian',
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

}
