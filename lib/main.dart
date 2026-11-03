import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models/companion_theme.dart';
import 'services/hud_connection_service.dart';
import 'screens/home_dashboard_screen.dart';
import 'screens/rides_screen.dart';
import 'screens/vehicle_settings_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const RevCompanionApp());
}

class RevCompanionApp extends StatefulWidget {
  const RevCompanionApp({super.key});

  @override
  State<RevCompanionApp> createState() => _RevCompanionAppState();
}

class _RevCompanionAppState extends State<RevCompanionApp> {
  final HudConnectionService _connectionService = HudConnectionService();

  @override
  void dispose() {
    _connectionService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _connectionService,
      builder: (context, _) {
        final state = _connectionService.state;
        final baseTheme = state.isDarkMode ? CompanionTheme.dark : CompanionTheme.light;
        final theme = baseTheme.withAccent(state.accentColor, isDark: state.isDarkMode);

        return MaterialApp(
          title: 'REV Companion',
          debugShowCheckedModeBanner: false,
          theme: theme.toThemeData(isDark: state.isDarkMode),
          home: MainScaffold(
            service: _connectionService,
            theme: theme,
          ),
        );
      },
    );
  }
}

class MainScaffold extends StatefulWidget {
  final HudConnectionService service;
  final CompanionTheme theme;

  const MainScaffold({
    super.key,
    required this.service,
    required this.theme,
  });

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  void _onNavigateToRides() {
    setState(() {
      _currentIndex = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.service.state;

    final screens = [
      HomeDashboardScreen(
        state: state,
        theme: widget.theme,
        service: widget.service,
        onNavigateToRides: _onNavigateToRides,
      ),
      RidesScreen(
        state: state,
        theme: widget.theme,
        service: widget.service,
      ),
      VehicleSettingsScreen(
        state: state,
        theme: widget.theme,
        service: widget.service,
      ),
    ];

    return Scaffold(
      backgroundColor: widget.theme.surface,
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: widget.theme.surfaceContainer,
          border: Border(
            top: BorderSide(
              color: widget.theme.cardBorder,
              width: 1,
            ),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _navItem(
                  index: 0,
                  icon: Icons.dashboard_rounded,
                  activeIcon: Icons.dashboard_rounded,
                  label: 'Cockpit',
                ),
                _navItem(
                  index: 1,
                  icon: Icons.alt_route_rounded,
                  activeIcon: Icons.alt_route_rounded,
                  label: 'Rides',
                ),
                _navItem(
                  index: 2,
                  icon: Icons.tune_rounded,
                  activeIcon: Icons.tune_rounded,
                  label: 'Vehicle',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem({
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
  }) {
    final isSelected = _currentIndex == index;

    return InkWell(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? widget.theme.primary.withValues(alpha: 0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              size: 22,
              color: isSelected ? widget.theme.primary : widget.theme.onSurfaceVariant,
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: widget.theme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
