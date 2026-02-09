import 'package:flutter/material.dart';
import '../models/server_model.dart';

class ServerProvider extends ChangeNotifier {
  List<ServerModel> _servers = [];
  ServerModel? _selectedServer;
  String _searchQuery = '';

  List<ServerModel> get servers => _servers;
  ServerModel? get selectedServer => _selectedServer;
  String get searchQuery => _searchQuery;

  ServerProvider() {
    _loadServers();
  }

  void _loadServers() {
    _servers = ServerModel.sampleServers;
    // Default to fastest free server
    _selectedServer = fastestFreeServer;
    notifyListeners();
  }

  ServerModel get fastestFreeServer {
    final freeServers = _servers.where((s) => !s.isPremium).toList();
    freeServers.sort((a, b) => a.ping.compareTo(b.ping));
    return freeServers.first;
  }

  List<ServerModel> get filteredServers {
    if (_searchQuery.isEmpty) return _servers;
    final query = _searchQuery.toLowerCase();
    return _servers
        .where((s) =>
            s.country.toLowerCase().contains(query) ||
            s.city.toLowerCase().contains(query))
        .toList();
  }

  Map<String, List<ServerModel>> get groupedServers {
    final map = <String, List<ServerModel>>{};
    for (final server in filteredServers) {
      map.putIfAbsent(server.country, () => []).add(server);
    }
    return map;
  }

  List<ServerModel> get freeServers =>
      _servers.where((s) => !s.isPremium).toList();

  List<ServerModel> get premiumServers =>
      _servers.where((s) => s.isPremium).toList();

  void selectServer(ServerModel server) {
    _selectedServer = server;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void selectFastest() {
    _selectedServer = fastestFreeServer;
    notifyListeners();
  }
}
