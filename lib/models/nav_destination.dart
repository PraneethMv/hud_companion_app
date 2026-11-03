class NavDestination {
  final String id;
  final String name;
  final String address;
  final double distanceKm;
  final String estDuration;
  final String category; // 'home', 'work', 'favorite', 'custom'

  const NavDestination({
    required this.id,
    required this.name,
    required this.address,
    required this.distanceKm,
    required this.estDuration,
    this.category = 'custom',
  });

  static const List<NavDestination> defaultPresets = [
    NavDestination(
      id: 'dest_home',
      name: 'Home',
      address: 'Indiranagar 12th Main Rd',
      distanceKm: 4.8,
      estDuration: '14 min',
      category: 'home',
    ),
    NavDestination(
      id: 'dest_work',
      name: 'Office Tech Park',
      address: 'Outer Ring Rd, Bellandur',
      distanceKm: 16.4,
      estDuration: '32 min',
      category: 'work',
    ),
    NavDestination(
      id: 'dest_canyon',
      name: 'Nandi Foothills',
      address: 'SH 104, Chikkaballapur',
      distanceKm: 54.2,
      estDuration: '1h 10m',
      category: 'favorite',
    ),
    NavDestination(
      id: 'dest_cafe',
      name: 'Riders Roost Café',
      address: 'Lavelle Road',
      distanceKm: 8.5,
      estDuration: '22 min',
      category: 'favorite',
    ),
  ];
}

