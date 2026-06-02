class HospitalPerformanceKpis {
  const HospitalPerformanceKpis({
    required this.activeHospitals,
    required this.totalBeds,
    required this.bedOccupancyPercent,
    required this.icuOccupancyPercent,
    required this.otUtilisationPercent,
    required this.ventilatorUtilisationPercent,
    required this.dailyOpd,
    required this.dailyIpdAdmissions,
    required this.dailyDischarges,
    required this.surgeriesToday,
    required this.avgLengthOfStay,
    required this.referralsOutMtd,
    required this.patientSatisfactionScore,
    required this.readmissionRate30Day,
    required this.hospitalAcquiredInfectionsRate,
    required this.nabhAccreditedCount,
    required this.equipmentUptimePercent,
  });

  final int activeHospitals;
  final int totalBeds;
  final double bedOccupancyPercent;
  final double icuOccupancyPercent;
  final double otUtilisationPercent;
  final double ventilatorUtilisationPercent;
  final int dailyOpd;
  final int dailyIpdAdmissions;
  final int dailyDischarges;
  final int surgeriesToday;
  final double avgLengthOfStay;
  final int referralsOutMtd;
  final double patientSatisfactionScore;
  final double readmissionRate30Day;
  final double hospitalAcquiredInfectionsRate;
  final int nabhAccreditedCount;
  final double equipmentUptimePercent;

  HospitalPerformanceKpis copyWith({
    int? activeHospitals,
    int? totalBeds,
    double? bedOccupancyPercent,
    double? icuOccupancyPercent,
    double? otUtilisationPercent,
    double? ventilatorUtilisationPercent,
    int? dailyOpd,
    int? dailyIpdAdmissions,
    int? dailyDischarges,
    int? surgeriesToday,
    double? avgLengthOfStay,
    int? referralsOutMtd,
    double? patientSatisfactionScore,
    double? readmissionRate30Day,
    double? hospitalAcquiredInfectionsRate,
    int? nabhAccreditedCount,
    double? equipmentUptimePercent,
  }) {
    return HospitalPerformanceKpis(
      activeHospitals: activeHospitals ?? this.activeHospitals,
      totalBeds: totalBeds ?? this.totalBeds,
      bedOccupancyPercent: bedOccupancyPercent ?? this.bedOccupancyPercent,
      icuOccupancyPercent: icuOccupancyPercent ?? this.icuOccupancyPercent,
      otUtilisationPercent: otUtilisationPercent ?? this.otUtilisationPercent,
      ventilatorUtilisationPercent:
          ventilatorUtilisationPercent ?? this.ventilatorUtilisationPercent,
      dailyOpd: dailyOpd ?? this.dailyOpd,
      dailyIpdAdmissions: dailyIpdAdmissions ?? this.dailyIpdAdmissions,
      dailyDischarges: dailyDischarges ?? this.dailyDischarges,
      surgeriesToday: surgeriesToday ?? this.surgeriesToday,
      avgLengthOfStay: avgLengthOfStay ?? this.avgLengthOfStay,
      referralsOutMtd: referralsOutMtd ?? this.referralsOutMtd,
      patientSatisfactionScore:
          patientSatisfactionScore ?? this.patientSatisfactionScore,
      readmissionRate30Day: readmissionRate30Day ?? this.readmissionRate30Day,
      hospitalAcquiredInfectionsRate:
          hospitalAcquiredInfectionsRate ?? this.hospitalAcquiredInfectionsRate,
      nabhAccreditedCount: nabhAccreditedCount ?? this.nabhAccreditedCount,
      equipmentUptimePercent:
          equipmentUptimePercent ?? this.equipmentUptimePercent,
    );
  }
}

class HospitalScorecardItem {
  const HospitalScorecardItem({
    required this.name,
    required this.type,
    required this.beds,
    required this.occupancyPercent,
    required this.opdPerDay,
    required this.surgeriesPerMonth,
    required this.avgLos,
    required this.csat,
    required this.readmissionPercent,
    required this.equipmentUptimePercent,
    required this.nabhAccredited,
    required this.grade,
  });

  final String name;
  final String type;
  final int beds;
  final int occupancyPercent;
  final int opdPerDay;
  final int surgeriesPerMonth;
  final double avgLos;
  final double csat;
  final double readmissionPercent;
  final double equipmentUptimePercent;
  final bool nabhAccredited;
  final String grade; // 'A', 'B', 'C', 'D'

  HospitalScorecardItem copyWith({
    String? name,
    String? type,
    int? beds,
    int? occupancyPercent,
    int? opdPerDay,
    int? surgeriesPerMonth,
    double? avgLos,
    double? csat,
    double? readmissionPercent,
    double? equipmentUptimePercent,
    bool? nabhAccredited,
    String? grade,
  }) {
    return HospitalScorecardItem(
      name: name ?? this.name,
      type: type ?? this.type,
      beds: beds ?? this.beds,
      occupancyPercent: occupancyPercent ?? this.occupancyPercent,
      opdPerDay: opdPerDay ?? this.opdPerDay,
      surgeriesPerMonth: surgeriesPerMonth ?? this.surgeriesPerMonth,
      avgLos: avgLos ?? this.avgLos,
      csat: csat ?? this.csat,
      readmissionPercent: readmissionPercent ?? this.readmissionPercent,
      equipmentUptimePercent:
          equipmentUptimePercent ?? this.equipmentUptimePercent,
      nabhAccredited: nabhAccredited ?? this.nabhAccredited,
      grade: grade ?? this.grade,
    );
  }
}

class HospitalPerformanceAlert {
  const HospitalPerformanceAlert({
    required this.msg,
    required this.time,
  });

  final String msg;
  final String time;
}
