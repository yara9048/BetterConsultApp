import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../generated/l10n.dart';
import '../../../main.dart';
import '../Components/SettingNotificationsWidget.dart';
import '../Components/ThemeLanguagePopup.dart';
import '../Pages/Notifications.dart';
import 'Categories.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Map<String, List<String>> categoryCards = {
    'Medical': ['Card One', 'Card Two', 'Card Three'],
    'Technical': ['Card Four', 'Card Five', 'Card Six'],
    'Psychological': ['Card Seven', 'Card Eight'],
    'Health': ['Card Nine'],
    'Judicial': ['Card Ten'],
  };

  String? selectedCategory;
  String searchQuery = '';
  TextEditingController searchController = TextEditingController();

  String? name; // Now nullable

  @override
  void initState() {
    super.initState();
    selectedCategory = categoryCards.keys.first;
    _loadName();
  }

  Future<void> _loadName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('user_name') ?? '';
    });
  }

  List<String> get filteredCards {
    return categoryCards[selectedCategory] ?? [];
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
              // Header
              Row(
                children: [
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "${S.of(context).welcome}\n $name",
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

              // Search bar
              Container(
                decoration: BoxDecoration(
                  color: colors.onSurface,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: searchController,
                  onChanged: (value) => setState(() => searchQuery = value),
                  decoration: InputDecoration(
                    hintText: S.of(context).searchHint,
                    hintStyle: TextStyle(
                      color: colors.onPrimary.withOpacity(0.7),
                      fontFamily: 'NotoSerifGeorgian',
                      fontSize: 14.5,
                      fontWeight: FontWeight.bold,
                    ),
                    prefixIcon: Icon(Icons.search, color: colors.onPrimary),
                    suffixIcon: searchQuery.isNotEmpty
                        ? IconButton(
                      icon: Icon(Icons.clear, color: colors.onPrimary),
                      onPressed: () {
                        searchController.clear();
                        setState(() => searchQuery = '');
                      },
                    )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    filled: true,
                    fillColor: colors.onSurface.withOpacity(0.05),
                  ),
                  style: TextStyle(
                    color: colors.secondary,
                    fontFamily: 'NotoSerifGeorgian',
                  ),
                  cursorColor: colors.primary,
                ),
              ),
              const SizedBox(height: 24),

              Divider(color: colors.onPrimary, thickness: 1),
              const SizedBox(height: 12),

              // Categories header
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

              // Categories list
              SizedBox(
                height: 48,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryCards.keys.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final category = categoryCards.keys.elementAt(index);
                    final isSelected = selectedCategory == category;
                    return ChoiceChip(
                      label: Text(
                        category,
                        style: TextStyle(
                          color:
                          isSelected ? Colors.white : colors.primary,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'NotoSerifGeorgian',
                        ),
                      ),
                      selected: isSelected,
                      onSelected: (_) {
                        setState(() {
                          selectedCategory = category;
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
              ),
              const SizedBox(height: 10),

              // Cards list
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: filteredCards.isEmpty
                      ? Center(
                    key: const ValueKey('empty'),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.sentiment_dissatisfied_outlined,
                            size: 60,
                            color:
                            colors.onPrimary.withOpacity(0.4)),
                        const SizedBox(height: 8),
                        Text(
                          'No results found',
                          style: TextStyle(
                            fontSize: 18,
                            color:
                            colors.onPrimary.withOpacity(0.6),
                            fontFamily: 'NotoSerifGeorgian',
                          ),
                        ),
                      ],
                    ),
                  )
                      : ListView.builder(
                    key: ValueKey(selectedCategory!),
                    physics:
                    const AlwaysScrollableScrollPhysics(),
                    itemCount: filteredCards.length,
                    itemBuilder: (context, index) {
                      final cardTitle = filteredCards[index];
                      return Padding(
                        padding:
                        const EdgeInsets.only(bottom: 12),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () {},
                          splashColor:
                          colors.primary.withOpacity(0.3),
                          child: Container(
                            decoration: BoxDecoration(
                              color: colors.onSurface,
                              borderRadius:
                              BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black
                                      .withOpacity(0.2),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: ListTile(
                              contentPadding:
                              const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12),
                              title: Text(
                                cardTitle,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: colors.primary,
                                  fontFamily:
                                  'NotoSerifGeorgian',
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Specializing',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: colors.onPrimary,
                                      fontFamily:
                                      'NotoSerifGeorgian',
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '4.5 ',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: colors.onPrimary,
                                          fontFamily:
                                          'NotoSerifGeorgian',
                                        ),
                                      ),
                                      Icon(Icons.star_border,
                                          color: colors.onPrimary,
                                          size: 14)
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
                  ),
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
