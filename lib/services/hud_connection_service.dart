import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/companion_state.dart';
import '../models/nav_destination.dart';

class HudConnectionService extends ChangeNotifier {
  CompanionState _state = CompanionState.initial();

  CompanionState get state => _state;

  Timer? _noticeTimer;

  void _showNotice(String notice) {
    _noticeTimer?.cancel();
    _state = _state.copyWith(lastStatusNotice: notice);
    notifyListeners();

    _noticeTimer = Timer(const Duration(seconds: 4), () {
      _state = _state.copyWith(lastStatusNotice: null);
      notifyListeners();
    });
  }

  Future<void> connect() async {
    if (_state.connectionStatus == HudConnectionStatus.connected) return;

    _state = _state.copyWith(connectionStatus: HudConnectionStatus.connecting);
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 1200));

    _state = _state.copyWith(
      connectionStatus: HudConnectionStatus.connected,
      lastSyncTime: DateTime.now(),
      rssi: -54,
    );
    notifyListeners();
    _showNotice('Connected to ${_state.bikeName}');
  }

  Future<void> disconnect() async {
    _state = _state.copyWith(connectionStatus: HudConnectionStatus.disconnected);
    notifyListeners();
    _showNotice('Disconnected from Bike HUD');
  }

  Future<void> toggleConnection() async {
    if (_state.connectionStatus == HudConnectionStatus.connected) {
      await disconnect();
    } else {
      await connect();
    }
  }

  Future<void> syncTelemetry() async {
    if (_state.isHudSyncing) return;

    _state = _state.copyWith(isHudSyncing: true);
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 1000));

    // Update with fresh mock ride or telemetry update
    final newOdo = _state.totalOdometerKm + 2.4;
    _state = _state.copyWith(
      isHudSyncing: false,
      totalOdometerKm: double.parse(newOdo.toStringAsFixed(1)),
      lastSyncTime: DateTime.now(),
      batteryPercent: 89,
    );
    notifyListeners();
    _showNotice('HUD telemetry synced successfully');
  }

  void sendDestinationToHud(NavDestination dest) {
    _state = _state.copyWith(activeDestination: dest);
    notifyListeners();
    _showNotice('Sent "${dest.name}" to Bike HUD Navigation');
  }

  void clearActiveDestination() {
    _state = _state.copyWith(clearDestination: true);
    notifyListeners();
    _showNotice('Navigation route cleared on HUD');
  }

  void setAccentColor(String color) {
    _state = _state.copyWith(accentColor: color);
    notifyListeners();
  }

  void toggleThemeMode() {
    _state = _state.copyWith(isDarkMode: !_state.isDarkMode);
    notifyListeners();
  }

  void toggleCallRelay(bool val) {
    _state = _state.copyWith(callRelayEnabled: val);
    notifyListeners();
    _showNotice(val ? 'Incoming call relay enabled' : 'Call relay disabled');
  }

  void toggleMusicRelay(bool val) {
    _state = _state.copyWith(musicRelayEnabled: val);
    notifyListeners();
    _showNotice(val ? 'Media session relay active' : 'Media relay disabled');
  }

  void toggleSimulationMode(bool val) {
    _state = _state.copyWith(isSimulationMode: val);
    notifyListeners();
  }

  void addCustomDestination(String name, String address) {
    final newDest = NavDestination(
      id: 'custom_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      address: address,
      distanceKm: 9.8,
      estDuration: '18 min',
      category: 'custom',
    );
    sendDestinationToHud(newDest);
  }

  @override
  void dispose() {
    _noticeTimer?.cancel();
    super.dispose();
  }
}
