import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../../Providers/Home/User/NavBarProviders/GetDomainsProvider.dart';
import '../../../generated/l10n.dart';
import '../../Auth/Register/Compoenets/text.dart';
import '../Components/CategoryCard.dart';
import '../Pages/AllConsultant.dart';

class Categories extends StatefulWidget {
  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GetDomainsProvider>(context, listen: false).fetchDomains();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f7fa),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: Container(),
        title: Padding(
          padding: EdgeInsets.only(left: isArabic() ? 0 : 70.0, right: isArabic() ? 70 : 0),
          child: Text(
            S.of(context).categories,
            style: const TextStyle(
              fontFamily: 'NotoSerifGeorgian',
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
      ),
      body: Consumer<GetDomainsProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.errorMessage != null) {
            // Show error as a centered text, SnackBar cannot be returned directly
            return Center(
              child: text(
                label: provider.errorMessage!,
                fontSize: 16,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            );
          }

          // Filter only approved domains
          //final approvedDomains = provider.domains.where((d) => d.status == 'approved').toList();

          if (provider.domains.isEmpty) {
            return Center(
              child: text(
                label: S.of(context).NoCategories,
                fontSize: 25,
                color: Theme.of(context).colorScheme.primary,
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12, top: 12),
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: provider.domains.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) {
                final category = provider.domains[index];
                return CategoryCard(
                  name: category.name,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AllConsultant(
                          id: category.id,
                          name: category.name,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }

  bool isArabic() {
    return Intl.getCurrentLocale() == 'ar';
  }
}
