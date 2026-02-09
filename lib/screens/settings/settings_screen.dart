import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../providers/theme_provider.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.settings),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          // Appearance section
          _SectionHeader(title: AppStrings.appearance),
          _buildThemeSelector(context, isDark),
          const SizedBox(height: 16),

          // Connection section
          _SectionHeader(title: AppStrings.connection),
          _buildSettingCard(
            context: context,
            isDark: isDark,
            children: [
              _buildProtocolTile(context, isDark),
              Divider(
                height: 1,
                color:
                    isDark ? AppColors.darkDivider : AppColors.lightDivider,
              ),
              _buildSwitchTile(
                context: context,
                icon: Icons.shield_outlined,
                title: AppStrings.killSwitch,
                subtitle: AppStrings.killSwitchDesc,
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
                title: AppStrings.autoConnect,
                subtitle: AppStrings.autoConnectDesc,
                value: _autoConnect,
                onChanged: (v) => setState(() => _autoConnect = v),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // About section
          _SectionHeader(title: AppStrings.about),
          _buildSettingCard(
            context: context,
            isDark: isDark,
            children: [
              _buildInfoTile(
                context: context,
                icon: Icons.info_outline_rounded,
                title: AppStrings.appName,
                trailing: AppStrings.version,
              ),
              Divider(
                height: 1,
                color:
                    isDark ? AppColors.darkDivider : AppColors.lightDivider,
              ),
              _buildInfoTile(
                context: context,
                icon: Icons.description_outlined,
                title: 'Terms of Service',
              ),
              Divider(
                height: 1,
                color:
                    isDark ? AppColors.darkDivider : AppColors.lightDivider,
              ),
              _buildInfoTile(
                context: context,
                icon: Icons.privacy_tip_outlined,
                title: 'Privacy Policy',
              ),
            ],
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildThemeSelector(BuildContext context, bool isDark) {
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
            label: AppStrings.darkMode,
            isSelected: themeProv.isDarkMode,
            onTap: () => themeProv.setThemeMode(ThemeMode.dark),
          ),
          _ThemeOption(
            icon: Icons.light_mode_rounded,
            label: AppStrings.lightMode,
            isSelected: themeProv.isLightMode,
            onTap: () => themeProv.setThemeMode(ThemeMode.light),
          ),
          _ThemeOption(
            icon: Icons.settings_suggest_rounded,
            label: AppStrings.systemMode,
            isSelected: themeProv.isSystemMode,
            onTap: () => themeProv.setThemeMode(ThemeMode.system),
          ),
        ],
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

  Widget _buildProtocolTile(BuildContext context, bool isDark) {
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
        AppStrings.protocol,
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
