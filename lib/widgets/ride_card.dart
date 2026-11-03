import 'package:flutter/material.dart';
import '../models/companion_theme.dart';
import '../models/ride_summary.dart';
import 'companion_card.dart';

class RideCard extends StatelessWidget {
  final RideSummary ride;
  final CompanionTheme theme;

  const RideCard({
    super.key,
    required this.ride,
    required this.theme,
  });

  void _showRideDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: theme.surfaceContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(color: theme.cardBorder),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: theme.primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.two_wheeler_rounded, color: theme.primary, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ride.title,
                    style: TextStyle(
                      color: theme.onSurface,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    ride.date,
                    style: TextStyle(color: theme.onSurfaceVariant, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: theme.cardBorder),
              ),
              child: Column(
                children: [
                  _detailMetricRow('Total Distance', '${ride.distanceKm} km', Icons.route_rounded),
                  const Divider(height: 16),
                  _detailMetricRow('Duration', ride.duration, Icons.timer_outlined),
                  const Divider(height: 16),
                  _detailMetricRow('Average Speed', '${ride.avgSpeedKm} km/h', Icons.speed_rounded),
                  const Divider(height: 16),
                  _detailMetricRow('Top Speed', '${ride.topSpeedKm} km/h', Icons.bolt_rounded),
                  if (ride.efficiencyKmpl != null) ...[
                    const Divider(height: 16),
                    _detailMetricRow(
                      'Fuel Mileage',
                      '${ride.efficiencyKmpl} km/L',
                      Icons.local_gas_station_rounded,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Close', style: TextStyle(color: theme.primary, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _detailMetricRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 18, color: theme.primary),
        const SizedBox(width: 10),
        Text(label, style: TextStyle(color: theme.onSurfaceVariant, fontSize: 13)),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            color: theme.onSurface,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompanionCard(
      theme: theme,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      margin: const EdgeInsets.only(bottom: 12),
      onTap: () => _showRideDetails(context),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: theme.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: theme.cardBorder),
            ),
            child: Icon(Icons.two_wheeler_rounded, color: theme.primary, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ride.title,
                  style: TextStyle(
                    color: theme.onSurface,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Text(
                      ride.date,
                      style: TextStyle(color: theme.onSurfaceVariant, fontSize: 12),
                    ),
                    Text(
                      ' · ${ride.duration}',
                      style: TextStyle(color: theme.onSurfaceVariant, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${ride.distanceKm} km',
                style: TextStyle(
                  color: theme.onSurface,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 2),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: theme.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'avg ${ride.avgSpeedKm} km/h',
                  style: TextStyle(
                    color: theme.primary,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
