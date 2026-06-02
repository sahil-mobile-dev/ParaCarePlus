class LabSampleItem {
  const LabSampleItem({
    required this.id,
    required this.patientName,
    required this.mrn,
    required this.tests,
    required this.category,
    required this.priority, // 'routine', 'urgent', 'stat'
    required this.doctor,
    required this.collected,
    required this.status, // 'ordered', 'collected', 'processing', 'completed'
    this.result,
  });

  final String id;
  final String patientName;
  final String mrn;
  final String tests;
  final String category;
  final String priority;
  final String doctor;
  final String collected;
  final String status;
  final String? result;

  LabSampleItem copyWith({
    String? id,
    String? patientName,
    String? mrn,
    String? tests,
    String? category,
    String? priority,
    String? doctor,
    String? collected,
    String? status,
    String? result,
  }) {
    return LabSampleItem(
      id: id ?? this.id,
      patientName: patientName ?? this.patientName,
      mrn: mrn ?? this.mrn,
      tests: tests ?? this.tests,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      doctor: doctor ?? this.doctor,
      collected: collected ?? this.collected,
      status: status ?? this.status,
      result: result ?? this.result,
    );
  }
}

class UrgentTestItem {
  const UrgentTestItem({
    required this.id,
    required this.patientName,
    required this.tests,
    required this.elapsed,
    required this.remaining,
    required this.priority, // 'STAT', 'Urgent'
  });

  final String id;
  final String patientName;
  final String tests;
  final String elapsed;
  final String remaining;
  final String priority;

  UrgentTestItem copyWith({
    String? id,
    String? patientName,
    String? tests,
    String? elapsed,
    String? remaining,
    String? priority,
  }) {
    return UrgentTestItem(
      id: id ?? this.id,
      patientName: patientName ?? this.patientName,
      tests: tests ?? this.tests,
      elapsed: elapsed ?? this.elapsed,
      remaining: remaining ?? this.remaining,
      priority: priority ?? this.priority,
    );
  }
}

class CriticalValueItem {
  const CriticalValueItem({
    required this.id,
    required this.patientName,
    required this.ward,
    required this.test,
    required this.value,
    required this.normalRange,
    required this.flag, // '↓↓ CRITICAL LOW', '↑↑ CRITICAL HIGH'
    required this.doctor,
    required this.acknowledged,
  });

  final String id;
  final String patientName;
  final String ward;
  final String test;
  final String value;
  final String normalRange;
  final String flag;
  final String doctor;
  final bool acknowledged;

  CriticalValueItem copyWith({
    String? id,
    String? patientName,
    String? ward,
    String? test,
    String? value,
    String? normalRange,
    String? flag,
    String? doctor,
    bool? acknowledged,
  }) {
    return CriticalValueItem(
      id: id ?? this.id,
      patientName: patientName ?? this.patientName,
      ward: ward ?? this.ward,
      test: test ?? this.test,
      value: value ?? this.value,
      normalRange: normalRange ?? this.normalRange,
      flag: flag ?? this.flag,
      doctor: doctor ?? this.doctor,
      acknowledged: acknowledged ?? this.acknowledged,
    );
  }
}

class LabReportItem {
  const LabReportItem({
    required this.id,
    required this.patientName,
    required this.tests,
    required this.keyResult,
    required this.time,
    required this.status, // 'dispatched', 'printed'
  });

  final String id;
  final String patientName;
  final String tests;
  final String keyResult;
  final String time;
  final String status;
}

class AnalyzerItem {
  const AnalyzerItem({
    required this.name,
    required this.status, // 'online', 'maintenance'
    required this.tests,
    required this.lastCalibration,
    required this.samplesToday,
  });

  final String name;
  final String status;
  final String tests;
  final String lastCalibration;
  final String samplesToday;

  AnalyzerItem copyWith({
    String? name,
    String? status,
    String? tests,
    String? lastCalibration,
    String? samplesToday,
  }) {
    return AnalyzerItem(
      name: name ?? this.name,
      status: status ?? this.status,
      tests: tests ?? this.tests,
      lastCalibration: lastCalibration ?? this.lastCalibration,
      samplesToday: samplesToday ?? this.samplesToday,
    );
  }
}
