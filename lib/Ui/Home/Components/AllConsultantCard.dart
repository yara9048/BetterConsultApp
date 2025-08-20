import 'package:flutter/material.dart';

class AllConsultantCard extends StatefulWidget {
  final String name;
  final int rate;
  final String specializing;
  final String fee;
  final VoidCallback onTap;
  final VoidCallback? onDelete;
  final VoidCallback? onFavoriteToggle;
  final bool isFavoriteInitial;

  const AllConsultantCard({
    Key? key,
    required this.name,
    required this.rate,
    required this.specializing,
    required this.fee,
    required this.onTap,
    this.onDelete,
    this.onFavoriteToggle,
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: widget.onTap,
      child: Stack(
        children: [
          Container(
            width: 300,
            height: 300,
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ClipOval(
                  child: Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.1),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.person,
                        size: 80,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ),
                Text(
                  widget.name,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  widget.specializing,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: theme.colorScheme.onPrimary.withOpacity(0.8),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
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
                      'Fee ${widget.fee}',
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
          // Favorite Icon
          Positioned(
            top: 10,
            right: 40,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
                if (widget.onFavoriteToggle != null) {
                  widget.onFavoriteToggle!();
                }
              },
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: theme.colorScheme.primary,
                size: 20,
              ),
            ),
          ),
          // Delete Icon
          if (widget.onDelete != null)
            Positioned(
              top: 10,
              right: 10,
              child: GestureDetector(
                onTap: widget.onDelete,
                child: Icon(
                  Icons.delete_outline,
                  color: Colors.redAccent,
                  size: 20,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
