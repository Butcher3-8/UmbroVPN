import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/app_strings.dart';
import 'providers/theme_provider.dart';
import 'screens/home/home_screen.dart';
import 'screens/servers/server_list_screen.dart';
import 'screens/premium/premium_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/settings/settings_screen.dart';
import 'widgets/bottom_nav_bar.dart';

class UmbroVPNApp extends StatelessWidget {
  const UmbroVPNApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProv, _) {
        return MaterialApp(
          title: AppStrings.appName,
          debugShowCheckedModeBanner: false,
          themeMode: themeProv.themeMode,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          home: const MainShell(),
        );
      },
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  void _onTabTap(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        child: _buildScreen(),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTap,
      ),
    );
  }

  Widget _buildScreen() {
    switch (_currentIndex) {
      case 0:
        return HomeScreen(
          key: const ValueKey('home'),
          onServersTap: () => _onTabTap(1),
        );
      case 1:
        return const ServerListScreen(key: ValueKey('servers'));
      case 2:
        return const PremiumScreen(key: ValueKey('premium'));
      case 3:
        return ProfileScreen(
          key: const ValueKey('profile'),
          onPremiumTap: () => _onTabTap(2),
        );
      case 4:
        return const SettingsScreen(key: ValueKey('settings'));
      default:
        return HomeScreen(
          key: const ValueKey('home'),
          onServersTap: () => _onTabTap(1),
        );
    }
  }
}
