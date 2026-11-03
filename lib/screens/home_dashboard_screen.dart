import 'package:flutter/material.dart';
import '../models/companion_state.dart';
import '../models/companion_theme.dart';
import '../services/hud_connection_service.dart';
import '../widgets/companion_card.dart';
import '../widgets/connection_pill.dart';
import '../widgets/quick_nav_card.dart';
import '../widgets/ride_card.dart';

class HomeDashboardScreen extends StatelessWidget {
  final CompanionState state;
  final CompanionTheme theme;
  final HudConnectionService service;
  final VoidCallback onNavigateToRides;

  const HomeDashboardScreen({
    super.key,
    required this.state,
    required this.theme,
    required this.service,
    required this.onNavigateToRides,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.surface,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Top App Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: theme.primary,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                'REV',
                                style: TextStyle(
                                  color: theme.onPrimary,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 13,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'COMPANION',
                              style: TextStyle(
                                color: theme.onSurface,
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Text(
                          state.vehicleModel,
                          style: TextStyle(
                            color: theme.onSurfaceVariant,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    ConnectionPill(state: state, theme: theme, service: service),
                    const SizedBox(width: 8),
                    // Sync Button
                    IconButton(
                      icon: state.isHudSyncing
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(theme.primary),
                              ),
                            )
                          : Icon(Icons.sync_rounded, color: theme.onSurfaceVariant, size: 22),
                      onPressed: service.syncTelemetry,
                      tooltip: 'Sync HUD Data',
                    ),
                  ],
                ),
              ),
            ),

            // Notification / Status Notice
            if (state.lastStatusNotice != null)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: theme.primaryContainer.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: theme.primary.withValues(alpha: 0.4)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle_outline_rounded, color: theme.primary, size: 18),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            state.lastStatusNotice!,
                            style: TextStyle(
                              color: theme.onSurface,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            // Content List
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // HUD Hero Card
                  _buildHudHeroCard(),
                  const SizedBox(height: 20),

                  // Quick Navigation Dispatch
                  QuickNavCard(state: state, theme: theme, service: service),
                  const SizedBox(height: 20),

                  // Relay & Sync Status Card
                  _buildRelayCard(),
                  const SizedBox(height: 20),

                  // Recent Ride Section Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recent Ride',
                        style: TextStyle(
                          color: theme.onSurface,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      TextButton(
                        onPressed: onNavigateToRides,
                        child: Row(
                          children: [
                            Text(
                              'View all',
                              style: TextStyle(
                                color: theme.primary,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(Icons.arrow_forward_rounded, size: 14, color: theme.primary),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  if (state.recentRides.isNotEmpty)
                    RideCard(ride: state.recentRides.first, theme: theme)
                  else
                    CompanionCard(
                      theme: theme,
                      child: Center(
                        child: Text(
                          'No recent rides recorded',
                          style: TextStyle(color: theme.onSurfaceVariant),
                        ),
                      ),
                    ),

                  const SizedBox(height: 40),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHudHeroCard() {
    final isConnected = state.connectionStatus == HudConnectionStatus.connected;

    return CompanionCard(
      theme: theme,
      padding: const EdgeInsets.all(20),
      hasGlow: isConnected,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isConnected
                      ? theme.primary.withValues(alpha: 0.15)
                      : theme.outlineVariant.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  Icons.two_wheeler_rounded,
                  color: isConnected ? theme.primary : theme.outline,
                  size: 30,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.bikeName,
                      style: TextStyle(
                        color: theme.onSurface,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${state.plateNumber} · ${isConnected ? "Synced" : "Offline"}',
                      style: TextStyle(
                        color: theme.onSurfaceVariant,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: isConnected
                      ? theme.statusOk.withValues(alpha: 0.15)
                      : theme.outlineVariant.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(
                      isConnected ? Icons.bluetooth_connected_rounded : Icons.bluetooth_disabled_rounded,
                      size: 14,
                      color: isConnected ? theme.statusOk : theme.outline,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      isConnected ? 'BLE LIVE' : 'STANDBY',
                      style: TextStyle(
                        color: isConnected ? theme.statusOk : theme.outline,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Telemetry 3-Grid
          Row(
            children: [
              Expanded(
                child: _buildTelemetryStat(
                  icon: Icons.battery_charging_full_rounded,
                  label: 'HUD BATTERY',
                  value: '${state.batteryPercent}%',
                  accentColor: state.batteryPercent > 20 ? theme.statusOk : theme.error,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildTelemetryStat(
                  icon: Icons.local_gas_station_rounded,
                  label: 'EST. FUEL',
                  value: '${state.fuelPercent}%',
                  accentColor: theme.statusWarning,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildTelemetryStat(
                  icon: Icons.speed_rounded,
                  label: 'ODOMETER',
                  value: '${(state.totalOdometerKm / 1000).toStringAsFixed(1)}k km',
                  accentColor: theme.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTelemetryStat({
    required IconData icon,
    required String label,
    required String value,
    required Color accentColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: theme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: theme.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: accentColor),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: theme.onSurfaceVariant,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.6,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              color: theme.onSurface,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRelayCard() {
    return CompanionCard(
      theme: theme,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.phonelink_ring_rounded, size: 20, color: theme.primary),
              const SizedBox(width: 10),
              Text(
                'Live Cockpit Sync',
                style: TextStyle(
                  color: theme.onSurface,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _buildRelaySwitch(
                  title: 'Incoming Calls',
                  subtitle: 'Heads-up alert banner',
                  icon: Icons.call_rounded,
                  value: state.callRelayEnabled,
                  onChanged: service.toggleCallRelay,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildRelaySwitch(
                  title: 'Media Controls',
                  subtitle: 'Spotify / Apple Music',
                  icon: Icons.music_note_rounded,
                  value: state.musicRelayEnabled,
                  onChanged: service.toggleMusicRelay,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRelaySwitch({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: value ? theme.primary.withValues(alpha: 0.3) : theme.cardBorder,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, size: 18, color: value ? theme.primary : theme.outline),
              Switch(
                value: value,
                onChanged: onChanged,
                activeThumbColor: theme.primary,
                activeTrackColor: theme.primaryContainer,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: TextStyle(
              color: theme.onSurface,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: TextStyle(
              color: theme.onSurfaceVariant,
              fontSize: 10,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
