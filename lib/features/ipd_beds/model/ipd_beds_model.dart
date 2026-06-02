class IpdKpiData {
  const IpdKpiData({
    required this.totalBeds,
    required this.occupiedBeds,
    required this.availableBeds,
    required this.icuBeds,
    required this.icuOccupied,
    required this.hduBeds,
    required this.hduOccupied,
    required this.nicuBeds,
    required this.nicuOccupied,
    required this.alosDays,
    required this.bedTurnover,
    required this.dailyAdmissions,
    required this.erVisitsToday,
    required this.traumaCases,
    required this.ambResponseMinutes,
    required this.erWaitMinutes,
    required this.criticalCasesActive,
    required this.erDischargePercent,
  });

  final int totalBeds;
  final int occupiedBeds;
  final int availableBeds;
  final int icuBeds;
  final int icuOccupied;
  final int hduBeds;
  final int hduOccupied;
  final int nicuBeds;
  final int nicuOccupied;
  final double alosDays;
  final double bedTurnover;
  final int dailyAdmissions;
  final int erVisitsToday;
  final int traumaCases;
  final double ambResponseMinutes;
  final int erWaitMinutes;
  final int criticalCasesActive;
  final double erDischargePercent;

  IpdKpiData copyWith({
    int? totalBeds,
    int? occupiedBeds,
    int? availableBeds,
    int? icuBeds,
    int? icuOccupied,
    int? hduBeds,
    int? hduOccupied,
    int? nicuBeds,
    int? nicuOccupied,
    double? alosDays,
    double? bedTurnover,
    int? dailyAdmissions,
    int? erVisitsToday,
    int? traumaCases,
    double? ambResponseMinutes,
    int? erWaitMinutes,
    int? criticalCasesActive,
    double? erDischargePercent,
  }) {
    return IpdKpiData(
      totalBeds: totalBeds ?? this.totalBeds,
      occupiedBeds: occupiedBeds ?? this.occupiedBeds,
      availableBeds: availableBeds ?? this.availableBeds,
      icuBeds: icuBeds ?? this.icuBeds,
      icuOccupied: icuOccupied ?? this.icuOccupied,
      hduBeds: hduBeds ?? this.hduBeds,
      hduOccupied: hduOccupied ?? this.hduOccupied,
      nicuBeds: nicuBeds ?? this.nicuBeds,
      nicuOccupied: nicuOccupied ?? this.nicuOccupied,
      alosDays: alosDays ?? this.alosDays,
      bedTurnover: bedTurnover ?? this.bedTurnover,
      dailyAdmissions: dailyAdmissions ?? this.dailyAdmissions,
      erVisitsToday: erVisitsToday ?? this.erVisitsToday,
      traumaCases: traumaCases ?? this.traumaCases,
      ambResponseMinutes: ambResponseMinutes ?? this.ambResponseMinutes,
      erWaitMinutes: erWaitMinutes ?? this.erWaitMinutes,
      criticalCasesActive: criticalCasesActive ?? this.criticalCasesActive,
      erDischargePercent: erDischargePercent ?? this.erDischargePercent,
    );
  }
}

class WardStatusItem {
  const WardStatusItem({
    required this.name,
    required this.iconCode,
    required this.occupied,
    required this.total,
    required this.themeHex,
  });

  final String name;
  final int iconCode; // Using points to FontAwesome or standard icons
  final int occupied;
  final int total;
  final String themeHex;

  double get percent => total == 0 ? 0.0 : (occupied / total);

  WardStatusItem copyWith({
    String? name,
    int? iconCode,
    int? occupied,
    int? total,
    String? themeHex,
  }) {
    return WardStatusItem(
      name: name ?? this.name,
      iconCode: iconCode ?? this.iconCode,
      occupied: occupied ?? this.occupied,
      total: total ?? this.total,
      themeHex: themeHex ?? this.themeHex,
    );
  }
}

class AmbulanceItem {
  const AmbulanceItem({
    required this.vehicleNo,
    required this.driver,
    required this.status,
    required this.patientName,
    required this.location,
    required this.etaMinutes,
  });

  final String vehicleNo;
  final String driver;
  final String status; // 'Active', 'Dispatch', 'Returning', 'Maintenance', 'Critical'
  final String patientName;
  final String location;
  final int etaMinutes;
}

class HospitalIpdScorecardItem {
  const HospitalIpdScorecardItem({
    required this.name,
    required this.district,
    required this.beds,
    required this.occupancyPercent,
    required this.admissions,
    required this.discharges,
    required this.grade,
  });

  final String name;
  final String district;
  final int beds;
  final double occupancyPercent;
  final int admissions;
  final int discharges;
  final String grade;
}

class ErEventItem {
  const ErEventItem({
    required this.time,
    required this.type,
    required this.message,
    required this.status,
  });

  final String time;
  final String type;
  final String message;
  final String status;
}

class TransferRequestItem {
  const TransferRequestItem({
    required this.accession,
    required this.patient,
    required this.fromWard,
    required this.toWard,
    required this.priority,
    required this.status,
  });

  final String accession;
  final String patient;
  final String fromWard;
  final String toWard;
  final String priority;
  final String status;
}
