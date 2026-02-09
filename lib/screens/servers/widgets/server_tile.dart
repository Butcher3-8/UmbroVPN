import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/server_model.dart';

class ServerTile extends StatelessWidget {
  final ServerModel server;
  final bool isSelected;
  final VoidCallback onTap;

  const ServerTile({
    super.key,
    required this.server,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: server.isPremium ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.1)
              : isDark
                  ? AppColors.darkCard
                  : AppColors.lightCard,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? AppColors.primary.withValues(alpha: 0.5)
                : isDark
                    ? AppColors.darkCardBorder
                    : AppColors.lightCardBorder,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Opacity(
          opacity: server.isPremium ? 0.5 : 1.0,
          child: Row(
            children: [
              // Flag
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.darkBackground
                      : AppColors.lightBackground,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    server.flagEmoji,
                    style: const TextStyle(fontSize: 22),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          server.city,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                        ),
                        if (server.isPremium) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color:
                                  AppColors.premiumGold.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.lock_rounded,
                                    size: 10, color: AppColors.premiumGold),
                                SizedBox(width: 2),
                                Text(
                                  'PRO',
                                  style: TextStyle(
                                    color: AppColors.premiumGold,
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      server.country,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontSize: 12),
                    ),
                  ],
                ),
              ),
              // Load indicator
              SizedBox(
                width: 32,
                child: Column(
                  children: [
                    _LoadIndicator(load: server.load),
                    const SizedBox(height: 2),
                    Text(
                      '${server.load}%',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontSize: 9),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              // Ping
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getPingColor(server.ping).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '${server.ping}ms',
                  style: TextStyle(
                    color: _getPingColor(server.ping),
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                  ),
                ),
              ),
              if (isSelected) ...[
                const SizedBox(width: 8),
                const Icon(Icons.check_circle_rounded,
                    color: AppColors.primary, size: 20),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Color _getPingColor(int ping) {
    if (ping < 50) return AppColors.connected;
    if (ping < 100) return AppColors.primary;
    return AppColors.error;
  }
}

class _LoadIndicator extends StatelessWidget {
  final int load;

  const _LoadIndicator({required this.load});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 28,
      height: 4,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(2),
        child: LinearProgressIndicator(
          value: load / 100,
          backgroundColor: Theme.of(context).dividerColor,
          valueColor: AlwaysStoppedAnimation(_getLoadColor()),
        ),
      ),
    );
  }

  Color _getLoadColor() {
    if (load < 40) return AppColors.connected;
    if (load < 70) return AppColors.primary;
    return AppColors.error;
  }
}
