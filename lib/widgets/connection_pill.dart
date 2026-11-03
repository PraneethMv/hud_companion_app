import 'package:flutter/material.dart';
import '../models/companion_state.dart';
import '../models/companion_theme.dart';
import '../services/hud_connection_service.dart';

class ConnectionPill extends StatelessWidget {
  final CompanionState state;
  final CompanionTheme theme;
  final HudConnectionService service;

  const ConnectionPill({
    super.key,
    required this.state,
    required this.theme,
    required this.service,
  });

  void _showConnectionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: theme.surfaceContainer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: theme.outlineVariant,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: theme.primaryContainer.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(Icons.two_wheeler_rounded, color: theme.primary, size: 28),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.bikeName,
                            style: TextStyle(
                              color: theme.onSurface,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            state.vehicleModel,
                            style: TextStyle(
                              color: theme.onSurfaceVariant,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: state.connectionStatus == HudConnectionStatus.connected
                            ? theme.statusOk.withValues(alpha: 0.15)
                            : theme.outlineVariant.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: state.connectionStatus == HudConnectionStatus.connected
                              ? theme.statusOk.withValues(alpha: 0.4)
                              : Colors.transparent,
                        ),
                      ),
                      child: Text(
                        state.connectionStatus == HudConnectionStatus.connected
                            ? 'ONLINE'
                            : 'OFFLINE',
                        style: TextStyle(
                          color: state.connectionStatus == HudConnectionStatus.connected
                              ? theme.statusOk
                              : theme.onSurfaceVariant,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: theme.cardBorder),
                  ),
                  child: Column(
                    children: [
                      _buildInfoRow('Signal RSSI', '${state.rssi} dBm (Strong)'),
                      const Divider(height: 16),
                      _buildInfoRow('HUD Firmware', state.hudFirmwareVersion),
                      const Divider(height: 16),
                      _buildInfoRow('Battery Level', '${state.batteryPercent}%'),
                      const Divider(height: 16),
                      _buildInfoRow('Protocol', 'BLE 5.2 / Wi-Fi Direct'),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                      service.toggleConnection();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: state.connectionStatus == HudConnectionStatus.connected
                          ? theme.errorContainer
                          : theme.primary,
                      foregroundColor: state.connectionStatus == HudConnectionStatus.connected
                          ? theme.onErrorContainer
                          : theme.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      state.connectionStatus == HudConnectionStatus.connected
                          ? 'Disconnect from HUD'
                          : 'Connect to Bike HUD',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(color: theme.onSurfaceVariant, fontSize: 13),
        ),
        Text(
          value,
          style: TextStyle(
            color: theme.onSurface,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isConnected = state.connectionStatus == HudConnectionStatus.connected;
    final isConnecting = state.connectionStatus == HudConnectionStatus.connecting;

    Color pillColor;
    Color dotColor;
    String statusText;

    if (isConnected) {
      pillColor = theme.primary.withValues(alpha: 0.12);
      dotColor = theme.primary;
      statusText = 'HUD Live · ${state.batteryPercent}%';
    } else if (isConnecting) {
      pillColor = theme.statusWarning.withValues(alpha: 0.12);
      dotColor = theme.statusWarning;
      statusText = 'Pairing...';
    } else {
      pillColor = theme.outlineVariant.withValues(alpha: 0.2);
      dotColor = theme.outline;
      statusText = 'Offline';
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _showConnectionSheet(context),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: pillColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isConnected ? theme.primary.withValues(alpha: 0.3) : theme.cardBorder,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                  boxShadow: isConnected
                      ? [
                          BoxShadow(
                            color: dotColor.withValues(alpha: 0.6),
                            blurRadius: 6,
                            spreadRadius: 1,
                          ),
                        ]
                      : null,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                statusText,
                style: TextStyle(
                  color: isConnected ? theme.onSurface : theme.onSurfaceVariant,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.chevron_right_rounded,
                size: 16,
                color: theme.onSurfaceVariant.withValues(alpha: 0.7),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

