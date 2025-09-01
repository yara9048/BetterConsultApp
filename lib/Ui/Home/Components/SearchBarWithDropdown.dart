import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Models/Home/User/NavBar/SearchModel.dart';
import '../../../Providers/Home/User/NavBarProviders/SearchProvider.dart';
import '../../../generated/l10n.dart';
import '../../Auth/Register/Compoenets/text.dart';
import '../Pages/ConsultantDetails.dart';

class SearchBarWithDropdown extends StatefulWidget {
  const SearchBarWithDropdown({Key? key}) : super(key: key);

  @override
  _SearchBarWithDropdownState createState() => _SearchBarWithDropdownState();
}

class _SearchBarWithDropdownState extends State<SearchBarWithDropdown> {
  final LayerLink _layerLink = LayerLink();
  final TextEditingController _controller = TextEditingController();
  OverlayEntry? _overlayEntry;

  @override
  void dispose() {
    _controller.dispose();
    _removeOverlay();
    super.dispose();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _showOverlay(BuildContext context) {
    _removeOverlay();

    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        final provider = Provider.of<SearchProvider>(context, listen: true);
        if (_controller.text.isEmpty &&
            !provider.isLoading &&
            provider.results.isEmpty &&
            provider.errorMessage == null) {
          return const SizedBox.shrink();
        }

        return Positioned(
          width: size.width,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: Offset(0, size.height + 5),
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              child: Container(
                constraints: const BoxConstraints(maxHeight: 200),
                child: Builder(
                  builder: (_) {
                    if (provider.isLoading) {
                      return const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    if (provider.errorMessage != null) {
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          provider.errorMessage!,
                          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                        ),
                      );
                    }

                    if (provider.results.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.all(12.0),
                        child: text(label: "No results found",fontSize: 14, color: Theme.of(context).colorScheme.primary,),
                      );
                    }

                    return MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: provider.results.length,
                        itemBuilder: (context, index) {
                          final SearchModel item = provider.results[index];
                          return ListTile(
                            title: text(label: "${item.firstName} ${item.lastName}" ?? 'Unknown', fontSize: 14, color: Theme.of(context).colorScheme.primary,  ),
                            subtitle: text(label :item.domainName+"/"+item.subDomainName ?? '',fontSize: 14, color: Theme.of(context).colorScheme.secondary,),
                            onTap: () {
                              _controller.text = item.firstName ?? '';
                              _removeOverlay();
                              // Navigate to details page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ConsultantDetails(id: item.id),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SearchProvider>(context, listen: false);
    final colors = Theme.of(context).colorScheme;

    return CompositedTransformTarget(
      link: _layerLink,
      child: TextField(
        controller: _controller,
        onChanged: (value) async {
          if (value.isEmpty) {
            provider.reset();
            _removeOverlay();
          } else {
            await provider.search(query: value);
            _showOverlay(context);
          }
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).colorScheme.onSurface,
          hintText: S.of(context).searchHint,
          hintStyle: TextStyle(
            color: colors.primary, // onSurface color
            fontFamily: 'NotoSerifGeorgian',
            fontSize: 14.5,
            fontWeight: FontWeight.bold,
          ),
          prefixIcon: Icon(Icons.search, color: colors.primary),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: colors.primary, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: colors.primary, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: colors.primary, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
        style: TextStyle(
          color: colors.primary,
          fontFamily: 'NotoSerifGeorgian',
        ),
        cursorColor: colors.primary,
      ),
    );
  }
}

