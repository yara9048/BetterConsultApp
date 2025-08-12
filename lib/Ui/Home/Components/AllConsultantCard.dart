import 'package:flutter/material.dart';

class AllConsultantCard extends StatefulWidget {
  final String name;
  final String imageUrl;
  final double rate;
  final String specializing;
  final String fee;
  final VoidCallback onTap;

  const AllConsultantCard({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.rate,
    required this.specializing,
    required this.fee,
    required this.onTap,
  }) : super(key: key);

  @override
  State<AllConsultantCard> createState() => _AllConsultantCardState();
}

class _AllConsultantCardState extends State<AllConsultantCard> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: widget.onTap,
      child: Stack(
        children:[ Container(
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
                  width: 110, // Make sure width == height for a perfect circle
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
              // Name
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
              // Rating & Fee Row
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
          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
              },
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Theme.of(context).colorScheme.primary ,
                size: 20,
              ),
            ),
          ),

        ]),
    );
  }
}
