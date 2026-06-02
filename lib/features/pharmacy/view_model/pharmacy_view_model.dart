import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/features/pharmacy/model/pharmacy_model.dart';

class PharmacyState {
  const PharmacyState({
    required this.activeTab,
    required this.dispenseQueue,
    required this.statOrders,
    required this.rxValidations,
    required this.inventory,
    required this.expiryAlerts,
    required this.grnLogs,
    required this.purchaseOrders,
    this.isLoading = false,
  });

  final String activeTab;
  final List<DispenseQueueItem> dispenseQueue;
  final List<StatOrderItem> statOrders;
  final List<RxValidationItem> rxValidations;
  final List<DrugInventoryItem> inventory;
  final List<ExpiryAlertItem> expiryAlerts;
  final List<GrnLogItem> grnLogs;
  final List<PurchaseOrderItem> purchaseOrders;
  final bool isLoading;

  PharmacyState copyWith({
    String? activeTab,
    List<DispenseQueueItem>? dispenseQueue,
    List<StatOrderItem>? statOrders,
    List<RxValidationItem>? rxValidations,
    List<DrugInventoryItem>? inventory,
    List<ExpiryAlertItem>? expiryAlerts,
    List<GrnLogItem>? grnLogs,
    List<PurchaseOrderItem>? purchaseOrders,
    bool? isLoading,
  }) {
    return PharmacyState(
      activeTab: activeTab ?? this.activeTab,
      dispenseQueue: dispenseQueue ?? this.dispenseQueue,
      statOrders: statOrders ?? this.statOrders,
      rxValidations: rxValidations ?? this.rxValidations,
      inventory: inventory ?? this.inventory,
      expiryAlerts: expiryAlerts ?? this.expiryAlerts,
      grnLogs: grnLogs ?? this.grnLogs,
      purchaseOrders: purchaseOrders ?? this.purchaseOrders,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class PharmacyNotifier extends StateNotifier<PharmacyState> {
  PharmacyNotifier() : super(_initialState()) {
    _startTimer();
  }

  Timer? _timer;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 15), (_) {
      // Simulate updates or keep elapsed time tick
      _simulationTick();
    });
  }

  void setTab(String tab) {
    state = state.copyWith(activeTab: tab);
  }

  // Dispense Queue actions
  void updateDispenseStatus(String rxNo, String newStatus) {
    final updated = state.dispenseQueue.map((item) {
      if (item.rxNo == rxNo) {
        return item.copyWith(status: newStatus);
      }
      return item;
    }).toList();
    state = state.copyWith(dispenseQueue: updated);
  }

  void dispensePrescription(String rxNo) {
    final updated = state.dispenseQueue.where((item) => item.rxNo != rxNo).toList();
    state = state.copyWith(dispenseQueue: updated);
  }

  // STAT Orders action
  void dispenseStatOrder(String orderId) {
    final updated = state.statOrders.where((item) => item.id != orderId).toList();
    state = state.copyWith(statOrders: updated);
  }

  // Rx Validation action
  void resolveRxValidation(String id, String status) {
    final updated = state.rxValidations.where((item) => item.id != id).toList();
    state = state.copyWith(rxValidations: updated);
  }

  // Drug Inventory actions
  void addInventoryItem({
    required String name,
    required String category,
    required String form,
    required String batch,
    required int qty,
    required int minLevel,
    required double mrp,
  }) {
    final isLow = qty < minLevel;
    final newItem = DrugInventoryItem(
      name: name,
      category: category,
      form: form,
      batch: batch,
      qty: qty,
      minLevel: minLevel,
      mrp: mrp,
      status: isLow ? 'Reorder Alert' : 'In Stock',
    );
    state = state.copyWith(inventory: [...state.inventory, newItem]);
  }

  // Expiry actions
  void quarantineExpiryItem(String batch) {
    final updated = state.expiryAlerts.where((item) => item.batch != batch).toList();
    state = state.copyWith(expiryAlerts: updated);
  }

  void processAllExpired() {
    state = state.copyWith(expiryAlerts: []);
  }

  // Purchase Order action
  void generatePurchaseOrder({
    required String vendor,
    required int itemsCount,
    required String estDelivery,
  }) {
    final poNo = 'PO-2024-0${12 + state.purchaseOrders.length}';
    final newPo = PurchaseOrderItem(
      poNo: poNo,
      vendor: vendor,
      items: itemsCount,
      estDelivery: estDelivery,
      status: 'PENDING APPROVAL',
    );
    state = state.copyWith(purchaseOrders: [...state.purchaseOrders, newPo]);
  }

  void _simulationTick() {
    // Refresh or update STAT time if needed, trigger state refresh
    state = state.copyWith(statOrders: [...state.statOrders]);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  static PharmacyState _initialState() {
    return PharmacyState(
      activeTab: 'Dispense Queue',
      dispenseQueue: const [
        DispenseQueueItem(
          rxNo: 'RX-2026-8910',
          patient: 'Nilesh Patel',
          ageSex: '45 / M',
          wardType: 'OPD (General)',
          doctor: 'Dr. Negi',
          drugs: 'Tab. Metformin 500mg x 30\nTab. Atorvastatin 10mg x 15',
          priority: 'Routine',
          time: '10 min ago',
          status: 'Pending Prep',
        ),
        DispenseQueueItem(
          rxNo: 'RX-2026-8911',
          patient: 'Sunita Rawat',
          ageSex: '38 / F',
          wardType: 'IPD (ICU-3)',
          doctor: 'Dr. Sharma',
          drugs: 'Inj. Ceftriaxone 1g x 2\nInj. Pantoprazole 40mg x 2',
          priority: 'Urgent',
          time: '5 min ago',
          status: 'Preparing',
        ),
        DispenseQueueItem(
          rxNo: 'RX-2026-8912',
          patient: 'Rajesh Kumar',
          ageSex: '29 / M',
          wardType: 'Emergency (T-1)',
          doctor: 'Dr. Verma',
          drugs: 'Tab. Paracetamol 650mg x 10\nInj. Diclofenac 75mg x 1',
          priority: 'Urgent',
          time: '12 min ago',
          status: 'Prepared',
        ),
      ],
      statOrders: [
        StatOrderItem(
          id: 'STAT-01',
          location: 'ICU Bed 3',
          patient: 'Rohan Bisht',
          doctor: 'Dr. Negi',
          orderedAt: DateTime.now().subtract(const Duration(minutes: 8)),
          drugs: 'Inj. Noradrenaline 4mg + Dopamine 200mg',
        ),
        StatOrderItem(
          id: 'STAT-02',
          location: 'HDU Bed 1',
          patient: 'Meera Joshi',
          doctor: 'Dr. Negi',
          orderedAt: DateTime.now().subtract(const Duration(minutes: 1)),
          drugs: 'Inj. Furosemide 20mg STAT',
        ),
        StatOrderItem(
          id: 'STAT-03',
          location: 'NICU Bed 2',
          patient: 'Infant of Seema',
          doctor: 'Dr. Joshi',
          orderedAt: DateTime.now().subtract(const Duration(minutes: 18)),
          drugs: 'Inj. Ampicillin 125mg + Inj. Amikacin 15mg',
        ),
      ],
      rxValidations: const [
        RxValidationItem(
          id: 'VAL-101',
          patient: 'Sunita Rawat',
          rxNo: 'RX-2026-1853',
          drug: 'Tab. Warfarin 5mg',
          category: 'Safety',
          warning: 'HIGH RISK: Warfarin - INR not checked today. Check latest INR levels before dispensing.',
          icon: Icons.security_rounded,
          color: Colors.red,
        ),
        RxValidationItem(
          id: 'VAL-102',
          patient: 'Rajesh Sharma',
          rxNo: 'RX-2026-1854',
          drug: 'Inj. Insulin 20u',
          category: 'Dose',
          warning: 'Dose seems high for body weight (60 kg) - verify clinical calculation with prescribing physician.',
          icon: Icons.scale_rounded,
          color: Colors.amber,
        ),
        RxValidationItem(
          id: 'VAL-103',
          patient: 'Meena Bisht',
          rxNo: 'RX-2026-1855',
          drug: 'Tab. Clarithromycin 500mg',
          category: 'Interaction',
          warning: 'Drug-drug interaction with Simvastatin. High risk of myopathy / rhabdomyolysis.',
          icon: Icons.swap_horizontal_circle_outlined,
          color: Colors.blue,
        ),
      ],
      inventory: const [
        DrugInventoryItem(
          name: 'Tab. Metformin 500mg',
          category: 'Anti-Diabetic',
          form: 'Tablet',
          batch: 'B-MET238',
          qty: 1200,
          minLevel: 200,
          mrp: 4.5,
          status: 'In Stock',
        ),
        DrugInventoryItem(
          name: 'Tab. Atorvastatin 10mg',
          category: 'Cardiovascular',
          form: 'Tablet',
          batch: 'B-ATO904',
          qty: 180,
          minLevel: 300,
          mrp: 12,
          status: 'Reorder Alert',
        ),
        DrugInventoryItem(
          name: 'Inj. Ceftriaxone 1g',
          category: 'Antibiotic',
          form: 'Vial',
          batch: 'B-CEF112',
          qty: 450,
          minLevel: 100,
          mrp: 45,
          status: 'In Stock',
        ),
        DrugInventoryItem(
          name: 'Inj. Insulin 100 IU',
          category: 'Hormone',
          form: 'Vial',
          batch: 'B-INS009',
          qty: 15,
          minLevel: 50,
          mrp: 210,
          status: 'Reorder Alert',
        ),
        DrugInventoryItem(
          name: 'Tab. Paracetamol 650mg',
          category: 'Analgesic',
          form: 'Tablet',
          batch: 'B-PCM504',
          qty: 5000,
          minLevel: 1000,
          mrp: 1.8,
          status: 'In Stock',
        ),
      ],
      expiryAlerts: const [
        ExpiryAlertItem(
          drug: 'Tab. Atorvastatin 10mg',
          batch: 'B-ATO904',
          expiryDate: '15-06-2026',
          daysLeft: 27,
          qty: 180,
          recommendedAction: 'Return to Supplier',
        ),
        ExpiryAlertItem(
          drug: 'Inj. Insulin 100 IU',
          batch: 'B-INS009',
          expiryDate: '08-06-2026',
          daysLeft: 20,
          qty: 15,
          recommendedAction: 'Quarantine Item',
        ),
      ],
      grnLogs: const [
        GrnLogItem(
          grnNo: 'GRN-2024-0458',
          supplier: 'Cipla Ltd.',
          invoice: 'INV-C-8821',
          items: 24,
          value: '₹84,500',
          receivedBy: 'Pharmacist Suresh',
          date: 'Today',
          status: 'verified',
        ),
        GrnLogItem(
          grnNo: 'GRN-2024-0457',
          supplier: 'Sun Pharma',
          invoice: 'INV-SP-3392',
          items: 18,
          value: '₹62,000',
          receivedBy: 'Pharmacist Suresh',
          date: 'Yesterday',
          status: 'verified',
        ),
        GrnLogItem(
          grnNo: 'GRN-2024-0456',
          supplier: "Dr. Reddy's",
          invoice: 'INV-DR-1123',
          items: 31,
          value: '₹1,15,800',
          receivedBy: 'Pharmacist Suresh',
          date: '3 days ago',
          status: 'partial',
        ),
      ],
      purchaseOrders: const [
        PurchaseOrderItem(
          poNo: 'PO-2024-009',
          vendor: 'Cipla Distribution',
          items: 12,
          estDelivery: '22-05-2026',
          status: 'SENT',
        ),
        PurchaseOrderItem(
          poNo: 'PO-2024-010',
          vendor: 'Sun Pharma Logistics',
          items: 5,
          estDelivery: '25-05-2026',
          status: 'PENDING APPROVAL',
        ),
        PurchaseOrderItem(
          poNo: 'PO-2024-011',
          vendor: "Dr. Reddy's Labs",
          items: 8,
          estDelivery: '28-05-2026',
          status: 'SENT',
        ),
      ],
    );
  }
}

final pharmacyProvider = StateNotifierProvider<PharmacyNotifier, PharmacyState>((ref) {
  return PharmacyNotifier();
});

final pharmacyTabProvider = StateProvider<String>((ref) => 'Dispense Queue');
