class OutbreakItem {
  const OutbreakItem({
    required this.disease,
    required this.district,
    required this.firstReported,
    required this.casesCount,
    required this.deathsCount,
    required this.cfrPercent,
    required this.rrtStatus,
    required this.containmentStatus,
    required this.severity, // 'crit', 'high', 'med', 'low'
    required this.lastUpdate,
  });

  final String disease;
  final String district;
  final String firstReported;
  final int casesCount;
  final int deathsCount;
  final double cfrPercent;
  final String rrtStatus; // 'Deployed', 'Standby', 'En Route'
  final String containmentStatus; // 'Active', 'Monitor', 'Controlled', 'Pending'
  final String severity;
  final String lastUpdate;

  OutbreakItem copyWith({
    String? disease,
    String? district,
    String? firstReported,
    int? casesCount,
    int? deathsCount,
    double? cfrPercent,
    String? rrtStatus,
    String? containmentStatus,
    String? severity,
    String? lastUpdate,
  }) {
    return OutbreakItem(
      disease: disease ?? this.disease,
      district: district ?? this.district,
      firstReported: firstReported ?? this.firstReported,
      casesCount: casesCount ?? this.casesCount,
      deathsCount: deathsCount ?? this.deathsCount,
      cfrPercent: cfrPercent ?? this.cfrPercent,
      rrtStatus: rrtStatus ?? this.rrtStatus,
      containmentStatus: containmentStatus ?? this.containmentStatus,
      severity: severity ?? this.severity,
      lastUpdate: lastUpdate ?? this.lastUpdate,
    );
  }
}

class SurveillanceAlert {
  const SurveillanceAlert({
    required this.msg,
    required this.time,
    required this.severity, // 'crit', 'warn', 'info', 'ok'
  });

  final String msg;
  final String time;
  final String severity;
}

class DistrictDiseaseGisItem {
  const DistrictDiseaseGisItem({
    required this.name,
    required this.lat,
    required this.lng,
    required this.alert,
    required this.cases,
    required this.disease,
    required this.vaccPercent,
  });

  final String name;
  final double lat;
  final double lng;
  final String alert; // 'critical', 'high', 'medium', 'low'
  final int cases;
  final String disease;
  final int vaccPercent;
}
