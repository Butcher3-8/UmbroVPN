import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../models/connection_state.dart';
import '../../providers/vpn_provider.dart';
import '../../providers/server_provider.dart';
import '../../providers/locale_provider.dart';
import 'widgets/connect_button.dart';
import 'widgets/connection_stats.dart';
import 'widgets/selected_server_card.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onServersTap;

  const HomeScreen({super.key, required this.onServersTap});

  @override
  Widget build(BuildContext context) {
    final tr = context.watch<LocaleProvider>().tr;

    return Scaffold(
      appBar: AppBar(
        title: Text(tr('appName')),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded),
          ),
        ],
      ),
      body: Consumer2<VpnProvider, ServerProvider>(
        builder: (context, vpn, serverProv, _) {
          final server = serverProv.selectedServer;
          if (server == null) return const SizedBox();

          return SafeArea(
            child: Stack(
              children: [
                // Subtle radial glow behind button
                Positioned.fill(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 600),
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: const Alignment(0, -0.15),
                        radius: 0.6,
                        colors: [
                          (vpn.isConnected
                                  ? AppColors.connected
                                  : vpn.isConnecting
                                      ? AppColors.connecting
                                      : AppColors.disconnected)
                              .withValues(alpha: 0.06),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      const Spacer(flex: 1),
                      // Connection status text
                      _buildStatusText(context, vpn.connectionState, tr),
                      const SizedBox(height: 8),
                      _buildStatusSubtitle(context, vpn.connectionState, tr),
                      const Spacer(flex: 1),
                      // Connect button
                      ConnectButton(
                        connectionState: vpn.connectionState,
                        onTap: () => vpn.toggleConnection(server),
                      ),
                      const Spacer(flex: 1),
                      // Connection stats
                      AnimatedOpacity(
                        opacity: vpn.isConnected ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 300),
                        child: ConnectionStats(
                          duration: vpn.connectionDuration,
                          download: vpn.formatSpeed(vpn.downloadSpeed),
                          upload: vpn.formatSpeed(vpn.uploadSpeed),
                          durationLabel: tr('duration'),
                          downloadLabel: tr('download'),
                          uploadLabel: tr('upload'),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Selected server card
                      SelectedServerCard(
                        server: server,
                        onTap: onServersTap,
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatusText(
      BuildContext context, VpnConnectionState state, String Function(String) tr) {
    String text;
    Color color;

    switch (state) {
      case VpnConnectionState.connected:
        text = tr('connected');
        color = AppColors.connected;
        break;
      case VpnConnectionState.connecting:
        text = tr('connecting');
        color = AppColors.connecting;
        break;
      case VpnConnectionState.disconnecting:
        text = tr('disconnecting');
        color = AppColors.connecting;
        break;
      case VpnConnectionState.disconnected:
      case VpnConnectionState.error:
        text = tr('disconnected');
        color = AppColors.disconnected;
        break;
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Text(
        text,
        key: ValueKey(text),
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: color,
              fontSize: 22,
            ),
      ),
    );
  }

  Widget _buildStatusSubtitle(
      BuildContext context, VpnConnectionState state, String Function(String) tr) {
    final isConnected = state == VpnConnectionState.connected;
    return Text(
      isConnected ? tr('tapToDisconnect') : tr('tapToConnect'),
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14),
    );
  }
}
