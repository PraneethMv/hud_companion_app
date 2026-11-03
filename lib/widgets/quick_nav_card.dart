import 'package:flutter/material.dart';
import '../models/companion_state.dart';
import '../models/companion_theme.dart';
import '../models/nav_destination.dart';
import '../services/hud_connection_service.dart';
import 'companion_card.dart';

class QuickNavCard extends StatefulWidget {
  final CompanionState state;
  final CompanionTheme theme;
  final HudConnectionService service;

  const QuickNavCard({
    super.key,
    required this.state,
    required this.theme,
    required this.service,
  });

  @override
  State<QuickNavCard> createState() => _QuickNavCardState();
}

class _QuickNavCardState extends State<QuickNavCard> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _handleCustomSubmit() {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      widget.service.addCustomDestination(query, 'Custom Destination');
      _searchController.clear();
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final active = widget.state.activeDestination;

    return CompanionCard(
      theme: widget.theme,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: widget.theme.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.navigation_rounded, color: widget.theme.primary, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dispatch to HUD',
                      style: TextStyle(
                        color: widget.theme.onSurface,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Send route directly to bike navigation display',
                      style: TextStyle(
                        color: widget.theme.onSurfaceVariant,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          if (active != null) ...[
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: widget.theme.primaryContainer.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: widget.theme.primary.withValues(alpha: 0.35),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.turn_right_rounded, color: widget.theme.primary, size: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'ACTIVE ON HUD',
                              style: TextStyle(
                                color: widget.theme.primary,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.0,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '• ${active.estDuration}',
                              style: TextStyle(
                                color: widget.theme.onSurfaceVariant,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Text(
                          active.name,
                          style: TextStyle(
                            color: widget.theme.onSurface,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          '${active.address} · ${active.distanceKm} km',
                          style: TextStyle(
                            color: widget.theme.onSurfaceVariant,
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close_rounded, color: widget.theme.onSurfaceVariant, size: 20),
                    onPressed: widget.service.clearActiveDestination,
                    tooltip: 'Cancel HUD Route',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
          ],

          // Search Field
          Container(
            decoration: BoxDecoration(
              color: widget.theme.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: widget.theme.cardBorder),
            ),
            child: TextField(
              controller: _searchController,
              style: TextStyle(color: widget.theme.onSurface, fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Enter place, address or coordinates...',
                hintStyle: TextStyle(color: widget.theme.outline, fontSize: 13),
                prefixIcon: Icon(Icons.search_rounded, color: widget.theme.outline, size: 20),
                suffixIcon: IconButton(
                  icon: Icon(Icons.send_rounded, color: widget.theme.primary, size: 20),
                  onPressed: _handleCustomSubmit,
                  tooltip: 'Send to HUD',
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              onSubmitted: (_) => _handleCustomSubmit(),
            ),
          ),
          const SizedBox(height: 12),

          // Presets Row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: NavDestination.defaultPresets.map((preset) {
                final isSelected = active?.id == preset.id;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: InkWell(
                    onTap: () => widget.service.sendDestinationToHud(preset),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? widget.theme.primary.withValues(alpha: 0.2)
                            : widget.theme.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? widget.theme.primary
                              : widget.theme.cardBorder,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            preset.category == 'home'
                                ? Icons.home_rounded
                                : preset.category == 'work'
                                    ? Icons.work_rounded
                                    : Icons.place_rounded,
                            size: 16,
                            color: isSelected ? widget.theme.primary : widget.theme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            preset.name,
                            style: TextStyle(
                              color: isSelected ? widget.theme.primary : widget.theme.onSurface,
                              fontSize: 12,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

