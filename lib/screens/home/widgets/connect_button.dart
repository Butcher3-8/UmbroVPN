import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/connection_state.dart';

class ConnectButton extends StatefulWidget {
  final VpnConnectionState connectionState;
  final VoidCallback onTap;

  const ConnectButton({
    super.key,
    required this.connectionState,
    required this.onTap,
  });

  @override
  State<ConnectButton> createState() => _ConnectButtonState();
}

class _ConnectButtonState extends State<ConnectButton>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _scaleController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeOut),
    );

    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );

    _updateAnimation();
  }

  @override
  void didUpdateWidget(ConnectButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.connectionState != widget.connectionState) {
      _updateAnimation();
    }
  }

  void _updateAnimation() {
    if (widget.connectionState == VpnConnectionState.connecting) {
      _pulseController.repeat(reverse: true);
    } else if (widget.connectionState == VpnConnectionState.connected) {
      _pulseController.stop();
      _pulseController.value = 0;
    } else {
      _pulseController.stop();
      _pulseController.value = 0;
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  Color get _buttonColor {
    switch (widget.connectionState) {
      case VpnConnectionState.connected:
        return AppColors.connected;
      case VpnConnectionState.connecting:
      case VpnConnectionState.disconnecting:
        return AppColors.connecting;
      case VpnConnectionState.disconnected:
      case VpnConnectionState.error:
        return AppColors.disconnected;
    }
  }

  Color get _glowColor {
    switch (widget.connectionState) {
      case VpnConnectionState.connected:
        return AppColors.connected;
      case VpnConnectionState.connecting:
      case VpnConnectionState.disconnecting:
        return AppColors.connecting;
      case VpnConnectionState.disconnected:
      case VpnConnectionState.error:
        return AppColors.disconnected;
    }
  }

  IconData get _icon {
    switch (widget.connectionState) {
      case VpnConnectionState.connected:
        return Icons.power_settings_new_rounded;
      case VpnConnectionState.connecting:
      case VpnConnectionState.disconnecting:
        return Icons.sync_rounded;
      case VpnConnectionState.disconnected:
      case VpnConnectionState.error:
        return Icons.power_settings_new_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _scaleController.forward(),
      onTapUp: (_) {
        _scaleController.reverse();
        widget.onTap();
      },
      onTapCancel: () => _scaleController.reverse(),
      child: AnimatedBuilder(
        animation: Listenable.merge([_pulseAnimation, _scaleAnimation]),
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: SizedBox(
              width: 180,
              height: 180,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Outer pulse ring
                  if (widget.connectionState == VpnConnectionState.connecting)
                    Transform.scale(
                      scale: _pulseAnimation.value,
                      child: Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _glowColor.withValues(
                            alpha: 0.15 * (1.3 - _pulseAnimation.value) / 0.3,
                          ),
                        ),
                      ),
                    ),
                  // Glow effect
                  Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: _glowColor.withValues(alpha: 0.3),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                  ),
                  // Outer ring
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _buttonColor.withValues(alpha: 0.3),
                        width: 3,
                      ),
                    ),
                  ),
                  // Main button
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          _buttonColor,
                          _buttonColor.withValues(alpha: 0.7),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: _buttonColor.withValues(alpha: 0.4),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Icon(
                      _icon,
                      color: Colors.white,
                      size: 48,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
