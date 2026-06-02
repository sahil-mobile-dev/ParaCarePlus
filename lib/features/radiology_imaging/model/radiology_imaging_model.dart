class RadiologyKpis {
  const RadiologyKpis({
    required this.todayOrders,
    required this.completed,
    required this.urgentStat,
    required this.reportsPending,
    required this.aiFlagged,
  });

  final int todayOrders;
  final int completed;
  final int urgentStat;
  final int reportsPending;
  final int aiFlagged;

  RadiologyKpis copyWith({
    int? todayOrders,
    int? completed,
    int? urgentStat,
    int? reportsPending,
    int? aiFlagged,
  }) {
    return RadiologyKpis(
      todayOrders: todayOrders ?? this.todayOrders,
      completed: completed ?? this.completed,
      urgentStat: urgentStat ?? this.urgentStat,
      reportsPending: reportsPending ?? this.reportsPending,
      aiFlagged: aiFlagged ?? this.aiFlagged,
    );
  }
}

class RadiologyOrderItem {
  const RadiologyOrderItem({
    required this.accession,
    required this.patient,
    required this.ageSex,
    required this.modality,
    required this.examination,
    required this.orderedBy,
    required this.wardOpd,
    required this.priority,
    required this.status,
    required this.time,
  });

  final String accession;
  final String patient;
  final String ageSex;
  final String modality;
  final String examination;
  final String orderedBy;
  final String wardOpd;
  final String priority;
  final String status;
  final String time;

  RadiologyOrderItem copyWith({
    String? accession,
    String? patient,
    String? ageSex,
    String? modality,
    String? examination,
    String? orderedBy,
    String? wardOpd,
    String? priority,
    String? status,
    String? time,
  }) {
    return RadiologyOrderItem(
      accession: accession ?? this.accession,
      patient: patient ?? this.patient,
      ageSex: ageSex ?? this.ageSex,
      modality: modality ?? this.modality,
      examination: examination ?? this.examination,
      orderedBy: orderedBy ?? this.orderedBy,
      wardOpd: wardOpd ?? this.wardOpd,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      time: time ?? this.time,
    );
  }
}

class ModalityItem {
  const ModalityItem({
    required this.name,
    required this.location,
    required this.iconCode,
    required this.today,
    required this.pending,
    required this.util,
  });

  final String name;
  final String location;
  final int iconCode;
  final int today;
  final int pending;
  final int util;
}

class AiFindingItem {
  const AiFindingItem({
    required this.patient,
    required this.study,
    required this.finding,
    required this.confidence,
    required this.status,
  });

  final String patient;
  final String study;
  final String finding;
  final double confidence;
  final String status;
}

class ProtocolItem {
  const ProtocolItem({
    required this.name,
    required this.iconCode,
    required this.themeHex,
    required this.desc,
  });

  final String name;
  final int iconCode;
  final String themeHex;
  final String desc;
}

class MonthlySummaryItem {
  const MonthlySummaryItem({
    required this.modality,
    required this.orders,
    required this.completed,
    required this.pending,
    required this.avgTat,
    required this.revenue,
  });

  final String modality;
  final int orders;
  final int completed;
  final int pending;
  final String avgTat;
  final String revenue;
}
