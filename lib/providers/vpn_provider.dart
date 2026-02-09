import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:openvpn_flutter/openvpn_flutter.dart';
import '../models/connection_state.dart';
import '../models/server_model.dart';

class VpnProvider extends ChangeNotifier {
  VpnConnectionState _connectionState = VpnConnectionState.disconnected;
  ServerModel? _connectedServer;
  DateTime? _connectedAt;
  Timer? _statsTimer;
  Timer? _durationTimer;

  late OpenVPN _openVPN;
  bool _engineInitialized = false;

  // Stats
  double _downloadSpeed = 0;
  double _uploadSpeed = 0;
  double _totalDownload = 0;
  double _totalUpload = 0;
  int _sessionCount = 0;

  VpnConnectionState get connectionState => _connectionState;
  ServerModel? get connectedServer => _connectedServer;
  DateTime? get connectedAt => _connectedAt;
  double get downloadSpeed => _downloadSpeed;
  double get uploadSpeed => _uploadSpeed;
  double get totalDownload => _totalDownload;
  double get totalUpload => _totalUpload;
  int get sessionCount => _sessionCount;

  bool get isConnected => _connectionState == VpnConnectionState.connected;
  bool get isConnecting => _connectionState == VpnConnectionState.connecting;
  bool get isDisconnected =>
      _connectionState == VpnConnectionState.disconnected;

  VpnProvider() {
    _initVpnEngine();
  }

  void _initVpnEngine() {
    _openVPN = OpenVPN(
      onVpnStatusChanged: _onVpnStatusChanged,
      onVpnStageChanged: _onVpnStageChanged,
    );
    _openVPN.initialize(
      groupIdentifier: 'group.com.umbrovpn',
      providerBundleIdentifier: 'com.umbrovpn.VPNExtension',
      localizedDescription: 'UmbroVPN',
    );
    _engineInitialized = true;
  }

  void _onVpnStatusChanged(VpnStatus? status) {
    if (status == null) return;
    // Parse byte counts from status if available
    final byteIn = status.byteIn ?? '0';
    final byteOut = status.byteOut ?? '0';
    debugPrint('VPN Status - In: $byteIn, Out: $byteOut');
  }

  void _onVpnStageChanged(VPNStage stage, String raw) {
    debugPrint('VPN Stage: $stage ($raw)');
    switch (stage) {
      case VPNStage.connected:
        _connectionState = VpnConnectionState.connected;
        _connectedAt = DateTime.now();
        _sessionCount++;
        _startStatsSimulation();
        _startDurationTimer();
        break;
      case VPNStage.disconnected:
        _connectionState = VpnConnectionState.disconnected;
        _stopStatsSimulation();
        _stopDurationTimer();
        _connectedAt = null;
        _downloadSpeed = 0;
        _uploadSpeed = 0;
        break;
      case VPNStage.wait_connection:
      case VPNStage.authenticating:
      case VPNStage.connecting:
      case VPNStage.prepare:
      case VPNStage.authentication:
      case VPNStage.vpn_generate_config:
      case VPNStage.get_config:
      case VPNStage.tcp_connect:
      case VPNStage.udp_connect:
      case VPNStage.assign_ip:
      case VPNStage.resolve:
        _connectionState = VpnConnectionState.connecting;
        break;
      case VPNStage.denied:
      case VPNStage.error:
        _connectionState = VpnConnectionState.error;
        _stopStatsSimulation();
        _stopDurationTimer();
        break;
      case VPNStage.disconnecting:
      case VPNStage.exiting:
        _connectionState = VpnConnectionState.disconnecting;
        break;
      case VPNStage.unknown:
        break;
    }
    notifyListeners();
  }

  String get connectionDuration {
    if (_connectedAt == null) return '00:00:00';
    final diff = DateTime.now().difference(_connectedAt!);
    final hours = diff.inHours.toString().padLeft(2, '0');
    final minutes = (diff.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (diff.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  /// Connect using OpenVPN config if available, otherwise simulate
  Future<void> connect(ServerModel server) async {
    if (_connectionState == VpnConnectionState.connecting) return;

    _connectionState = VpnConnectionState.connecting;
    _connectedServer = server;
    notifyListeners();

    // For now, simulate connection since we don't have real .ovpn configs
    // When you have real configs, use:
    // _openVPN.connect(ovpnConfig, server.country, username: '', password: '');
    await _simulateConnect();
  }

  Future<void> _simulateConnect() async {
    await Future.delayed(const Duration(seconds: 2));
    _connectionState = VpnConnectionState.connected;
    _connectedAt = DateTime.now();
    _sessionCount++;
    _startStatsSimulation();
    _startDurationTimer();
    notifyListeners();
  }

  Future<void> disconnect() async {
    if (_connectionState == VpnConnectionState.disconnected) return;

    _connectionState = VpnConnectionState.disconnecting;
    notifyListeners();

    if (_engineInitialized) {
      _openVPN.disconnect();
    }

    await Future.delayed(const Duration(milliseconds: 500));

    _stopStatsSimulation();
    _stopDurationTimer();
    _connectionState = VpnConnectionState.disconnected;
    _connectedAt = null;
    _downloadSpeed = 0;
    _uploadSpeed = 0;
    notifyListeners();
  }

  void toggleConnection(ServerModel server) {
    if (isConnected || isConnecting) {
      disconnect();
    } else {
      connect(server);
    }
  }

  void _startStatsSimulation() {
    final random = Random();
    _statsTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      _downloadSpeed = 15 + random.nextDouble() * 85;
      _uploadSpeed = 5 + random.nextDouble() * 45;
      _totalDownload += _downloadSpeed / 8;
      _totalUpload += _uploadSpeed / 8;
      notifyListeners();
    });
  }

  void _stopStatsSimulation() {
    _statsTimer?.cancel();
    _statsTimer = null;
  }

  void _startDurationTimer() {
    _durationTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      notifyListeners();
    });
  }

  void _stopDurationTimer() {
    _durationTimer?.cancel();
    _durationTimer = null;
  }

  String formatSpeed(double speed) {
    if (speed >= 1000) {
      return '${(speed / 1000).toStringAsFixed(1)} Gbps';
    }
    return '${speed.toStringAsFixed(1)} Mbps';
  }

  String formatData(double mb) {
    if (mb >= 1024) {
      return '${(mb / 1024).toStringAsFixed(2)} GB';
    }
    return '${mb.toStringAsFixed(1)} MB';
  }

  @override
  void dispose() {
    _stopStatsSimulation();
    _stopDurationTimer();
    super.dispose();
  }
}
