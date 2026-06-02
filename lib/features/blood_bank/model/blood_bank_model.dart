class BloodGroupStock {
  const BloodGroupStock({
    required this.group,
    required this.units,
    required this.minRequired,
    required this.status, // 'ok', 'low', 'critical'
  });

  final String group;
  final int units;
  final int minRequired;
  final String status;

  BloodGroupStock copyWith({
    String? group,
    int? units,
    int? minRequired,
    String? status,
  }) {
    return BloodGroupStock(
      group: group ?? this.group,
      units: units ?? this.units,
      minRequired: minRequired ?? this.minRequired,
      status: status ?? this.status,
    );
  }
}

class StockBagItem {
  const StockBagItem({
    required this.bagId,
    required this.group,
    required this.component, // 'Whole Blood', 'PCV/RCC', 'Platelets', 'FFP', 'Cryo'
    required this.volume,
    required this.collected,
    required this.expiry,
    required this.daysLeft,
    required this.status, // 'Available', 'Reserved', 'Expired'
  });

  final String bagId;
  final String group;
  final String component;
  final String volume;
  final String collected;
  final String expiry;
  final int daysLeft;
  final String status;

  StockBagItem copyWith({
    String? bagId,
    String? group,
    String? component,
    String? volume,
    String? collected,
    String? expiry,
    int? daysLeft,
    String? status,
  }) {
    return StockBagItem(
      bagId: bagId ?? this.bagId,
      group: group ?? this.group,
      component: component ?? this.component,
      volume: volume ?? this.volume,
      collected: collected ?? this.collected,
      expiry: expiry ?? this.expiry,
      daysLeft: daysLeft ?? this.daysLeft,
      status: status ?? this.status,
    );
  }
}

class DonorItem {
  const DonorItem({
    required this.id,
    required this.name,
    required this.ageSex,
    required this.bloodGroup,
    required this.mobile,
    required this.lastDonation,
    required this.totalDonations,
    required this.eligible, // 'Yes', 'No (90d)'
  });

  final String id;
  final String name;
  final String ageSex;
  final String bloodGroup;
  final String mobile;
  final String lastDonation;
  final int totalDonations;
  final String eligible;

  DonorItem copyWith({
    String? id,
    String? name,
    String? ageSex,
    String? bloodGroup,
    String? mobile,
    String? lastDonation,
    int? totalDonations,
    String? eligible,
  }) {
    return DonorItem(
      id: id ?? this.id,
      name: name ?? this.name,
      ageSex: ageSex ?? this.ageSex,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      mobile: mobile ?? this.mobile,
      lastDonation: lastDonation ?? this.lastDonation,
      totalDonations: totalDonations ?? this.totalDonations,
      eligible: eligible ?? this.eligible,
    );
  }
}

class DonationItem {
  const DonationItem({
    required this.bagId,
    required this.donorName,
    required this.bloodGroup,
    required this.date,
    required this.volume,
    required this.screening,
    required this.campType, // 'Walk-in', 'Camp', 'Replacement'
    required this.component,
    required this.status,
  });

  final String bagId;
  final String donorName;
  final String bloodGroup;
  final String date;
  final String volume;
  final String screening;
  final String campType;
  final String component;
  final String status;
}

class BloodRequestItem {
  const BloodRequestItem({
    required this.reqNo,
    required this.patientName,
    required this.ward,
    required this.bloodGroup,
    required this.component,
    required this.units,
    required this.urgency, // 'Routine', 'Urgent', 'Emergency'
    required this.requestedBy,
    required this.status, // 'Pending', 'Cross-Matching', 'Issued', 'Transfused'
  });

  final String reqNo;
  final String patientName;
  final String ward;
  final String bloodGroup;
  final String component;
  final int units;
  final String urgency;
  final String requestedBy;
  final String status;

  BloodRequestItem copyWith({
    String? reqNo,
    String? patientName,
    String? ward,
    String? bloodGroup,
    String? component,
    int? units,
    String? urgency,
    String? requestedBy,
    String? status,
  }) {
    return BloodRequestItem(
      reqNo: reqNo ?? this.reqNo,
      patientName: patientName ?? this.patientName,
      ward: ward ?? this.ward,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      component: component ?? this.component,
      units: units ?? this.units,
      urgency: urgency ?? this.urgency,
      requestedBy: requestedBy ?? this.requestedBy,
      status: status ?? this.status,
    );
  }
}

class CrossMatchItem {
  const CrossMatchItem({
    required this.patientName,
    required this.bagId,
    required this.bloodGroup,
    required this.result, // 'Compatible', 'Incompatible', 'Weakly Reactive'
    required this.date,
    required this.technician,
  });

  final String patientName;
  final String bagId;
  final String bloodGroup;
  final String result;
  final String date;
  final String technician;
}

class IssueItem {
  const IssueItem({
    required this.issueNo,
    required this.patientName,
    required this.bagId,
    required this.component,
    required this.date,
    required this.status, // 'Issued', 'Transfused'
  });

  final String issueNo;
  final String patientName;
  final String bagId;
  final String component;
  final String date;
  final String status;
}
