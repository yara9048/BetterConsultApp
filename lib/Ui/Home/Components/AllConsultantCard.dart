import 'package:flutter/material.dart';

class AllConsultantCard extends StatefulWidget {
  final String name;
  final String secondName;
  final String domain;
  final int rate;
  final String specializing;
  final String fee;
  final VoidCallback onTap;
  final Future<void> Function()? onAddFavorite;   // new
  final Future<void> Function()? onRemoveFavorite;
  final String imageUrl;// new
  final bool isFavoriteInitial;

  const AllConsultantCard({
    Key? key,
    required this.name,
    required this.secondName,
    required this.rate,
    required this.domain,
    required this.specializing,
    required this.fee,
    required this.onTap,
    this.onAddFavorite,
    this.onRemoveFavorite,
    required this.imageUrl,
    this.isFavoriteInitial = false,
  }) : super(key: key);

  @override
  State<AllConsultantCard> createState() => _AllConsultantCardState();
}

class _AllConsultantCardState extends State<AllConsultantCard> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavoriteInitial;
  }

  Future<void> _toggleFavorite() async {
    setState(() {
      isFavorite = !isFavorite;
    });

    if (isFavorite && widget.onAddFavorite != null) {
      await widget.onAddFavorite!();
    } else if (!isFavorite && widget.onRemoveFavorite != null) {
      await widget.onRemoveFavorite!();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: widget.onTap,
      child: Stack(
        children: [
          Container(
            width: 300,
            height: 280,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: theme.colorScheme.onSurface,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                SizedBox(height: 10,),
                ClipOval(
                  child: Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.1),
                    ),
                    child: widget.imageUrl != null && widget.imageUrl!.isNotEmpty
                        ? Image.network(
                      widget.imageUrl!,
                      fit: BoxFit.cover,
                    )
                        : Icon(
                      Icons.person,
                      size: 80,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  widget.name +" "+ widget.secondName,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  widget.domain+" / "+widget.specializing,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: theme.colorScheme.onPrimary,
                  ),
                  maxLines: 1,
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.star_rounded, color: Colors.amber, size: 14),
                        const SizedBox(width: 2),
                        Text(
                          widget.rate.toStringAsFixed(1),
                          style: TextStyle(
                            fontSize: 12,
                            color: theme.colorScheme.onPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${widget.fee}\$',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Favorite (Add/Remove)
          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              onTap: _toggleFavorite,
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: theme.colorScheme.primary,
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
