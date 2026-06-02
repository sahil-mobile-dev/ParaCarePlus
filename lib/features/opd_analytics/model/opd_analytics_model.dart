class OpdAnalyticsKpis {
  const OpdAnalyticsKpis({
    required this.totalOpdToday,
    required this.avgWaitTimeMinutes,
    required this.avgConsultationTimeMinutes,
    required this.newVsRevisitRatio,
    required this.ePrescriptionRatePercent,
    required this.abhaScanSharePercent,
    required this.telemedicineOpdCount,
    required this.opdToIpdConversionPercent,
    required this.opdCsatScore,
    required this.opdLabReferralRatePercent,
  });

  final int totalOpdToday;
  final int avgWaitTimeMinutes;
  final double avgConsultationTimeMinutes;
  final String newVsRevisitRatio;
  final double ePrescriptionRatePercent;
  final double abhaScanSharePercent;
  final int telemedicineOpdCount;
  final double opdToIpdConversionPercent;
  final double opdCsatScore;
  final double opdLabReferralRatePercent;

  OpdAnalyticsKpis copyWith({
    int? totalOpdToday,
    int? avgWaitTimeMinutes,
    double? avgConsultationTimeMinutes,
    String? newVsRevisitRatio,
    double? ePrescriptionRatePercent,
    double? abhaScanSharePercent,
    int? telemedicineOpdCount,
    double? opdToIpdConversionPercent,
    double? opdCsatScore,
    double? opdLabReferralRatePercent,
  }) {
    return OpdAnalyticsKpis(
      totalOpdToday: totalOpdToday ?? this.totalOpdToday,
      avgWaitTimeMinutes: avgWaitTimeMinutes ?? this.avgWaitTimeMinutes,
      avgConsultationTimeMinutes:
          avgConsultationTimeMinutes ?? this.avgConsultationTimeMinutes,
      newVsRevisitRatio: newVsRevisitRatio ?? this.newVsRevisitRatio,
      ePrescriptionRatePercent:
          ePrescriptionRatePercent ?? this.ePrescriptionRatePercent,
      abhaScanSharePercent: abhaScanSharePercent ?? this.abhaScanSharePercent,
      telemedicineOpdCount: telemedicineOpdCount ?? this.telemedicineOpdCount,
      opdToIpdConversionPercent:
          opdToIpdConversionPercent ?? this.opdToIpdConversionPercent,
      opdCsatScore: opdCsatScore ?? this.opdCsatScore,
      opdLabReferralRatePercent:
          opdLabReferralRatePercent ?? this.opdLabReferralRatePercent,
    );
  }
}

class LiveCounterItem {
  const LiveCounterItem({
    required this.label,
    required this.val,
    required this.colorHex,
    required this.sub,
  });

  final String label;
  final String val;
  final String colorHex;
  final String sub;
}

class DoctorOpdPerformanceItem {
  const DoctorOpdPerformanceItem({
    required this.name,
    required this.specialty,
    required this.patientsSeen,
    required this.target,
    required this.avgConsultTime,
    required this.abhaScanPercent,
    required this.ePrescriptionPercent,
    required this.csat,
  });

  final String name;
  final String specialty;
  final int patientsSeen;
  final int target;
  final double avgConsultTime;
  final double abhaScanPercent;
  final double ePrescriptionPercent;
  final double csat;

  DoctorOpdPerformanceItem copyWith({
    String? name,
    String? specialty,
    int? patientsSeen,
    int? target,
    double? avgConsultTime,
    double? abhaScanPercent,
    double? ePrescriptionPercent,
    double? csat,
  }) {
    return DoctorOpdPerformanceItem(
      name: name ?? this.name,
      specialty: specialty ?? this.specialty,
      patientsSeen: patientsSeen ?? this.patientsSeen,
      target: target ?? this.target,
      avgConsultTime: avgConsultTime ?? this.avgConsultTime,
      abhaScanPercent: abhaScanPercent ?? this.abhaScanPercent,
      ePrescriptionPercent: ePrescriptionPercent ?? this.ePrescriptionPercent,
      csat: csat ?? this.csat,
    );
  }
}

class OpdOperationalAlert {
  const OpdOperationalAlert({
    required this.msg,
    required this.time,
  });

  final String msg;
  final String time;
}
