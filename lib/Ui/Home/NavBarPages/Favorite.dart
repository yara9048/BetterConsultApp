import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../Providers/Home/User/NavBarProviders/AddToFavoriteProvider.dart';
import '../../../Providers/Home/User/NavBarProviders/DeleteFromFavoriiteProvider.dart';
import '../../../Providers/Home/User/NavBarProviders/GetAlFavoriteProvider.dart';
import '../../../generated/l10n.dart';
import '../../Auth/Register/Compoenets/text.dart';
import '../Components/AllConsultantCard.dart';
import '../Pages/ConsultantDetails.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  void initState() {
    super.initState();
    // Fetch favorites when the widget is first built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GetFavorite>(context, listen: false).getFavorite();
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
          padding: EdgeInsets.only(
            left: isArabic() ? 0 : 70.0,
            right: isArabic() ? 70 : 0,
          ),
          child: Text(
            S.of(context).favorite,
            style: const TextStyle(
              fontFamily: 'NotoSerifGeorgian',
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
      ),
      body: Consumer<GetFavorite>(
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
          } else if (provider.favorites.isEmpty) {
            return Center(
              child: Text(
                'Favorite is empty',
                style: TextStyle(
                  fontSize: 25,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            );
          } else {
            return GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: provider.favorites.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                final consultant = provider.favorites[index];
                return AllConsultantCard(
                  name: consultant.location,
                  rate: consultant.rating,
                  specializing: consultant.location,
                  fee: consultant.cost.toString(),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ConsultantDetails(id: consultant.id),
                      ),
                    );
                  },
                  isFavoriteInitial: true,
                  onFavoriteToggle: () async {
                    final provider =
                    Provider.of<AddToFavoriteProvider>(context, listen: false);
                    await provider.addToFavorite(consultant.id);
                    if (provider.isVerified) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: text(
                            label: 'Added to favorites!',
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          backgroundColor: Theme.of(context).colorScheme.secondary,
                        ),
                      );
                      // Refresh the favorites list
                      Provider.of<GetFavorite>(context, listen: false).getFavorite();
                    } else if (provider.errorMessage != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: text(
                            label: 'Error',
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          backgroundColor: Theme.of(context).colorScheme.secondary,
                        ),
                      );
                    }
                  },
                  onDelete: () async {
                    final provider =
                    Provider.of<DeleteFromFavoriteProvider>(context, listen: false);
                    await provider.deleteFromFavorite(consultant.id);
                    if (provider.isVerified) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: text(
                            label: 'Removed from favorites!',
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          backgroundColor: Theme.of(context).colorScheme.secondary,
                        ),
                      );
                      // Refresh the favorites list
                      Provider.of<GetFavorite>(context, listen: false).getFavorite();
                    } else if (provider.errorMessage != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: text(
                            label: 'Error',
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          backgroundColor: Theme.of(context).colorScheme.secondary,
                        ),
                      );
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }

  bool isArabic() {
    return Intl.getCurrentLocale() == 'ar';
  }
}
