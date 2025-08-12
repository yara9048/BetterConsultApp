import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CompactDropdown<T> extends StatelessWidget {
  final T value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;

  const CompactDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Center(
        child: DropdownButton<T>(
          value: value,
          items: items,
          onChanged: onChanged,
          isDense: true,
          isExpanded: true,
          underline: const SizedBox.shrink(),
          icon: Icon(Icons.arrow_drop_down,
              color: Theme.of(context).colorScheme.primary),
          dropdownColor: Colors.white,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontFamily: 'NotoSerifGeorgian',
          ),
        ),
      ),
    );
  }
}
