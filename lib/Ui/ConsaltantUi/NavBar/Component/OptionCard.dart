import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConsultationOptionCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final String value;
  final bool isSelected;
  final VoidCallback onTap;
  final ColorScheme colorScheme;

  const ConsultationOptionCard({
    super.key,
    required this.label,
    required this.icon,
    required this.value,
    required this.isSelected,
    required this.onTap,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: colorScheme.onSurface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? colorScheme.primary
                  : colorScheme.surface.withOpacity(0.4),
              width: isSelected ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 36,
                color: isSelected
                    ? colorScheme.primary
                    : colorScheme.surface.withOpacity(0.4),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isSelected
                      ? colorScheme.primary
                      : colorScheme.surface.withOpacity(0.4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
