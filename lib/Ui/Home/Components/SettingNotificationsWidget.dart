import 'package:flutter/material.dart';

class SettingNotificationsWidget extends StatefulWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;


  const SettingNotificationsWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap

  }) : super(key: key);

  @override
  State<SettingNotificationsWidget> createState() => _SettingNotificationsWidgetState();
}

class _SettingNotificationsWidgetState extends State<SettingNotificationsWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(widget.icon, color: theme.colorScheme.primary, size: 22),
          onPressed: widget.onTap,
          tooltip: widget.title,
        ),
      ),
    );
  }
}
