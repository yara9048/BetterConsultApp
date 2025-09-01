import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Models/Home/User/Others/ConsultantDetailsModel.dart';
import '../../../Providers/Home/User/NavBarProviders/DeleteFromFavoriiteProvider.dart';
import '../../../Providers/Home/User/Others/ConsultantDetailsProvider.dart';
import '../../../Providers/Home/User/NavBarProviders/AddToFavoriteProvider.dart';
import '../../../Providers/Home/User/Others/ConsultantReviewProvider.dart';
import '../../Auth/Register/Compoenets/text.dart';
import '../Components/RatingBar.dart';
import 'ChatPage.dart';
import '../../../generated/l10n.dart';

class ConsultantDetails extends StatefulWidget {
  final int id;
  const ConsultantDetails({super.key, required this.id});

  @override
  State<ConsultantDetails> createState() => _ConsultantDetailsState();
}

class _ConsultantDetailsState extends State<ConsultantDetails> {
  bool isFavorite = false;
  bool? showRating;

  @override
  void initState() {
    super.initState();
    _loadFlag();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = Provider.of<ConsultantDetailsProvider>(context, listen: false);
      await provider.fetchDetails(id: widget.id.toString());
      if (provider.details.isNotEmpty) {
        setState(() {
          isFavorite = provider.details.first.isFavorite;
        });
      }
    });
  }

  Future<void> _toggleFavorite(int consultantId) async {
    if (isFavorite) {
      final provider = Provider.of<DeleteFromFavoriteProvider>(context, listen: false);
      await provider.deleteFromFavorite(consultantId);
      if (provider.isVerified) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: text(
                label:'Removed from favorites!',
                fontSize: 14,
                color: Theme.of(context).colorScheme.onSurface,
              ),        ));
      }
    } else {
      final provider = Provider.of<AddToFavoriteProvider>(context, listen: false);
      await provider.addToFavorite(consultantId);
      if (provider.isVerified) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: text(
              label:'Added to favorites!',
              fontSize: 14,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),        );
      }
    }

    setState(() {
      isFavorite = !isFavorite;
    });
  }

  Future<void> _loadFlag() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('user_id');
    final cached = await prefs.getBool('chatted_${widget.id}_$id')?? false;
    print("------------------------------"+cached.toString());
    setState(() {
      showRating = cached;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme =  Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: const Color(0xfff9f9f9),
      appBar: AppBar(
        backgroundColor: theme.primary,
        elevation: 0,
        title: Center(
          child: Padding(
            padding: EdgeInsets.only(right: isArabic() ? 0 : 50, left: isArabic() ? 50 : 0),
            child: Text(
              S.of(context).consultantDetails,
              style: const TextStyle(
                fontFamily: 'NotoSerifGeorgian',
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Provider.of<ConsultantDetailsProvider>(context, listen: false)
              .fetchDetails(id: widget.id.toString());
        },
        child: Consumer<ConsultantDetailsProvider>(
          builder: (context, provider, child) {
            print("-----------------------"+showRating.toString());
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (provider.errorMessage != null) {
              return Center(child: Text(provider.errorMessage!));
            }

            if (provider.details.isEmpty) {
              return const Center(child: Text("No consultant data available"));
            }

            final consultant = provider.details.first;
            return Padding(
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      if(showRating!= null && showRating == true)
                        RatingBar(
                          id: consultant.id,
                          onRatingUpdate: (score) async {
                            final provider = Provider.of<ConsultantReviewProvider>(
                              context,
                              listen: false,
                            );
                            await provider.makingReviews(id: consultant.id, score: score.toInt());
                          },
                        ),
                     Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${consultant.firstName!} ${consultant.lastName!}",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'NotoSerifGeorgian',
                              color: theme.primary,
                            ),
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.star, color: Colors.amber, size: 20),
                                  const SizedBox(width: 4),
                                  Text(
                                    consultant.rating.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      fontFamily: 'NotoSerifGeorgian',
                                      color: theme.surface.withOpacity(0.3),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${consultant.reviewCount} reviewers",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  fontFamily: 'NotoSerifGeorgian',
                                  color: theme.surface.withOpacity(0.3),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'NotoSerifGeorgian',
                            color: theme.surface.withOpacity(0.3),
                          ),
                          children: [
                            TextSpan(text: "${S.of(context).field}:  ", style: TextStyle(color: theme.primary)),
                            TextSpan(text: consultant.domainName),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'NotoSerifGeorgian',
                            color: theme.surface.withOpacity(0.3),
                          ),
                          children: [
                            TextSpan(text: "${S.of(context).specialization}:  ", style: TextStyle(color: theme.primary)),
                            TextSpan(text: consultant.subDomainName),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'NotoSerifGeorgian',
                            color: theme.surface.withOpacity(0.3),
                          ),
                          children: [
                            TextSpan(text: "${S.of(context).years}:  ", style: TextStyle(color: theme.primary)),
                            TextSpan(text: consultant.yearsExperience.toString()),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'NotoSerifGeorgian',
                            color: theme.surface.withOpacity(0.3),
                          ),
                          children: [
                            TextSpan(text: "${S.of(context).email}:  ", style: TextStyle(color: theme.primary)),
                            TextSpan(text: consultant.email),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'NotoSerifGeorgian',
                            color: theme.surface.withOpacity(0.3),
                          ),
                          children: [
                            TextSpan(text: "${S.of(context).fee}:  ", style: TextStyle(color: theme.primary)),
                            TextSpan(text: consultant.cost.toString() + "\$"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Text(
                    S.of(context).location,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'NotoSerifGeorgian',
                      color: theme.primary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: theme.surface.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.location_on, size: 20, color: theme.surface.withOpacity(0.3)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            consultant.location,
                            style: TextStyle(
                              color: theme.surface.withOpacity(0.3),
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              fontFamily: 'NotoSerifGeorgian',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    S.of(context).aboutMe,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'NotoSerifGeorgian',
                      color: theme.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    consultant.description,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'NotoSerifGeorgian',
                      color: theme.surface.withOpacity(0.3),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Consumer<ConsultantDetailsProvider>(
        builder: (context, provider, child) {
          if (provider.details.isEmpty) return const SizedBox();

          final consultant = provider.details.first;

          return Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, -3),
                ),
              ],
            ),
            child: Row(
              children: [
                // Chat with me button
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChatPage(consultantId: consultant.id,)),
                      );
                    },
                    child: Text(
                      S.of(context).chatWithMe,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'NotoSerifGeorgian',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Heart icon
                GestureDetector(
                  onTap: () => _toggleFavorite(consultant.id),
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color:theme.primary,
                    size: 35,
                  ),
                ),
              ],
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
