import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Providers/Home/User/NavBarProviders/GetDomainsProvider.dart';
import '../../../Providers/Home/User/NavBarProviders/GetTopRated.dart';
import '../../../generated/l10n.dart';
import '../../../main.dart';
import '../Components/SearchBarWithDropdown.dart';
import '../Components/SettingNotificationsWidget.dart';
import '../Components/ThemeLanguagePopup.dart';
import '../Pages/ConsultantDetails.dart';
import '../Pages/Notifications.dart';
import 'Categories.dart';

// Providers

import '../../../../Models/Home/User/NavBar/GetDomainsModel.dart';
import '../../../../Models/Home/User/NavBar/TopRatedModel.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? selectedCategory; // will store selected domainId
  String? name;

  @override
  void initState() {
    super.initState();
    _loadName();

    // fetch data once
    Future.microtask(() {
      context.read<GetDomainsProvider>().fetchDomains();
      context.read<GetTopRated>().fetchTopRated();
    });
  }

  Future<void> _loadName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('user_name') ?? '';
    });
  }

  List<TopRatedModel> getFilteredConsultants(
      List<TopRatedModel> consulters, String? selectedDomainId) {
    if (selectedDomainId == null) return consulters;
    return consulters
        .where((c) => c.domain?.toString() == selectedDomainId)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 32, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header
              Row(
                children: [
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "${S.of(context).welcome},\n $name",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: colors.primary,
                        fontFamily: 'NotoSerifGeorgian',
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      SettingNotificationsWidget(
                        title: S.of(context).notifications,
                        icon: Icons.notifications_none,
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                return Notifications();
                              }));
                        },
                      ),
                      const SizedBox(width: 10),
                      SettingNotificationsWidget(
                        title: S.of(context).settings,
                        icon: Icons.settings,
                        onTap: () {
                          _showThemeLanguageDialog();
                        },
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                S.of(context).welcome1,
                style: TextStyle(
                  fontSize: 16,
                  color: colors.onPrimary.withOpacity(0.9),
                  fontFamily: 'NotoSerifGeorgian',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const SearchBarWithDropdown(),
              const SizedBox(height: 24),
              Divider(color: colors.onPrimary, thickness: 1),
              const SizedBox(height: 12),

              /// Categories header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).categories,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: colors.primary,
                      fontFamily: 'NotoSerifGeorgian',
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return Categories();
                          }));
                    },
                    child: Row(
                      children: [
                        Text(
                          S.of(context).seeAll,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: colors.primary,
                            fontFamily: 'NotoSerifGeorgian',
                          ),
                        ),
                        Icon(Icons.chevron_right, color: colors.primary),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),

              /// Domains as chips
              Consumer<GetDomainsProvider>(
                builder: (context, domainsProvider, _) {
                  if (domainsProvider.isLoading) {
                    return const Center(
                        child: CircularProgressIndicator(strokeWidth: 2));
                  }
                  if (domainsProvider.errorMessage != null) {
                    return Text(domainsProvider.errorMessage!);
                  }
                  final domains = domainsProvider.domains;
                  if (domains.isEmpty) {
                    return const Text("No domains available");
                  }

                  selectedCategory ??= domains.first.id.toString();

                  return SizedBox(
                    height: 48,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: domains.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 10),
                      itemBuilder: (context, index) {
                        final domain = domains[index];
                        final isSelected =
                            selectedCategory == domain.id.toString();
                        return ChoiceChip(
                          label: Text(
                            domain.name ?? "Unknown",
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : colors.primary,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'NotoSerifGeorgian',
                            ),
                          ),
                          selected: isSelected,
                          onSelected: (_) {
                            setState(() {
                              selectedCategory = domain.id.toString();
                            });
                          },
                          selectedColor: colors.primary,
                          backgroundColor: colors.onSurface,
                          showCheckmark: false,
                          elevation: isSelected ? 0 : 3,
                          shadowColor: colors.surface,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(
                              color: isSelected
                                  ? Colors.transparent
                                  : colors.primary,
                              width: 1.5,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),

              /// Consultants cards
              Expanded(
                child: Consumer<GetTopRated>(
                  builder: (context, topRatedProvider, _) {
                    if (topRatedProvider.isLoading) {
                      return const Center(
                          child: CircularProgressIndicator(strokeWidth: 2));
                    }
                    if (topRatedProvider.errorMessage != null) {
                      return Text(topRatedProvider.errorMessage!);
                    }
                    final consultants = getFilteredConsultants(
                        topRatedProvider.consulters, selectedCategory);

                    if (consultants.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.sentiment_dissatisfied_outlined,
                                size: 60,
                                color: colors.onPrimary.withOpacity(0.4)),
                            const SizedBox(height: 8),
                            Text(
                              'No consultants found',
                              style: TextStyle(
                                fontSize: 18,
                                color: colors.onPrimary.withOpacity(0.6),
                                fontFamily: 'NotoSerifGeorgian',
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      key: ValueKey(selectedCategory),
                      itemCount: consultants.length,
                      itemBuilder: (context, index) {
                        final c = consultants[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context){return ConsultantDetails(id : consultants[index].id);}));
                            },
                            splashColor: colors.primary.withOpacity(0.3),
                            child: Container(
                              decoration: BoxDecoration(
                                color: colors.onSurface,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                                title: Text(
                                  c.firstName ?? "Unknown",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: colors.primary,
                                    fontFamily: 'NotoSerifGeorgian',
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      c.domainName ?? "Specializing",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: colors.onPrimary,
                                        fontFamily: 'NotoSerifGeorgian',
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "${c.rating ?? 0} ",
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: colors.onPrimary,
                                            fontFamily: 'NotoSerifGeorgian',
                                          ),
                                        ),
                                        Icon(Icons.star_border,
                                            color: colors.onPrimary, size: 14),
                                      ],
                                    ),
                                  ],
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 18,
                                  color: colors.onPrimary,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
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
