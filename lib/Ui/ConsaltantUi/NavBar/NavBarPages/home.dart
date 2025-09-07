import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled6/Providers/Home/Consultant/DeleteWaitingListProvider.dart';

import '../../../../Providers/Home/Consultant/ShowWaitingListProvider.dart';
import '../../../../generated/l10n.dart';
import '../../../../main.dart';
import '../../../Home/Components/ChatHistoryCard.dart';
import '../../../Home/Components/SettingNotificationsWidget.dart';
import '../../../Home/Components/ThemeLanguagePopup.dart';
import '../../../Home/Pages/Notifications.dart';
import '../Component/WitingListCard.dart';
import 'addConsutation.dart';

class HomeCons extends StatefulWidget {
  const HomeCons({super.key});

  @override
  State<HomeCons> createState() => _HomeConsState();
}

class _HomeConsState extends State<HomeCons> {
  late DeleteWaitingListprovider deleteProvider;
  late WaitingListProvider waitingListProvider;

  @override
  void initState() {
    super.initState();
    // Initialize providers
    deleteProvider = Provider.of<DeleteWaitingListprovider>(context, listen: false);
    waitingListProvider = Provider.of<WaitingListProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      waitingListProvider.fetchWaitingList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 62, right: 20),
        child: Column(
          children: [
            // Header
            Row(
              children: [
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '${S.of(context).welcome} Consultant',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                      fontFamily: 'NotoSerifGeorgian',
                    ),
                  ),
                ),
                Row(
                  children: [
                    SettingNotificationsWidget(
                      title: S.of(context).notifications,
                      icon: Icons.notifications_none,
                      onTap: () async {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => Notifications()));
                      },
                    ),
                    const SizedBox(width: 10),
                    SettingNotificationsWidget(
                      title: S.of(context).settings,
                      icon: Icons.settings,
                      onTap: _showThemeLanguageDialog,
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              "here's your waiting messages list \nthe following are the questions the users asked and have no answers",
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.9),
                fontFamily: 'NotoSerifGeorgian',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Waiting list
            Expanded(
              child: Consumer<WaitingListProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (provider.errorMessage != null) {
                    return Center(
                      child: Text(
                        provider.errorMessage!,
                        style: TextStyle(color: Theme.of(context).colorScheme.error),
                      ),
                    );
                  } else if (provider.list?.waitingQuestions.isEmpty ?? true) {
                    return Center(
                      child: Text(
                        'Waiting list is empty',
                        style: TextStyle(
                          fontSize: 25,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    );
                  }

                  final questions = provider.list!.waitingQuestions;

                  return MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView.separated(
                      itemCount: questions.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final question = questions[index];
                        if (question == null) return const SizedBox();

                        return WitingListCard(
                          name: question.consultant!.user!.firstName.toString(),
                          content: question.question ?? "",
                          timestamp: question.consultant!.addedAt.toString(),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => AddConsultation()),
                            );
                          },
                          onDelete: () async {
                            final questionId = question.id;
                            print("questionId"+questionId!.toString());
                            if (questionId != null) {
                              await deleteProvider.deleteChat(questionId);
                              if (deleteProvider.isVerified) {
                                WidgetsBinding.instance.addPostFrameCallback((_) {
                                  waitingListProvider.fetchWaitingList();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Removed from History!',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Theme.of(context).colorScheme.onSurface,
                                        ),
                                      ),
                                      backgroundColor:
                                      Theme.of(context).colorScheme.secondary,
                                    ),
                                  );
                                });
                              }
                            }
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showThemeLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return ThemeLanguageDialog(
          isDarkMode: MyApp.of(context).isDarkMode,
          currentLanguage: MyApp.of(context).locale.languageCode,
          onThemeChanged: (isDark) {
            MyApp.of(context).setTheme(isDark);
          },
          onLanguageChanged: (lang) {
            MyApp.of(context).setLocale(lang);
          },
        );
      },
    );
  }
}
