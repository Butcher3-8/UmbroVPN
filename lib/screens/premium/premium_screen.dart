import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/app_strings.dart';

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({super.key});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  bool _isYearly = true;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.goPremium),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Crown icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.premiumGold.withValues(alpha: 0.2),
                    AppColors.premiumGold.withValues(alpha: 0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(
                Icons.workspace_premium_rounded,
                color: AppColors.premiumGold,
                size: 44,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Unlock Full Power',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontSize: 24,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Get access to all premium features',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 32),
            // Features list
            _FeatureItem(
              icon: Icons.speed_rounded,
              title: AppStrings.unlimitedSpeed,
              subtitle: 'No bandwidth limits',
              isDark: isDark,
            ),
            _FeatureItem(
              icon: Icons.public_rounded,
              title: AppStrings.allServersAccess,
              subtitle: 'Connect to 50+ countries',
              isDark: isDark,
            ),
            _FeatureItem(
              icon: Icons.block_rounded,
              title: AppStrings.noAds,
              subtitle: 'Enjoy ad-free experience',
              isDark: isDark,
            ),
            _FeatureItem(
              icon: Icons.headset_mic_rounded,
              title: AppStrings.prioritySupport,
              subtitle: '24/7 dedicated support',
              isDark: isDark,
            ),
            const SizedBox(height: 28),
            // Plan toggle
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : AppColors.lightBackground,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _PlanTab(
                      label: AppStrings.monthly,
                      isSelected: !_isYearly,
                      onTap: () => setState(() => _isYearly = false),
                    ),
                  ),
                  Expanded(
                    child: _PlanTab(
                      label: AppStrings.yearly,
                      isSelected: _isYearly,
                      onTap: () => setState(() => _isYearly = true),
                      badge: AppStrings.bestValue,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Price card
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: _PriceCard(
                key: ValueKey(_isYearly),
                price: _isYearly ? '\$3.99' : '\$9.99',
                period: _isYearly ? '/month billed yearly' : '/month',
                totalPrice: _isYearly ? '\$47.88/year' : null,
                isDark: isDark,
              ),
            ),
            const SizedBox(height: 20),
            // Subscribe button
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Premium coming soon!'),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  AppStrings.subscribe,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Cancel anytime. No questions asked.',
              style:
                  Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isDark;

  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.primary, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
          const Icon(Icons.check_circle_rounded,
              color: AppColors.primary, size: 20),
        ],
      ),
    );
  }
}

class _PlanTab extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final String? badge;

  const _PlanTab({
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(11),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : null,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            if (badge != null)
              Text(
                badge!,
                style: TextStyle(
                  color: isSelected
                      ? Colors.white.withValues(alpha: 0.8)
                      : AppColors.primary,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _PriceCard extends StatelessWidget {
  final String price;
  final String period;
  final String? totalPrice;
  final bool isDark;

  const _PriceCard({
    super.key,
    required this.price,
    required this.period,
    this.totalPrice,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                price,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(width: 4),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  period,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
          if (totalPrice != null) ...[
            const SizedBox(height: 4),
            Text(
              totalPrice!,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontSize: 12),
            ),
          ],
        ],
      ),
    );
  }
}
