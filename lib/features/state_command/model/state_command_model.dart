import 'package:flutter/material.dart';

class DistrictScorecardItem {
  const DistrictScorecardItem({
    required this.name,
    required this.facilitiesCount,
    required this.dailyOpd,
    required this.bedOccupancyPercent,
    required this.icuOccupancyPercent,
    required this.mmr,
    required this.abClaimsCount,
    required this.medicineAvailabilityPercent,
    required this.performance,
    required this.score,
  });

  final String name;
  final int facilitiesCount;
  final int dailyOpd;
  final int bedOccupancyPercent;
  final int icuOccupancyPercent;
  final int mmr;
  final int abClaimsCount;
  final int medicineAvailabilityPercent;
  final String performance; // Good, Average, Critical, Poor
  final int score;

  DistrictScorecardItem copyWith({
    String? name,
    int? facilitiesCount,
    int? dailyOpd,
    int? bedOccupancyPercent,
    int? icuOccupancyPercent,
    int? mmr,
    int? abClaimsCount,
    int? medicineAvailabilityPercent,
    String? performance,
    int? score,
  }) {
    return DistrictScorecardItem(
      name: name ?? this.name,
      facilitiesCount: facilitiesCount ?? this.facilitiesCount,
      dailyOpd: dailyOpd ?? this.dailyOpd,
      bedOccupancyPercent: bedOccupancyPercent ?? this.bedOccupancyPercent,
      icuOccupancyPercent: icuOccupancyPercent ?? this.icuOccupancyPercent,
      mmr: mmr ?? this.mmr,
      abClaimsCount: abClaimsCount ?? this.abClaimsCount,
      medicineAvailabilityPercent:
          medicineAvailabilityPercent ?? this.medicineAvailabilityPercent,
      performance: performance ?? this.performance,
      score: score ?? this.score,
    );
  }
}

class LiveAlertItem {
  const LiveAlertItem({
    required this.icon,
    required this.cls, // 'crit', 'warn', 'info', 'ok'
    required this.title,
    required this.description,
    required this.time,
  });

  final String icon;
  final String cls;
  final String title;
  final String description;
  final String time;
}

class StaffRecord {
  const StaffRecord({
    required this.role,
    required this.total,
    required this.avail,
    required this.color,
  });

  final String role;
  final int total;
  final int avail;
  final Color color;
}
