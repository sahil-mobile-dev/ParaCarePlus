import 'dart:async';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/features/blood_bank/model/blood_bank_model.dart';

class BloodBankState {
  BloodBankState({
    required this.activeTab,
    required this.stock,
    required this.groupsStock,
    required this.donors,
    required this.donations,
    required this.requests,
    required this.crossmatchHistory,
    required this.issueHistory,
    this.selectedRequestForCrossmatch,
    this.isLoading = false,
  });

  final String activeTab;
  final List<StockBagItem> stock;
  final List<BloodGroupStock> groupsStock;
  final List<DonorItem> donors;
  final List<DonationItem> donations;
  final List<BloodRequestItem> requests;
  final List<CrossMatchItem> crossmatchHistory;
  final List<IssueItem> issueHistory;
  final BloodRequestItem? selectedRequestForCrossmatch;
  final bool isLoading;

  BloodBankState copyWith({
    String? activeTab,
    List<StockBagItem>? stock,
    List<BloodGroupStock>? groupsStock,
    List<DonorItem>? donors,
    List<DonationItem>? donations,
    List<BloodRequestItem>? requests,
    List<CrossMatchItem>? crossmatchHistory,
    List<IssueItem>? issueHistory,
    BloodRequestItem? selectedRequestForCrossmatch,
    bool? isLoading,
  }) {
    return BloodBankState(
      activeTab: activeTab ?? this.activeTab,
      stock: stock ?? this.stock,
      groupsStock: groupsStock ?? this.groupsStock,
      donors: donors ?? this.donors,
      donations: donations ?? this.donations,
      requests: requests ?? this.requests,
      crossmatchHistory: crossmatchHistory ?? this.crossmatchHistory,
      issueHistory: issueHistory ?? this.issueHistory,
      selectedRequestForCrossmatch: selectedRequestForCrossmatch ?? this.selectedRequestForCrossmatch,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class BloodBankNotifier extends StateNotifier<BloodBankState> {
  BloodBankNotifier() : super(_initialState()) {
    _startTimer();
  }

  Timer? _timer;
  final _random = Random();

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 18), (_) {
      _simulationTick();
    });
  }

  void setTab(String tab) {
    state = state.copyWith(activeTab: tab);
  }

  void selectRequestForCrossmatch(BloodRequestItem req) {
    state = state.copyWith(
      selectedRequestForCrossmatch: req,
      activeTab: 'Cross-Match',
    );
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true);
    await Future<void>.delayed(const Duration(milliseconds: 700));
    state = _initialState().copyWith(isLoading: false);
  }

  // Register new blood donor
  void registerDonor({
    required String name,
    required String ageSex,
    required String bloodGroup,
    required String mobile,
  }) {
    final nextId = 'D-00${100 + state.donors.length}';
    final newDonor = DonorItem(
      id: nextId,
      name: name,
      ageSex: ageSex,
      bloodGroup: bloodGroup,
      mobile: mobile,
      lastDonation: 'Never',
      totalDonations: 0,
      eligible: 'Yes',
    );

    state = state.copyWith(
      donors: [newDonor, ...state.donors],
    );
  }

  // Record a blood donation
  void recordDonation({
    required String donorName,
    required String bloodGroup,
    required int volume,
    required String component,
    required String campType,
  }) {
    final nextBagId = 'BB-UK-2025-0${240 + state.stock.length}';
    final todayStr = _formatDate(DateTime.now());
    final expiryStr = _formatDate(DateTime.now().add(const Duration(days: 35)));

    // Create donation log
    final newDonation = DonationItem(
      bagId: nextBagId,
      donorName: donorName,
      bloodGroup: bloodGroup,
      date: todayStr,
      volume: '${volume}mL',
      screening: 'All Clear',
      campType: campType,
      component: component,
      status: 'Available',
    );

    // Create stock item
    final newStock = StockBagItem(
      bagId: nextBagId,
      group: bloodGroup,
      component: component,
      volume: '${volume}mL',
      collected: todayStr,
      expiry: expiryStr,
      daysLeft: 35,
      status: 'Available',
    );

    // Increment available stock
    final updatedGroups = state.groupsStock.map((g) {
      if (g.group == bloodGroup) {
        final newUnits = g.units + 1;
        final isOk = newUnits >= g.minRequired;
        return g.copyWith(
          units: newUnits,
          status: isOk ? 'ok' : 'low',
        );
      }
      return g;
    }).toList();

    state = state.copyWith(
      donations: [newDonation, ...state.donations],
      stock: [newStock, ...state.stock],
      groupsStock: updatedGroups,
    );
  }

  // Submit patient blood request
  void submitRequest({
    required String patientName,
    required String group,
    required String component,
    required int units,
    required String urgency,
    required String ward,
    required String doctor,
  }) {
    final reqNo = 'REQ-0${10 + state.requests.length}';
    final newReq = BloodRequestItem(
      reqNo: reqNo,
      patientName: patientName,
      ward: ward,
      bloodGroup: group,
      component: component,
      units: units,
      urgency: urgency,
      requestedBy: doctor,
      status: 'Pending',
    );

    state = state.copyWith(
      requests: [newReq, ...state.requests],
    );
  }

  // Record cross-match compatibility entry
  void saveCrossMatch({
    required String patientName,
    required String bagId,
    required String bloodGroup,
    required String result,
    required String technician,
  }) {
    final nextHistory = CrossMatchItem(
      patientName: patientName,
      bagId: bagId,
      bloodGroup: bloodGroup,
      result: result,
      date: _formatDate(DateTime.now()),
      technician: technician,
    );

    // Update selected request status if it matches patient
    final updatedReqs = state.requests.map((r) {
      if (r.patientName == patientName && r.status == 'Pending') {
        return r.copyWith(status: 'Cross-Matching');
      }
      return r;
    }).toList();

    state = state.copyWith(
      crossmatchHistory: [nextHistory, ...state.crossmatchHistory],
      requests: updatedReqs,
    );
  }

  // Issue blood bags
  void issueBlood({
    required String reqNo,
    required String patientName,
    required String bagId,
    required String component,
    required int units,
    required String issuedBy,
  }) {
    // 1. Generate issue entry
    final nextIssueNo = 'ISS-0${10 + state.issueHistory.length}';
    final newIssue = IssueItem(
      issueNo: nextIssueNo,
      patientName: patientName,
      bagId: bagId,
      component: component,
      date: _formatDate(DateTime.now()),
      status: 'Issued',
    );

    // 2. Remove bag from active stock or set status to issued
    final updatedStock = state.stock.where((s) => s.bagId != bagId).toList();

    // 3. Update request status to "Issued"
    final updatedReqs = state.requests.map((r) {
      if (r.reqNo == reqNo || r.patientName == patientName) {
        return r.copyWith(status: 'Issued');
      }
      return r;
    }).toList();

    // 4. Decrement available blood stock counts
    String? bloodGroup;
    try {
      bloodGroup = state.stock.firstWhere((s) => s.bagId == bagId).group;
    } catch (_) {
      bloodGroup = null;
    }

    List<BloodGroupStock> updatedGroups = [...state.groupsStock];
    if (bloodGroup != null) {
      updatedGroups = state.groupsStock.map((g) {
        if (g.group == bloodGroup) {
          final newUnits = max(0, g.units - units);
          final isCrit = newUnits < (g.minRequired / 2);
          final isLow = newUnits < g.minRequired;
          return g.copyWith(
            units: newUnits,
            status: isCrit ? 'critical' : (isLow ? 'low' : 'ok'),
          );
        }
        return g;
      }).toList();
    }

    state = state.copyWith(
      issueHistory: [newIssue, ...state.issueHistory],
      stock: updatedStock,
      requests: updatedReqs,
      groupsStock: updatedGroups,
      selectedRequestForCrossmatch: null, // Clear active
    );
  }

  void _simulationTick() {
    // 1. Tick days left down slightly for stock bags
    final updatedStock = state.stock.map((s) {
      final days = max(0, s.daysLeft - 1);
      return s.copyWith(
        daysLeft: days,
        status: days == 0 ? 'Expired' : s.status,
      );
    }).toList();

    state = state.copyWith(stock: updatedStock);
  }

  String _formatDate(DateTime dt) {
    final d = dt.day.toString().padLeft(2, '0');
    final m = dt.month.toString().padLeft(2, '0');
    final y = dt.year;
    return '$d/$m/$y';
  }

  static BloodBankState _initialState() {
    return BloodBankState(
      activeTab: 'Inventory',
      stock: [
        const StockBagItem(bagId: 'BB-UK-2025-0234', group: 'B+', component: 'PCV/RCC', volume: '280mL', collected: '05/04/2025', expiry: '19/06/2025', daysLeft: 16, status: 'Available'),
        const StockBagItem(bagId: 'BB-UK-2025-0235', group: 'O+', component: 'Whole Blood', volume: '450mL', collected: '06/04/2025', expiry: '20/06/2025', daysLeft: 17, status: 'Available'),
        const StockBagItem(bagId: 'BB-UK-2025-0236', group: 'A+', component: 'PCV/RCC', volume: '280mL', collected: '08/04/2025', expiry: '22/06/2025', daysLeft: 19, status: 'Available'),
        const StockBagItem(bagId: 'BB-UK-2025-0237', group: 'AB+', component: 'FFP', volume: '200mL', collected: '10/04/2025', expiry: '10/10/2025', daysLeft: 129, status: 'Available'),
        const StockBagItem(bagId: 'BB-UK-2025-0238', group: 'O-', component: 'PCV/RCC', volume: '280mL', collected: '03/04/2025', expiry: '17/06/2025', daysLeft: 14, status: 'Reserved'),
        const StockBagItem(bagId: 'BB-UK-2025-0239', group: 'B+', component: 'Platelets', volume: '60mL', collected: '11/04/2025', expiry: '16/06/2025', daysLeft: 13, status: 'Available'),
        const StockBagItem(bagId: 'BB-UK-2025-0240', group: 'A-', component: 'PCV/RCC', volume: '280mL', collected: '02/04/2025', expiry: '06/06/2025', daysLeft: 3, status: 'Available'),
      ],
      groupsStock: [
        const BloodGroupStock(group: 'A+', units: 52, minRequired: 20, status: 'ok'),
        const BloodGroupStock(group: 'A-', units: 8, minRequired: 10, status: 'critical'),
        const BloodGroupStock(group: 'B+', units: 68, minRequired: 20, status: 'ok'),
        const BloodGroupStock(group: 'B-', units: 5, minRequired: 10, status: 'critical'),
        const BloodGroupStock(group: 'O+', units: 78, minRequired: 25, status: 'ok'),
        const BloodGroupStock(group: 'O-', units: 12, minRequired: 15, status: 'low'),
        const BloodGroupStock(group: 'AB+', units: 34, minRequired: 10, status: 'ok'),
        const BloodGroupStock(group: 'AB-', units: 7, minRequired: 8, status: 'low'),
      ],
      donors: [
        const DonorItem(id: 'D-0012', name: 'Suresh Negi', ageSex: '32/M', bloodGroup: 'O+', mobile: '98765-11234', lastDonation: '15/01/2025', totalDonations: 8, eligible: 'Yes'),
        const DonorItem(id: 'D-0034', name: 'Priya Rawat', ageSex: '28/F', bloodGroup: 'A+', mobile: '87654-22345', lastDonation: '20/02/2025', totalDonations: 4, eligible: 'No (90d)'),
        const DonorItem(id: 'D-0056', name: 'Ramesh Bisht', ageSex: '41/M', bloodGroup: 'B+', mobile: '76543-33456', lastDonation: '10/03/2025', totalDonations: 12, eligible: 'Yes'),
        const DonorItem(id: 'D-0078', name: 'Anita Sharma', ageSex: '35/F', bloodGroup: 'AB+', mobile: '65432-44567', lastDonation: '05/04/2025', totalDonations: 3, eligible: 'No (90d)'),
        const DonorItem(id: 'D-0089', name: 'Kishore Pant', ageSex: '25/M', bloodGroup: 'O-', mobile: '54321-55678', lastDonation: '01/01/2025', totalDonations: 6, eligible: 'Yes'),
      ],
      donations: [
        const DonationItem(bagId: 'BB-UK-2025-0234', donorName: 'Ramesh Bisht', bloodGroup: 'B+', date: '05/04/2025', volume: '450mL', screening: 'All Clear', campType: 'Walk-in', component: 'PCV/RCC', status: 'Available'),
        const DonationItem(bagId: 'BB-UK-2025-0235', donorName: 'Suresh Negi', bloodGroup: 'O+', date: '06/04/2025', volume: '450mL', screening: 'All Clear', campType: 'Camp', component: 'Whole Blood', status: 'Available'),
        const DonationItem(bagId: 'BB-UK-2025-0236', donorName: 'Mohan Verma', bloodGroup: 'A+', date: '08/04/2025', volume: '450mL', screening: 'All Clear', campType: 'Walk-in', component: 'PCV/RCC', status: 'Issued'),
        const DonationItem(bagId: 'BB-UK-2025-0237', donorName: 'Deepak Kumar', bloodGroup: 'AB+', date: '10/04/2025', volume: '450mL', screening: 'All Clear', campType: 'Walk-in', component: 'FFP', status: 'Available'),
      ],
      requests: [
        const BloodRequestItem(reqNo: 'REQ-001', patientName: 'Kishore Negi', ward: 'Surgery', bloodGroup: 'B+', component: 'PCV/RCC', units: 2, urgency: 'Urgent', requestedBy: 'Dr. Sharma', status: 'Pending'),
        const BloodRequestItem(reqNo: 'REQ-002', patientName: 'Ram Chandra', ward: 'ICU', bloodGroup: 'O+', component: 'Whole Blood', units: 3, urgency: 'Emergency', requestedBy: 'Dr. Rawat', status: 'Cross-Matching'),
        const BloodRequestItem(reqNo: 'REQ-003', patientName: 'Meena Bisht', ward: 'Gynae', bloodGroup: 'A+', component: 'FFP', units: 2, urgency: 'Routine', requestedBy: 'Dr. Singh', status: 'Issued'),
        const BloodRequestItem(reqNo: 'REQ-004', patientName: 'Arjun Pant', ward: 'Medicine', bloodGroup: 'O-', component: 'PCV/RCC', units: 1, urgency: 'Urgent', requestedBy: 'Dr. Verma', status: 'Pending'),
      ],
      crossmatchHistory: [
        const CrossMatchItem(patientName: 'Kishore Negi', bagId: 'BB-UK-2025-0234', bloodGroup: 'B+', result: 'Compatible', date: '12/04/2025', technician: 'Lab Tech Mohan'),
        const CrossMatchItem(patientName: 'Meena Bisht', bagId: 'BB-UK-2025-0220', bloodGroup: 'A+', result: 'Compatible', date: '10/04/2025', technician: 'Lab Tech Reena'),
        const CrossMatchItem(patientName: 'Arjun Pant', bagId: 'BB-UK-2025-0228', bloodGroup: 'O-', result: 'Compatible', date: '09/04/2025', technician: 'Lab Tech Mohan'),
        const CrossMatchItem(patientName: 'Pushpa Devi', bagId: 'BB-UK-2025-0215', bloodGroup: 'AB+', result: 'Incompatible', date: '08/04/2025', technician: 'Lab Tech Reena'),
      ],
      issueHistory: [
        const IssueItem(issueNo: 'ISS-001', patientName: 'Meena Bisht', bagId: 'BB-UK-2025-0220', component: 'FFP', date: '10/04/2025', status: 'Issued'),
        const IssueItem(issueNo: 'ISS-002', patientName: 'Arjun Pant', bagId: 'BB-UK-2025-0228', component: 'PCV', date: '09/04/2025', status: 'Issued'),
        const IssueItem(issueNo: 'ISS-003', patientName: 'Pushpa Devi', bagId: 'BB-UK-2025-0195', component: 'Platelets', date: '07/04/2025', status: 'Transfused'),
      ],
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final bloodBankProvider =
    StateNotifierProvider<BloodBankNotifier, BloodBankState>((ref) {
  return BloodBankNotifier();
});
