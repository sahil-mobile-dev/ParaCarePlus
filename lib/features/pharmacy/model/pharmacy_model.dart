import 'package:flutter/material.dart';

class DispenseQueueItem {
  const DispenseQueueItem({
    required this.rxNo,
    required this.patient,
    required this.ageSex,
    required this.wardType,
    required this.doctor,
    required this.drugs,
    required this.priority,
    required this.time,
    required this.status,
  });

  final String rxNo;
  final String patient;
  final String ageSex;
  final String wardType;
  final String doctor;
  final String drugs;
  final String priority; // 'Routine', 'Urgent'
  final String time;
  final String status; // 'Pending Prep', 'Preparing', 'Prepared', 'Dispensed'

  DispenseQueueItem copyWith({
    String? rxNo,
    String? patient,
    String? ageSex,
    String? wardType,
    String? doctor,
    String? drugs,
    String? priority,
    String? time,
    String? status,
  }) {
    return DispenseQueueItem(
      rxNo: rxNo ?? this.rxNo,
      patient: patient ?? this.patient,
      ageSex: ageSex ?? this.ageSex,
      wardType: wardType ?? this.wardType,
      doctor: doctor ?? this.doctor,
      drugs: drugs ?? this.drugs,
      priority: priority ?? this.priority,
      time: time ?? this.time,
      status: status ?? this.status,
    );
  }
}

class StatOrderItem {
  const StatOrderItem({
    required this.id,
    required this.location,
    required this.patient,
    required this.doctor,
    required this.orderedAt,
    required this.drugs,
  });

  final String id;
  final String location;
  final String patient;
  final String doctor;
  final DateTime orderedAt;
  final String drugs;

  StatOrderItem copyWith({
    String? id,
    String? location,
    String? patient,
    String? doctor,
    DateTime? orderedAt,
    String? drugs,
  }) {
    return StatOrderItem(
      id: id ?? this.id,
      location: location ?? this.location,
      patient: patient ?? this.patient,
      doctor: doctor ?? this.doctor,
      orderedAt: orderedAt ?? this.orderedAt,
      drugs: drugs ?? this.drugs,
    );
  }
}

class RxValidationItem {
  const RxValidationItem({
    required this.id,
    required this.patient,
    required this.rxNo,
    required this.drug,
    required this.category,
    required this.warning,
    required this.icon,
    required this.color,
  });

  final String id;
  final String patient;
  final String rxNo;
  final String drug;
  final String category;
  final String warning;
  final IconData icon;
  final Color color;

  RxValidationItem copyWith({
    String? id,
    String? patient,
    String? rxNo,
    String? drug,
    String? category,
    String? warning,
    IconData? icon,
    Color? color,
  }) {
    return RxValidationItem(
      id: id ?? this.id,
      patient: patient ?? this.patient,
      rxNo: rxNo ?? this.rxNo,
      drug: drug ?? this.drug,
      category: category ?? this.category,
      warning: warning ?? this.warning,
      icon: icon ?? this.icon,
      color: color ?? this.color,
    );
  }
}

class DrugInventoryItem {
  const DrugInventoryItem({
    required this.name,
    required this.category,
    required this.form,
    required this.batch,
    required this.qty,
    required this.minLevel,
    required this.mrp,
    required this.status,
  });

  final String name;
  final String category;
  final String form;
  final String batch;
  final int qty;
  final int minLevel;
  final double mrp;
  final String status; // 'In Stock', 'Reorder Alert'

  DrugInventoryItem copyWith({
    String? name,
    String? category,
    String? form,
    String? batch,
    int? qty,
    int? minLevel,
    double? mrp,
    String? status,
  }) {
    return DrugInventoryItem(
      name: name ?? this.name,
      category: category ?? this.category,
      form: form ?? this.form,
      batch: batch ?? this.batch,
      qty: qty ?? this.qty,
      minLevel: minLevel ?? this.minLevel,
      mrp: mrp ?? this.mrp,
      status: status ?? this.status,
    );
  }
}

class ExpiryAlertItem {
  const ExpiryAlertItem({
    required this.drug,
    required this.batch,
    required this.expiryDate,
    required this.daysLeft,
    required this.qty,
    required this.recommendedAction,
  });

  final String drug;
  final String batch;
  final String expiryDate;
  final int daysLeft;
  final int qty;
  final String recommendedAction;

  ExpiryAlertItem copyWith({
    String? drug,
    String? batch,
    String? expiryDate,
    int? daysLeft,
    int? qty,
    String? recommendedAction,
  }) {
    return ExpiryAlertItem(
      drug: drug ?? this.drug,
      batch: batch ?? this.batch,
      expiryDate: expiryDate ?? this.expiryDate,
      daysLeft: daysLeft ?? this.daysLeft,
      qty: qty ?? this.qty,
      recommendedAction: recommendedAction ?? this.recommendedAction,
    );
  }
}

class GrnLogItem {
  const GrnLogItem({
    required this.grnNo,
    required this.supplier,
    required this.invoice,
    required this.items,
    required this.value,
    required this.receivedBy,
    required this.date,
    required this.status,
  });

  final String grnNo;
  final String supplier;
  final String invoice;
  final int items;
  final String value;
  final String receivedBy;
  final String date;
  final String status; // 'verified', 'partial'

  GrnLogItem copyWith({
    String? grnNo,
    String? supplier,
    String? invoice,
    int? items,
    String? value,
    String? receivedBy,
    String? date,
    String? status,
  }) {
    return GrnLogItem(
      grnNo: grnNo ?? this.grnNo,
      supplier: supplier ?? this.supplier,
      invoice: invoice ?? this.invoice,
      items: items ?? this.items,
      value: value ?? this.value,
      receivedBy: receivedBy ?? this.receivedBy,
      date: date ?? this.date,
      status: status ?? this.status,
    );
  }
}

class PurchaseOrderItem {
  const PurchaseOrderItem({
    required this.poNo,
    required this.vendor,
    required this.items,
    required this.estDelivery,
    required this.status,
  });

  final String poNo;
  final String vendor;
  final int items;
  final String estDelivery;
  final String status; // 'SENT', 'PENDING APPROVAL'

  PurchaseOrderItem copyWith({
    String? poNo,
    String? vendor,
    int? items,
    String? estDelivery,
    String? status,
  }) {
    return PurchaseOrderItem(
      poNo: poNo ?? this.poNo,
      vendor: vendor ?? this.vendor,
      items: items ?? this.items,
      estDelivery: estDelivery ?? this.estDelivery,
      status: status ?? this.status,
    );
  }
}
