class RideSummary {
  final String id;
  final String title;
  final String date;
  final String duration;
  final double distanceKm;
  final int avgSpeedKm;
  final int topSpeedKm;
  final double? fuelUsedLiters;
  final double? efficiencyKmpl;

  const RideSummary({
    required this.id,
    required this.title,
    required this.date,
    required this.duration,
    required this.distanceKm,
    required this.avgSpeedKm,
    required this.topSpeedKm,
    this.fuelUsedLiters,
    this.efficiencyKmpl,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'date': date,
    'duration': duration,
    'distanceKm': distanceKm,
    'avgSpeedKm': avgSpeedKm,
    'topSpeedKm': topSpeedKm,
    if (fuelUsedLiters != null) 'fuelUsedLiters': fuelUsedLiters,
    if (efficiencyKmpl != null) 'efficiencyKmpl': efficiencyKmpl,
  };

  factory RideSummary.fromJson(Map<String, dynamic> json) {
    return RideSummary(
      id: json['id'] as String? ?? 'ride_${DateTime.now().millisecondsSinceEpoch}',
      title: json['title'] as String? ?? 'Ride',
      date: json['date'] as String? ?? 'Recent',
      duration: json['duration'] as String? ?? '0 min',
      distanceKm: (json['distanceKm'] as num?)?.toDouble() ?? 0.0,
      avgSpeedKm: (json['avgSpeedKm'] as num?)?.toInt() ?? 0,
      topSpeedKm: (json['topSpeedKm'] as num?)?.toInt() ?? 0,
      fuelUsedLiters: (json['fuelUsedLiters'] as num?)?.toDouble(),
      efficiencyKmpl: (json['efficiencyKmpl'] as num?)?.toDouble(),
    );
  }
}

