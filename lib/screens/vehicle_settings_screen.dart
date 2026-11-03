import 'package:flutter/material.dart';
import '../models/companion_state.dart';
import '../models/companion_theme.dart';
import '../services/hud_connection_service.dart';
import '../widgets/companion_card.dart';

class VehicleSettingsScreen extends StatelessWidget {
  final CompanionState state;
  final CompanionTheme theme;
  final HudConnectionService service;

  const VehicleSettingsScreen({
    super.key,
    required this.state,
    required this.theme,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.surface,
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          children: [
            Text(
              'Vehicle & Cockpit',
              style: TextStyle(
                color: theme.onSurface,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Bike profile, connectivity, and HUD personalization',
              style: TextStyle(
                color: theme.onSurfaceVariant,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 20),

            // Vehicle Profile Card
            CompanionCard(
              theme: theme,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: theme.primary.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(Icons.two_wheeler_rounded, color: theme.primary, size: 24),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.vehicleModel,
                              style: TextStyle(
                                color: theme.onSurface,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              state.plateNumber,
                              style: TextStyle(
                                color: theme.onSurfaceVariant,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: theme.surfaceContainerHigh,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: theme.cardBorder),
                        ),
                        child: Text(
                          'DEFAULT',
                          style: TextStyle(
                            color: theme.primary,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(height: 1),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _specItem('Total Odo', '${state.totalOdometerKm.toStringAsFixed(1)} km'),
                      _specItem('Tank Size', '13.4 L'),
                      _specItem('Fuel Type', 'Petrol 95+'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // HUD Connectivity Manager
            Text(
              'HUD LINK & TELEMETRY',
              style: TextStyle(
                color: theme.outline,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 10),
            CompanionCard(
              theme: theme,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.bluetooth_searching_rounded, color: theme.primary, size: 20),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hardware Connection',
                                style: TextStyle(
                                  color: theme.onSurface,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                state.connectionStatus == HudConnectionStatus.connected
                                    ? 'Connected via BLE 5.2'
                                    : 'Disconnected',
                                style: TextStyle(color: theme.onSurfaceVariant, fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: service.toggleConnection,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: state.connectionStatus == HudConnectionStatus.connected
                              ? theme.surfaceContainerHigh
                              : theme.primary,
                          foregroundColor: state.connectionStatus == HudConnectionStatus.connected
                              ? theme.onSurface
                              : theme.onPrimary,
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: state.connectionStatus == HudConnectionStatus.connected
                                  ? theme.cardBorder
                                  : Colors.transparent,
                            ),
                          ),
                        ),
                        child: Text(
                          state.connectionStatus == HudConnectionStatus.connected
                              ? 'Disconnect'
                              : 'Connect',
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.developer_mode_rounded, color: theme.onSurfaceVariant, size: 20),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Simulation Mode',
                                style: TextStyle(
                                  color: theme.onSurface,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                'Emulate HUD hardware without physical bike',
                                style: TextStyle(color: theme.onSurfaceVariant, fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Switch(
                        value: state.isSimulationMode,
                        onChanged: service.toggleSimulationMode,
                        activeThumbColor: theme.primary,
                        activeTrackColor: theme.primaryContainer,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Appearance & HUD Sync
            Text(
              'COCKPIT APPEARANCE',
              style: TextStyle(
                color: theme.outline,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 10),
            CompanionCard(
              theme: theme,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            state.isDarkMode ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                            color: theme.primary,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Theme Mode',
                                style: TextStyle(
                                  color: theme.onSurface,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                state.isDarkMode ? 'Night Obsidian' : 'Daylight High Contrast',
                                style: TextStyle(color: theme.onSurfaceVariant, fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(
                          state.isDarkMode ? Icons.brightness_2_rounded : Icons.wb_sunny_rounded,
                          color: theme.primary,
                        ),
                        onPressed: service.toggleThemeMode,
                      ),
                    ],
                  ),
                  const Divider(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Accent Color',
                        style: TextStyle(
                          color: theme.onSurface,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Synchronized across phone and HUD cockpit',
                        style: TextStyle(color: theme.onSurfaceVariant, fontSize: 12),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          _accentColorOption('emerald', const Color(0xFF00E5A0), 'Emerald'),
                          const SizedBox(width: 10),
                          _accentColorOption('amber', const Color(0xFFFFB951), 'Amber'),
                          const SizedBox(width: 10),
                          _accentColorOption('blue', const Color(0xFF60A5FA), 'Blue'),
                          const SizedBox(width: 10),
                          _accentColorOption('purple', const Color(0xFFC084FC), 'Purple'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // About Footer
            Center(
              child: Column(
                children: [
                  Text(
                    'REV COMPANION',
                    style: TextStyle(
                      color: theme.outline,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Build v1.0.0-alpha · Tailored for Bike HUD System',
                    style: TextStyle(
                      color: theme.outlineVariant,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _specItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: theme.onSurfaceVariant, fontSize: 11),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            color: theme.onSurface,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget _accentColorOption(String colorKey, Color color, String name) {
    final isSelected = state.accentColor == colorKey;

    return Expanded(
      child: InkWell(
        onTap: () => service.setAccentColor(colorKey),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: theme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? color : theme.cardBorder,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Column(
            children: [
              Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: color.withValues(alpha: 0.5),
                            blurRadius: 8,
                            spreadRadius: 1,
                          )
                        ]
                      : null,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                name,
                style: TextStyle(
                  color: isSelected ? theme.onSurface : theme.onSurfaceVariant,
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
