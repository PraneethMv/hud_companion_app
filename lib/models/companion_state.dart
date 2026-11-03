import 'ride_summary.dart';
import 'nav_destination.dart';

enum HudConnectionStatus {
  disconnected,
  connecting,
  connected,
}

class CompanionState {
  final HudConnectionStatus connectionStatus;
  final String bikeName;
  final String vehicleModel;
  final String plateNumber;
  final int batteryPercent;
  final int fuelPercent;
  final double totalOdometerKm;
  final bool isHudSyncing;
  final DateTime lastSyncTime;
  final String accentColor; // 'emerald', 'amber', 'blue', 'purple'
  final bool isDarkMode;
  final NavDestination? activeDestination;
  final List<RideSummary> recentRides;
  final bool callRelayEnabled;
  final bool musicRelayEnabled;
  final bool isSimulationMode;
  final int rssi;
  final String hudFirmwareVersion;
  final String? lastStatusNotice;

  const CompanionState({
    this.connectionStatus = HudConnectionStatus.connected,
    this.bikeName = 'REV Smart Cockpit',
    this.vehicleModel = 'KTM Duke 390',
    this.plateNumber = 'KA-01-EQ-4299',
    this.batteryPercent = 88,
    this.fuelPercent = 74,
    this.totalOdometerKm = 14560.0,
    this.isHudSyncing = false,
    required this.lastSyncTime,
    this.accentColor = 'emerald',
    this.isDarkMode = true,
    this.activeDestination,
    this.recentRides = const [],
    this.callRelayEnabled = true,
    this.musicRelayEnabled = true,
    this.isSimulationMode = true,
    this.rssi = -58,
    this.hudFirmwareVersion = 'v1.4.2-alpha',
    this.lastStatusNotice,
  });

  static CompanionState initial() {
    return CompanionState(
      lastSyncTime: DateTime.now(),
      recentRides: const [
        RideSummary(
          id: 'ride_5',
          title: 'Night Expressway Run',
          date: 'Today, 08:30 PM',
          duration: '42 min',
          distanceKm: 24.6,
          avgSpeedKm: 46,
          topSpeedKm: 98,
          fuelUsedLiters: 1.05,
          efficiencyKmpl: 23.4,
        ),
        RideSummary(
          id: 'ride_4',
          title: 'Morning Hill Climb',
          date: 'Yesterday, 06:15 AM',
          duration: '1h 15m',
          distanceKm: 52.3,
          avgSpeedKm: 42,
          topSpeedKm: 92,
          fuelUsedLiters: 2.18,
          efficiencyKmpl: 24.0,
        ),
        RideSummary(
          id: 'ride_3',
          title: 'Urban Commute',
          date: '19 Sep, 07:45 AM',
          duration: '28 min',
          distanceKm: 16.8,
          avgSpeedKm: 34,
          topSpeedKm: 68,
          fuelUsedLiters: 0.72,
          efficiencyKmpl: 23.3,
        ),
        RideSummary(
          id: 'ride_2',
          title: 'Sunset Highway Loop',
          date: '18 Sep, 05:20 PM',
          duration: '54 min',
          distanceKm: 38.2,
          avgSpeedKm: 48,
          topSpeedKm: 89,
          fuelUsedLiters: 1.58,
          efficiencyKmpl: 24.2,
        ),
      ],
    );
  }

  CompanionState copyWith({
    HudConnectionStatus? connectionStatus,
    String? bikeName,
    String? vehicleModel,
    String? plateNumber,
    int? batteryPercent,
    int? fuelPercent,
    double? totalOdometerKm,
    bool? isHudSyncing,
    DateTime? lastSyncTime,
    String? accentColor,
    bool? isDarkMode,
    NavDestination? activeDestination,
    bool clearDestination = false,
    List<RideSummary>? recentRides,
    bool? callRelayEnabled,
    bool? musicRelayEnabled,
    bool? isSimulationMode,
    int? rssi,
    String? hudFirmwareVersion,
    String? lastStatusNotice,
  }) {
    return CompanionState(
      connectionStatus: connectionStatus ?? this.connectionStatus,
      bikeName: bikeName ?? this.bikeName,
      vehicleModel: vehicleModel ?? this.vehicleModel,
      plateNumber: plateNumber ?? this.plateNumber,
      batteryPercent: batteryPercent ?? this.batteryPercent,
      fuelPercent: fuelPercent ?? this.fuelPercent,
      totalOdometerKm: totalOdometerKm ?? this.totalOdometerKm,
      isHudSyncing: isHudSyncing ?? this.isHudSyncing,
      lastSyncTime: lastSyncTime ?? this.lastSyncTime,
      accentColor: accentColor ?? this.accentColor,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      activeDestination: clearDestination ? null : (activeDestination ?? this.activeDestination),
      recentRides: recentRides ?? this.recentRides,
      callRelayEnabled: callRelayEnabled ?? this.callRelayEnabled,
      musicRelayEnabled: musicRelayEnabled ?? this.musicRelayEnabled,
      isSimulationMode: isSimulationMode ?? this.isSimulationMode,
      rssi: rssi ?? this.rssi,
      hudFirmwareVersion: hudFirmwareVersion ?? this.hudFirmwareVersion,
      lastStatusNotice: lastStatusNotice ?? this.lastStatusNotice,
    );
  }
}

