import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/locale/app_translations.dart';
import '../../providers/theme_provider.dart';
import '../../providers/locale_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _killSwitch = false;
  bool _autoConnect = false;
  String _selectedProtocol = 'WireGuard';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final tr = context.watch<LocaleProvider>().tr;

    return Scaffold(
      appBar: AppBar(
        title: Text(tr('settings')),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          // Appearance section
          _SectionHeader(title: tr('appearance')),
          _buildThemeSelector(context, isDark, tr),
          const SizedBox(height: 16),

          // Language section
          _SectionHeader(title: tr('language')),
          _buildLanguageSelector(context, isDark),
          const SizedBox(height: 16),

          // Connection section
          _SectionHeader(title: tr('connection')),
          _buildSettingCard(
            context: context,
            isDark: isDark,
            children: [
              _buildProtocolTile(context, isDark, tr),
              Divider(
                height: 1,
                color:
                    isDark ? AppColors.darkDivider : AppColors.lightDivider,
              ),
              _buildSwitchTile(
                context: context,
                icon: Icons.shield_outlined,
                title: tr('killSwitch'),
                subtitle: tr('killSwitchDesc'),
                value: _killSwitch,
                onChanged: (v) => setState(() => _killSwitch = v),
              ),
              Divider(
                height: 1,
                color:
                    isDark ? AppColors.darkDivider : AppColors.lightDivider,
              ),
              _buildSwitchTile(
                context: context,
                icon: Icons.play_circle_outline_rounded,
                title: tr('autoConnect'),
                subtitle: tr('autoConnectDesc'),
                value: _autoConnect,
                onChanged: (v) => setState(() => _autoConnect = v),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // About section
          _SectionHeader(title: tr('about')),
          _buildSettingCard(
            context: context,
            isDark: isDark,
            children: [
              _buildInfoTile(
                context: context,
                icon: Icons.info_outline_rounded,
                title: tr('appName'),
                trailing: tr('version'),
              ),
              Divider(
                height: 1,
                color:
                    isDark ? AppColors.darkDivider : AppColors.lightDivider,
              ),
              _buildInfoTile(
                context: context,
                icon: Icons.description_outlined,
                title: tr('termsOfService'),
              ),
              Divider(
                height: 1,
                color:
                    isDark ? AppColors.darkDivider : AppColors.lightDivider,
              ),
              _buildInfoTile(
                context: context,
                icon: Icons.privacy_tip_outlined,
                title: tr('privacyPolicy'),
              ),
            ],
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildThemeSelector(
      BuildContext context, bool isDark, String Function(String) tr) {
    final themeProv = context.watch<ThemeProvider>();

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
        ),
      ),
      child: Row(
        children: [
          _ThemeOption(
            icon: Icons.dark_mode_rounded,
            label: tr('darkMode'),
            isSelected: themeProv.isDarkMode,
            onTap: () => themeProv.setThemeMode(ThemeMode.dark),
          ),
          _ThemeOption(
            icon: Icons.light_mode_rounded,
            label: tr('lightMode'),
            isSelected: themeProv.isLightMode,
            onTap: () => themeProv.setThemeMode(ThemeMode.light),
          ),
          _ThemeOption(
            icon: Icons.settings_suggest_rounded,
            label: tr('systemMode'),
            isSelected: themeProv.isSystemMode,
            onTap: () => themeProv.setThemeMode(ThemeMode.system),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageSelector(BuildContext context, bool isDark) {
    final localeProv = context.watch<LocaleProvider>();

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
        ),
      ),
      child: Column(
        children: AppTranslations.supportedLocales.map((localeInfo) {
          final isSelected =
              localeProv.locale.languageCode == localeInfo.locale.languageCode;

          return GestureDetector(
            onTap: () => localeProv.setLocale(localeInfo.locale),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary.withValues(alpha: 0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(11),
              ),
              child: Row(
                children: [
                  Text(
                    localeInfo.flag,
                    style: const TextStyle(fontSize: 22),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      localeInfo.name,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight:
                                isSelected ? FontWeight.w600 : FontWeight.w400,
                            fontSize: 14,
                          ),
                    ),
                  ),
                  if (isSelected)
                    const Icon(
                      Icons.check_circle_rounded,
                      color: AppColors.primary,
                      size: 20,
                    ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSettingCard({
    required BuildContext context,
    required bool isDark,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
        ),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildProtocolTile(
      BuildContext context, bool isDark, String Function(String) tr) {
    return ListTile(
      leading: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(Icons.vpn_lock_rounded,
            color: AppColors.primary, size: 20),
      ),
      title: Text(
        tr('protocol'),
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(fontWeight: FontWeight.w500, fontSize: 14),
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkBackground : AppColors.lightBackground,
          borderRadius: BorderRadius.circular(8),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _selectedProtocol,
            isDense: true,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
            items: ['WireGuard', 'OpenVPN', 'IKEv2']
                .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                .toList(),
            onChanged: (v) => setState(() => _selectedProtocol = v!),
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.primary, size: 20),
      ),
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(fontWeight: FontWeight.w500, fontSize: 14),
      ),
      subtitle: Text(
        subtitle,
        style:
            Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 11),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildInfoTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    String? trailing,
  }) {
    return ListTile(
      leading: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.primary, size: 20),
      ),
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(fontWeight: FontWeight.w500, fontSize: 14),
      ),
      trailing: trailing != null
          ? Text(
              trailing,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontSize: 12),
            )
          : const Icon(Icons.chevron_right_rounded, size: 20),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 11,
              letterSpacing: 1.2,
            ),
      ),
    );
  }
}

class _ThemeOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeOption({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(11),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.white : null,
                size: 20,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : null,
                  fontWeight: FontWeight.w500,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
