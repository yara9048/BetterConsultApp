import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled6/Providers/Home/User/NavBarProviders/DeleteFromFavoriiteProvider.dart';
import '../../../../Models/Home/User/NavBar/GeetSubDomainsModel.dart';
import '../../../Providers/Home/User/NavBarProviders/AddToFavoriteProvider.dart';
import '../../../Providers/Home/User/NavBarProviders/GetSubDomainsProvider.dart';
import '../../../Providers/Home/User/Others/AllConultandProvider.dart';
import '../../../generated/l10n.dart';
import '../../Auth/Register/Compoenets/text.dart';
import '../Components/AllConsultantCard.dart';
import 'ConsultantDetails.dart';

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
  String? selectedSubDomainName;

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
        _consultantProvider.fetchConsultant(
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

    _consultantProvider.fetchConsultant(
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
            padding: EdgeInsets.only(right: 50.0, left: 50),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<GetSubDomainsProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const SizedBox(
                    height: 40,
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (provider.errorMessage != null) {
                  return Center(
                    child: Text(provider.errorMessage!,
                        style: TextStyle(color: Theme.of(context).colorScheme.error)),
                  );
                } else {
                  final subDomains = provider.domains;

                  if (subDomains.isEmpty) return const SizedBox();

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
            Expanded(
              child: Consumer<AllConsultantProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (provider.errorMessage != null) {
                    return Center(
                      child: Text(provider.errorMessage!,
                          style: TextStyle(color: Theme.of(context).colorScheme.error)),
                    );
                  } else if (provider.consultants.isEmpty) {
                    return Center(
                      child: Text(
                        'No Consultants Found',
                        style: TextStyle(
                          fontSize: 25,
                          color: Theme.of(context).colorScheme.primary,
                        ),
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
                          name: consultant.location,
                          rate: consultant.rating,
                          specializing: widget.name,
                          fee: consultant.cost.toString(),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ConsultantDetails(id: consultant.id)),
                            );
                          },
                          isFavoriteInitial: false,
                          onFavoriteToggle: () async {
                            final provider = Provider.of<AddToFavoriteProvider>(context, listen: false);
                            await provider.addToFavorite(consultant.id);
                            if (provider.isVerified) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: text(
                                    label:'Added to favorites!',
                                    fontSize: 14,
                                    color: Theme.of(context).colorScheme.onSurface,
                                  ),
                                  backgroundColor: Theme.of(context).colorScheme.secondary,
                                ),
                              );
                            } else if (provider.errorMessage != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: text(
                                    label:'Error',
                                    fontSize: 14,
                                    color: Theme.of(context).colorScheme.onSurface,
                                  ),
                                  backgroundColor: Theme.of(context).colorScheme.secondary,
                                ),
                              );
                            }
                          },
                          onDelete: () async {
                            final provider = Provider.of<DeleteFromFavoriteProvider>(context, listen: false);
                            await provider.deleteFromFavorite(consultant.id);
                            if (provider.isVerified) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: text(
                                    label:'Removed from favorites!',
                                    fontSize: 14,
                                    color: Theme.of(context).colorScheme.onSurface,
                                  ),
                                  backgroundColor: Theme.of(context).colorScheme.secondary,
                                ),
                              );
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
            ),
          ],
        ),
      ),
    );
  }
}
