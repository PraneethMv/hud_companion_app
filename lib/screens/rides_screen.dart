import 'package:flutter/material.dart';
import '../models/companion_state.dart';
import '../models/companion_theme.dart';
import '../services/hud_connection_service.dart';
import '../widgets/companion_card.dart';
import '../widgets/ride_card.dart';

class RidesScreen extends StatelessWidget {
  final CompanionState state;
  final CompanionTheme theme;
  final HudConnectionService service;

  const RidesScreen({
    super.key,
    required this.state,
    required this.theme,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate aggregate metrics
    double totalRecentKm = 0;
    int totalSpeedSum = 0;
    for (final r in state.recentRides) {
      totalRecentKm += r.distanceKm;
      totalSpeedSum += r.avgSpeedKm;
    }
    final avgSpeedOverall = state.recentRides.isNotEmpty
        ? (totalSpeedSum / state.recentRides.length).round()
        : 0;

    return Scaffold(
      backgroundColor: theme.surface,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ride Logbook',
                          style: TextStyle(
                            color: theme.onSurface,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Telemetry history synced from Bike HUD',
                          style: TextStyle(
                            color: theme.onSurfaceVariant,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.sync_rounded, color: theme.primary),
                      onPressed: service.syncTelemetry,
                      tooltip: 'Sync rides',
                    ),
                  ],
                ),
              ),
            ),

            // Top Aggregate Stats Card
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                child: CompanionCard(
                  theme: theme,
                  padding: const EdgeInsets.all(18),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildAggregateColumn(
                          'TOTAL DISTANCE',
                          '${totalRecentKm.toStringAsFixed(1)} km',
                          Icons.alt_route_rounded,
                        ),
                      ),
                      Container(width: 1, height: 40, color: theme.cardBorder),
                      Expanded(
                        child: _buildAggregateColumn(
                          'RECORDED TRIPS',
                          '${state.recentRides.length} rides',
                          Icons.history_rounded,
                        ),
                      ),
                      Container(width: 1, height: 40, color: theme.cardBorder),
                      Expanded(
                        child: _buildAggregateColumn(
                          'AVG VELOCITY',
                          '$avgSpeedOverall km/h',
                          Icons.speed_rounded,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Rides List
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final ride = state.recentRides[index];
                    return RideCard(ride: ride, theme: theme);
                  },
                  childCount: state.recentRides.length,
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 40),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAggregateColumn(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 16, color: theme.primary),
        const SizedBox(height: 6),
        Text(
          value,
          style: TextStyle(
            color: theme.onSurface,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            color: theme.onSurfaceVariant,
            fontSize: 9,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

