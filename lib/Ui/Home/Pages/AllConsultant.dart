import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Models/Home/User/Others/GeetSubDomainsModel.dart';
import '../../../Providers/Home/User/NavBarProviders/DeleteFromFavoriiteProvider.dart';
import '../../../Providers/Home/User/NavBarProviders/AddToFavoriteProvider.dart';
import '../../../Providers/Home/User/Others/GetSubDomainsProvider.dart';
import '../../../Providers/Home/User/Others/AllConultandProvider.dart';
import '../../../generated/l10n.dart';
import '../../Auth/Register/Compoenets/text.dart';
import '../Components/AllConsultantCard.dart';
import 'ConsultantDetails.dart';
import 'GeneralChat.dart';

class AllConsultant extends StatefulWidget {
  final int id;
  final String name;
  const AllConsultant({super.key, required this.id, required this.name});

  @override
  State<AllConsultant> createState() => _AllConsultantState();
}

class _AllConsultantState extends State<AllConsultant> {
  late GetSubDomainsProvider _subDomainsProvider;
  late AllConsultantProvider _consultantProvider;

  int? selectedSubDomainId;
  String selectedSubDomainName = '';

  @override
  void initState() {
    super.initState();
    _subDomainsProvider = Provider.of<GetSubDomainsProvider>(context, listen: false);
    _consultantProvider = Provider.of<AllConsultantProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _subDomainsProvider.fetchSubDomains(id: widget.id);

      if (_subDomainsProvider.domains.isNotEmpty) {
        selectedSubDomainId = _subDomainsProvider.domains[0].id;
        selectedSubDomainName = _subDomainsProvider.domains[0].name;
        _consultantProvider.fetchConsultants(
          domainId: widget.id,
          subDomainId: selectedSubDomainId!,
        );
      }
    });
  }

  void _onSubDomainSelected(GetSubDomainsModel subDomain) {
    setState(() {
      selectedSubDomainId = subDomain.id;
      selectedSubDomainName = subDomain.name;
    });

    _consultantProvider.fetchConsultants(
      domainId: widget.id,
      subDomainId: selectedSubDomainId!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f7fa),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
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
      bottomNavigationBar: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, -2),
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
                  style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => Generalchat()),
                      );
                    },
                ),
                TextSpan(text: S.of(context).generalChat4),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Subdomains
            Consumer<GetSubDomainsProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const SizedBox(
                    height: 40,
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (provider.errorMessage != null) {
                  return Center(
                    child: text(
                      label: provider.errorMessage!,
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16,
                    ),
                  );
                } else {
                  final subDomains = provider.domains;
                  if (subDomains.isEmpty) {
                    return Center(
                      child: text(
                        label: 'No subdomains available.',
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16,
                      ),
                    );
                  }
                  return SizedBox(
                    height: 40,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: subDomains.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final subDomain = subDomains[index];
                        final isSelected = selectedSubDomainId == subDomain.id;
                        return ChoiceChip(
                          label: Text(
                            subDomain.name,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'NotoSerifGeorgian',
                            ),
                          ),
                          selected: isSelected,
                          onSelected: (_) => _onSubDomainSelected(subDomain),
                          selectedColor: Theme.of(context).colorScheme.primary,
                          backgroundColor: Theme.of(context).colorScheme.onSurface,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
            // Consultants
            Expanded(
              child: Consumer<AllConsultantProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (provider.errorMessage != null) {
                    return Center(
                      child: text(
                        label: provider.errorMessage!,
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16,
                      ),
                    );
                  } else if (provider.consultants.isEmpty) {
                    return Center(
                      child: text(
                        label: 'No consultants for this subdomain.',
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16,
                      ),
                    );
                  } else {
                    return GridView.builder(
                      itemCount: provider.consultants.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.7,
                      ),
                      itemBuilder: (context, index) {
                        final consultant = provider.consultants[index];
                        return AllConsultantCard(
                          imageUrl: consultant.photo.filePath,
                          secondName: consultant.lastName,
                          name: consultant.firstName,
                          rate: consultant.rating,
                          domain: widget.name,
                          specializing: selectedSubDomainName,
                          fee: consultant.cost.toString(),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ConsultantDetails(id: consultant.id),
                              ),
                            );
                          },
                          isFavoriteInitial: consultant.isFavorite,
                          onAddFavorite: () async {
                            final provider = Provider.of<AddToFavoriteProvider>(context, listen: false);
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
                            }
                          },
                          onRemoveFavorite: () async {
                            final provider = Provider.of<DeleteFromFavoriteProvider>(context, listen: false);
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
                            }
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
