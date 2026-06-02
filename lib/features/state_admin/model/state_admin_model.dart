class DistrictOverviewItem {
  const DistrictOverviewItem({
    required this.name,
    required this.facilitiesCount,
    required this.dailyOpd,
    required this.bedOccupancyPercent,
    required this.mmr,
    required this.abClaimsCount,
    required this.score,
    required this.performance, // 'Good', 'Average', 'Critical', 'Poor'
  });

  final String name;
  final int facilitiesCount;
  final int dailyOpd;
  final int bedOccupancyPercent;
  final int mmr;
  final int abClaimsCount;
  final int score;
  final String performance;

  DistrictOverviewItem copyWith({
    String? name,
    int? facilitiesCount,
    int? dailyOpd,
    int? bedOccupancyPercent,
    int? mmr,
    int? abClaimsCount,
    int? score,
    String? performance,
  }) {
    return DistrictOverviewItem(
      name: name ?? this.name,
      facilitiesCount: facilitiesCount ?? this.facilitiesCount,
      dailyOpd: dailyOpd ?? this.dailyOpd,
      bedOccupancyPercent: bedOccupancyPercent ?? this.bedOccupancyPercent,
      mmr: mmr ?? this.mmr,
      abClaimsCount: abClaimsCount ?? this.abClaimsCount,
      score: score ?? this.score,
      performance: performance ?? this.performance,
    );
  }
}

class AdminAlert {
  const AdminAlert({
    required this.msg,
    required this.time,
    required this.severity, // 'crit', 'warn', 'info'
  });

  final String msg;
  final String time;
  final String severity;
}

class StateAdminKpis {
  const StateAdminKpis({
    required this.totalFacilities,
    required this.opdToday,
    required this.ipdAdmissions,
    required this.emergencies24h,
    required this.revenueMtdCr,
    required this.abBeneficiaries,
    required this.maternalDeathsMtd,
    required this.activeDoctors,
    required this.ambulanceCalls24h,
    required this.labTests24h,
    required this.deliveriesMtd,
    required this.abClaimsPending,
  });

  final int totalFacilities;
  final int opdToday;
  final int ipdAdmissions;
  final int emergencies24h;
  final double revenueMtdCr;
  final int abBeneficiaries;
  final int maternalDeathsMtd;
  final int activeDoctors;
  final int ambulanceCalls24h;
  final int labTests24h;
  final int deliveriesMtd;
  final int abClaimsPending;
}
