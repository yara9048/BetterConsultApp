import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:untitled6/Providers/Home/Consultant/GetNotificationProvider.dart';

import '../../../generated/l10n.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  late GetNotificationProvider waitingListProvider;

  void initState() {
    super.initState();
    waitingListProvider = Provider.of<GetNotificationProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      waitingListProvider.fetchNotifications();
    });
  }
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title:  Padding(
          padding: EdgeInsets.only(left: isArabic() ? 0 :45.0, right: isArabic()?70: 0),
          child: Text(
            S.of(context).notifications,
            style: TextStyle(
              fontFamily: 'NotoSerifGeorgian',
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),),
      backgroundColor: const Color(0xfff5f7fa),
      body: SafeArea(
        child: Consumer<GetNotificationProvider>(
          builder: (context, provider, _) {
            if (provider.isLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
              );
            }

            if (provider.errorMessage != null) {
              return Center(child: Text(provider.errorMessage!));
            }

            if (provider.data.isEmpty) {
              return const Center(child: Text("No messages yet"));
            }
            return Padding(
              padding: const EdgeInsets.only(bottom: 30.0, top: 20),
              child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: provider.data.length,
            separatorBuilder: (_, __) => const SizedBox(height: 14),
            itemBuilder: (context, index) {
            final notif = provider.data[index];
            final icon = Icons.notification_add;

            return Card(
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            shadowColor: colors.primary.withOpacity(0.3),
            child: Container(
            decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: colors.onSurface),
            child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            leading: CircleAvatar(
            radius: 28,
            backgroundColor: colors.secondary.withOpacity(0.1),
            child: Icon(
            icon,
            size: 28,
            color: colors.primary,
            ),
            ),
            title: Text(
            notif.title.toString(),
            style: TextStyle(
            fontFamily: 'NotoSerifGeorgian',
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: colors.primary,
            letterSpacing: 0.25,
            ),
            ),
            subtitle: Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(
            notif.body.toString(),
            style: TextStyle(
            fontFamily: 'NotoSerifGeorgian',
            fontSize: 14,
            height: 1.4,
            color: colors.onPrimary.withOpacity(0.85),
            ),
            ),
            const SizedBox(height: 10),
            Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
            color: colors.secondary.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
            notif.createdAt.toString(),
            style: TextStyle(
            fontFamily: 'NotoSerifGeorgian',
            fontSize: 12,
            color: colors.secondary.withOpacity(0.9),
            ),
            ),
            )
            ],
            ),
            ),
            ),
            ),
            );
            },
            )
            );
          },
        )
    ));
  }
  bool isArabic () {
    return Intl.getCurrentLocale() == 'ar';
  }

}
