import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '_buildCompactDropdown.dart';

class ThemeLanguageDialog extends StatefulWidget {
  final bool isDarkMode;
  final String currentLanguage;
  final void Function(bool) onThemeChanged;
  final void Function(String) onLanguageChanged;

  const ThemeLanguageDialog({
    Key? key,
    required this.isDarkMode,
    required this.currentLanguage,
    required this.onThemeChanged,
    required this.onLanguageChanged,
  }) : super(key: key);

  @override
  State<ThemeLanguageDialog> createState() => _ThemeLanguageDialogState();
}

class _ThemeLanguageDialogState extends State<ThemeLanguageDialog> {
  late bool _tempThemeMode;
  late String _tempSelectedLanguage;

  @override
  void initState() {
    super.initState();
    _tempThemeMode = widget.isDarkMode;
    _tempSelectedLanguage = widget.currentLanguage;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 12,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Container(
    decoration: BoxDecoration(
    color: Theme.of(context).colorScheme.onSurface,
    borderRadius: BorderRadius.circular(10),
    ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.85,
        ),
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              S.of(context).preferences,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
                color: colorScheme.primary,
                fontFamily: 'NotoSerifGeorgian',
              ),
            ),
            const SizedBox(height: 24),

            _buildCompactOptionRow(
              icon: Icons.brightness_6_rounded,
              label: S.of(context).theme,
              iconColor: colorScheme.primary,
              trailing: Padding(
                padding: const EdgeInsets.only(right: 30.0),
                child: Transform.scale(
                  scale: 1.3,
                  child: Switch.adaptive(
                    value: _tempThemeMode,
                    onChanged: (value) => setState(() => _tempThemeMode = value),
                    activeColor: colorScheme.primary,
                    activeTrackColor: colorScheme.primary.withOpacity(0.5),
                    inactiveThumbColor: colorScheme.primary,
                    inactiveTrackColor: colorScheme.primary.withOpacity(0.3),
                  ),),
              ),),
              const SizedBox(height: 16),

            _buildCompactOptionRow(
              icon: Icons.language_rounded,
              label: S.of(context).language,
              iconColor: colorScheme.primary,
              trailing: SizedBox(
                width: 120,
                child: CompactDropdown(
                  value: _tempSelectedLanguage,
                  items: [
                    DropdownMenuItem(
                      value: 'en',
                      child: Text(
                        S.of(context).english,
                        style: TextStyle(
                          color: colorScheme.primary,
                          fontFamily: 'NotoSerifGeorgian',
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'ar',
                      child: Text(
                        S.of(context).english,
                        style: TextStyle(
                          color: colorScheme.primary,
                          fontFamily: 'NotoSerifGeorgian',
                        ),
                      ),
                    ),
                  ],
                  onChanged: (val) {
                    if (val != null) {
                      setState(() => _tempSelectedLanguage = val);
                    }
                  },
                ),
              ),
            ),

            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Theme.of(context).colorScheme.primary),
                  ),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      foregroundColor: Theme.of(context).colorScheme.primary,
                      textStyle: const TextStyle(
                        fontFamily: 'NotoSerifGeorgian',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child:  Text(S.of(context).cancel),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      textStyle: const TextStyle(
                        fontFamily: 'NotoSerifGeorgian',
                        fontWeight: FontWeight.w600,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      widget.onThemeChanged(_tempThemeMode);
                      widget.onLanguageChanged(_tempSelectedLanguage);
                      Navigator.of(context).pop();
                    },
                    child: Text(S.of(context).apply),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildCompactOptionRow({
    required IconData icon,
    required String label,
    required Color iconColor,
    required Widget trailing,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: iconColor, size: 22),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.primary,
                fontFamily: 'NotoSerifGeorgian',
              ),
            ),
          ],
        ),
        trailing,
      ],
    );

  }
}
