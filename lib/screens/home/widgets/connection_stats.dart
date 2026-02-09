import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class ConnectionStats extends StatelessWidget {
  final String duration;
  final String download;
  final String upload;

  const ConnectionStats({
    super.key,
    required this.duration,
    required this.download,
    required this.upload,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatItem(
            icon: Icons.timer_outlined,
            label: 'Duration',
            value: duration,
          ),
          Container(
            height: 40,
            width: 1,
            color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
          ),
          _StatItem(
            icon: Icons.arrow_downward_rounded,
            label: 'Download',
            value: download,
            iconColor: AppColors.connected,
          ),
          Container(
            height: 40,
            width: 1,
            color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
          ),
          _StatItem(
            icon: Icons.arrow_upward_rounded,
            label: 'Upload',
            value: upload,
            iconColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? iconColor;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: iconColor ?? AppColors.darkTextSecondary),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 11),
        ),
      ],
    );
  }
}
