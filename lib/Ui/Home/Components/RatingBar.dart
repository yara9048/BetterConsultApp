import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RatingBar extends StatefulWidget {
  const RatingBar({
    super.key,
    required this.id,
    this.maxRating = 5,
    this.itemSize = 28,
    this.allowHalfRating = true,
    this.activeColor,
    this.inactiveColor,
    this.gap = 4,
    required this.onRatingUpdate,
  });

  final int id;
  final int maxRating;
  final double itemSize;
  final bool allowHalfRating;
  final double gap;
  final Color? activeColor;
  final Color? inactiveColor;
  final ValueChanged<double> onRatingUpdate;

  @override
  State<RatingBar> createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {
  double _rating = 0;
  bool _readOnly = false;

  @override
  void initState() {
    super.initState();
    _loadRating();
  }

  Future<void> _loadRating() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('user_id');
    if (prefs.containsKey('rating_${widget.id}_$id')) {
      setState(() {
        _rating = prefs.getDouble('rating_${widget.id}_$id') ?? 0;
        _readOnly = true;
      });
    }
  }

  Future<void> _saveRating(double value) async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('user_id');
    await prefs.setDouble('rating_${widget.id}_$id', value);
  }

  void _setByPosition(Offset localPos, double width) {
    if (_readOnly) return;
    final itemSpan = widget.itemSize + widget.gap;
    double raw = (localPos.dx / itemSpan).clamp(0, widget.maxRating.toDouble());

    double value;
    if (widget.allowHalfRating) {
      value = (raw * 2).round() / 2.0;
    } else {
      value = raw.roundToDouble();
    }
    value = value.clamp(0, widget.maxRating.toDouble());

    setState(() {
      _rating = value;
      _readOnly = true;
    });

    _saveRating(value);
    widget.onRatingUpdate(value);
  }

  @override
  Widget build(BuildContext context) {
    final active = widget.activeColor ?? Theme.of(context).colorScheme.primary;
    final inactive = widget.inactiveColor ?? Theme.of(context).disabledColor;

    Widget star(int index) {
      final starIndex = index + 1;
      IconData iconData;
      if (_rating >= starIndex) {
        iconData = Icons.star;
      } else if (_rating >= starIndex - 0.5 && widget.allowHalfRating) {
        iconData = Icons.star_half;
      } else {
        iconData = Icons.star_border;
      }
      final color = (_rating >= starIndex - (widget.allowHalfRating ? 0.5 : 1))
          ? active
          : inactive;

      return Icon(iconData, size: widget.itemSize, color: color);
    }

    final row = Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.maxRating * 2 - 1, (i) {
        if (i.isOdd) return SizedBox(width: widget.gap);
        final idx = i ~/ 2;
        return star(idx);
      }),
    );

    if (_readOnly) return row;

    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: (d) => _setByPosition(d.localPosition, constraints.maxWidth),
          onHorizontalDragUpdate: (d) =>
              _setByPosition(d.localPosition, constraints.maxWidth),
          child: row,
        );
      },
    );
  }
}
