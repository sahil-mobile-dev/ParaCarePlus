class MchKpiData {
  const MchKpiData({
    required this.mmrRate,
    required this.instDeliveriesPercent,
    required this.ancRegistrations,
    required this.fourAncPercent,
    required this.hrPregnancies,
    required this.cSectionPercent,
    required this.jsyBeneficiaries,
    required this.anaemiaPercent,
    required this.imrRate,
    required this.fullImmunisationPercent,
    required this.neonatalDeathsMtd,
    required this.samChildren,
    required this.mamChildren,
    required this.sncuAdmissions,
    required this.exclusiveBreastfeedPercent,
    required this.stuntingPercent,
  });

  final int mmrRate;
  final double instDeliveriesPercent;
  final int ancRegistrations;
  final double fourAncPercent;
  final int hrPregnancies;
  final double cSectionPercent;
  final int jsyBeneficiaries;
  final double anaemiaPercent;
  final int imrRate;
  final double fullImmunisationPercent;
  final int neonatalDeathsMtd;
  final int samChildren;
  final int mamChildren;
  final int sncuAdmissions;
  final double exclusiveBreastfeedPercent;
  final double stuntingPercent;

  MchKpiData copyWith({
    int? mmrRate,
    double? instDeliveriesPercent,
    int? ancRegistrations,
    double? fourAncPercent,
    int? hrPregnancies,
    double? cSectionPercent,
    int? jsyBeneficiaries,
    double? anaemiaPercent,
    int? imrRate,
    double? fullImmunisationPercent,
    int? neonatalDeathsMtd,
    int? samChildren,
    int? mamChildren,
    int? sncuAdmissions,
    double? exclusiveBreastfeedPercent,
    double? stuntingPercent,
  }) {
    return MchKpiData(
      mmrRate: mmrRate ?? this.mmrRate,
      instDeliveriesPercent: instDeliveriesPercent ?? this.instDeliveriesPercent,
      ancRegistrations: ancRegistrations ?? this.ancRegistrations,
      fourAncPercent: fourAncPercent ?? this.fourAncPercent,
      hrPregnancies: hrPregnancies ?? this.hrPregnancies,
      cSectionPercent: cSectionPercent ?? this.cSectionPercent,
      jsyBeneficiaries: jsyBeneficiaries ?? this.jsyBeneficiaries,
      anaemiaPercent: anaemiaPercent ?? this.anaemiaPercent,
      imrRate: imrRate ?? this.imrRate,
      fullImmunisationPercent: fullImmunisationPercent ?? this.fullImmunisationPercent,
      neonatalDeathsMtd: neonatalDeathsMtd ?? this.neonatalDeathsMtd,
      samChildren: samChildren ?? this.samChildren,
      mamChildren: mamChildren ?? this.mamChildren,
      sncuAdmissions: sncuAdmissions ?? this.sncuAdmissions,
      exclusiveBreastfeedPercent: exclusiveBreastfeedPercent ?? this.exclusiveBreastfeedPercent,
      stuntingPercent: stuntingPercent ?? this.stuntingPercent,
    );
  }
}

class MchProgramItem {
  const MchProgramItem({
    required this.name,
    required this.iconCode,
    required this.themeHex,
    required this.done,
    required this.total,
    required this.pct,
    this.isPercent = false,
  });

  final String name;
  final int iconCode;
  final String themeHex;
  final double done;
  final double total;
  final int pct;
  final bool isPercent;
}

class MchDistrictScorecardItem {
  const MchDistrictScorecardItem({
    required this.district,
    required this.mmr,
    required this.imr,
    required this.instDel,
    required this.anc4,
    required this.fullImmun,
    required this.sam,
    required this.jsy,
    required this.grade,
  });

  final String district;
  final int mmr;
  final int imr;
  final double instDel;
  final double anc4;
  final double fullImmun;
  final int sam;
  final double jsy;
  final String grade;
}

class HrpRegisterItem {
  const HrpRegisterItem({
    required this.name,
    required this.age,
    required this.weeks,
    required this.riskFactor,
    required this.district,
    required this.facility,
    required this.status,
  });

  final String name;
  final int age;
  final int weeks;
  final String riskFactor;
  final String district;
  final String facility;
  final String status;
}
