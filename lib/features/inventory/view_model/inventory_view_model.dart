import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/inventory_model.dart';

class InventoryState {
  final String activeTab;
  final List<InventoryItem> stock;
  final List<IndentItem> indents;
  final List<GrnItem> grnList;
  final List<PurchaseOrderItem> poList;
  final List<VendorItem> vendors;
  final List<AssetItem> assets;
  final List<ExpiryAlertItem> expiryAlerts;
  final bool isLoading;

  const InventoryState({
    required this.activeTab,
    required this.stock,
    required this.indents,
    required this.grnList,
    required this.poList,
    required this.vendors,
    required this.assets,
    required this.expiryAlerts,
    this.isLoading = false,
  });

  InventoryState copyWith({
    String? activeTab,
    List<InventoryItem>? stock,
    List<IndentItem>? indents,
    List<GrnItem>? grnList,
    List<PurchaseOrderItem>? poList,
    List<VendorItem>? vendors,
    List<AssetItem>? assets,
    List<ExpiryAlertItem>? expiryAlerts,
    bool? isLoading,
  }) {
    return InventoryState(
      activeTab: activeTab ?? this.activeTab,
      stock: stock ?? this.stock,
      indents: indents ?? this.indents,
      grnList: grnList ?? this.grnList,
      poList: poList ?? this.poList,
      vendors: vendors ?? this.vendors,
      assets: assets ?? this.assets,
      expiryAlerts: expiryAlerts ?? this.expiryAlerts,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class InventoryNotifier extends StateNotifier<InventoryState> {
  InventoryNotifier() : super(_initialState());

  void setTab(String tab) {
    state = state.copyWith(activeTab: tab);
  }

  void addInventoryItem(InventoryItem item) {
    state = state.copyWith(stock: [...state.stock, item]);
  }

  void approveIndent(String indentNo) {
    final updated = state.indents.map((i) {
      if (i.indentNo == indentNo) return i.copyWith(status: 'Approved');
      return i;
    }).toList();
    state = state.copyWith(indents: updated);
  }

  void issueIndent(String indentNo) {
    final updated = state.indents.map((i) {
      if (i.indentNo == indentNo) return i.copyWith(status: 'Issued');
      return i;
    }).toList();
    state = state.copyWith(indents: updated);
  }

  void rejectIndent(String indentNo) {
    final updated = state.indents.map((i) {
      if (i.indentNo == indentNo) return i.copyWith(status: 'Rejected');
      return i;
    }).toList();
    state = state.copyWith(indents: updated);
  }

  void addIndent(IndentItem indent) {
    state = state.copyWith(indents: [indent, ...state.indents]);
  }

  void addGrn(GrnItem grn) {
    state = state.copyWith(grnList: [grn, ...state.grnList]);
  }

  void addPurchaseOrder(PurchaseOrderItem po) {
    state = state.copyWith(poList: [po, ...state.poList]);
  }

  void addVendor(VendorItem vendor) {
    state = state.copyWith(vendors: [...state.vendors, vendor]);
  }

  void addAsset(AssetItem asset) {
    state = state.copyWith(assets: [...state.assets, asset]);
  }

  void removeExpiryAlert(String item, String batch) {
    final updated = state.expiryAlerts
        .where((e) => !(e.item == item && e.batch == batch))
        .toList();
    state = state.copyWith(expiryAlerts: updated);
  }

  static InventoryState _initialState() {
    return const InventoryState(
      activeTab: 'Stock',
      stock: [
        InventoryItem(
          code: 'MED-001',
          name: 'Paracetamol 500mg Tab',
          category: 'Medicines',
          unit: 'Strip',
          qtyInHand: 845,
          reorderLevel: 200,
          unitCost: 18.0,
          store: 'Pharmacy',
          status: 'In Stock',
        ),
        InventoryItem(
          code: 'MED-002',
          name: 'Amoxicillin 500mg Cap',
          category: 'Medicines',
          unit: 'Strip',
          qtyInHand: 320,
          reorderLevel: 100,
          unitCost: 85.0,
          store: 'Pharmacy',
          status: 'In Stock',
        ),
        InventoryItem(
          code: 'MED-003',
          name: 'Metformin 500mg Tab',
          category: 'Medicines',
          unit: 'Strip',
          qtyInHand: 54,
          reorderLevel: 150,
          unitCost: 45.0,
          store: 'Pharmacy',
          status: 'Low Stock',
        ),
        InventoryItem(
          code: 'SUR-001',
          name: 'Disposable Syringe 5ml',
          category: 'Surgical',
          unit: 'Box(100)',
          qtyInHand: 88,
          reorderLevel: 50,
          unitCost: 120.0,
          store: 'Surgical Store',
          status: 'In Stock',
        ),
        InventoryItem(
          code: 'SUR-002',
          name: 'IV Cannula 18G',
          category: 'Surgical',
          unit: 'Box(50)',
          qtyInHand: 22,
          reorderLevel: 30,
          unitCost: 380.0,
          store: 'Surgical Store',
          status: 'Low Stock',
        ),
        InventoryItem(
          code: 'SUR-003',
          name: 'Surgical Gloves L',
          category: 'Surgical',
          unit: 'Box(50)',
          qtyInHand: 145,
          reorderLevel: 50,
          unitCost: 280.0,
          store: 'Surgical Store',
          status: 'In Stock',
        ),
        InventoryItem(
          code: 'LAB-001',
          name: 'Haematology Control',
          category: 'Reagents/Chemicals',
          unit: 'Kit',
          qtyInHand: 8,
          reorderLevel: 5,
          unitCost: 2800.0,
          store: 'Lab Store',
          status: 'In Stock',
        ),
        InventoryItem(
          code: 'LAB-002',
          name: 'Blood Culture Bottle',
          category: 'Reagents/Chemicals',
          unit: 'No',
          qtyInHand: 42,
          reorderLevel: 20,
          unitCost: 180.0,
          store: 'Lab Store',
          status: 'In Stock',
        ),
        InventoryItem(
          code: 'CON-001',
          name: 'Examination Gloves M',
          category: 'Consumables',
          unit: 'Box(100)',
          qtyInHand: 65,
          reorderLevel: 30,
          unitCost: 240.0,
          store: 'Central Store',
          status: 'In Stock',
        ),
        InventoryItem(
          code: 'LIN-001',
          name: 'Hospital Bedsheet',
          category: 'Linen',
          unit: 'No',
          qtyInHand: 124,
          reorderLevel: 60,
          unitCost: 450.0,
          store: 'Linen Room',
          status: 'In Stock',
        ),
      ],
      indents: [
        IndentItem(
          indentNo: 'IND-001',
          dept: 'ICU',
          date: '12/04',
          itemsCount: 5,
          requestedBy: 'Sr. Nurse Priya',
          status: 'Approved',
        ),
        IndentItem(
          indentNo: 'IND-002',
          dept: 'Surgery',
          date: '11/04',
          itemsCount: 8,
          requestedBy: 'Charge Nurse Sunita',
          status: 'Pending',
        ),
        IndentItem(
          indentNo: 'IND-003',
          dept: 'Lab',
          date: '11/04',
          itemsCount: 3,
          requestedBy: 'Lab Tech Mohan',
          status: 'Issued',
        ),
        IndentItem(
          indentNo: 'IND-004',
          dept: 'Medicine',
          date: '10/04',
          itemsCount: 6,
          requestedBy: 'ANM Rekha',
          status: 'Pending',
        ),
        IndentItem(
          indentNo: 'IND-005',
          dept: 'OT',
          date: '10/04',
          itemsCount: 12,
          requestedBy: 'OT Nurse Geeta',
          status: 'Approved',
        ),
      ],
      grnList: [
        GrnItem(
          grnNo: 'GRN-001',
          poRef: 'PO-2025-008',
          vendor: 'Cipla Ltd.',
          date: '11/04',
          itemsCount: 18,
          value: '₹2,42,500',
          status: 'Completed',
        ),
        GrnItem(
          grnNo: 'GRN-002',
          poRef: 'PO-2025-009',
          vendor: 'Becton Dickinson',
          date: '10/04',
          itemsCount: 8,
          value: '₹1,12,000',
          status: 'Completed',
        ),
        GrnItem(
          grnNo: 'GRN-003',
          poRef: 'PO-2025-010',
          vendor: 'Sun Pharma',
          date: '09/04',
          itemsCount: 22,
          value: '₹3,80,000',
          status: 'Partial',
        ),
        GrnItem(
          grnNo: 'GRN-004',
          poRef: 'PO-2025-011',
          vendor: '3M India',
          date: '08/04',
          itemsCount: 5,
          value: '₹68,000',
          status: 'Completed',
        ),
      ],
      poList: [
        PurchaseOrderItem(
          poNo: 'PO-2025-012',
          vendor: 'Cipla Ltd.',
          date: '12/04',
          category: 'Medicines',
          value: '₹3,50,000',
          deliveryBy: '22/04',
          status: 'Open',
        ),
        PurchaseOrderItem(
          poNo: 'PO-2025-013',
          vendor: 'Philips Healthcare',
          date: '10/04',
          category: 'Equipment',
          value: '₹8,50,000',
          deliveryBy: '30/04',
          status: 'Open',
        ),
        PurchaseOrderItem(
          poNo: 'PO-2025-014',
          vendor: 'Becton Dickinson',
          date: '08/04',
          category: 'Surgical',
          value: '₹1,80,000',
          deliveryBy: '18/04',
          status: 'Partial GRN',
        ),
        PurchaseOrderItem(
          poNo: 'PO-2025-015',
          vendor: 'Sun Pharma',
          date: '05/04',
          category: 'Medicines',
          value: '₹5,20,000',
          deliveryBy: '15/04',
          status: 'Overdue',
        ),
        PurchaseOrderItem(
          poNo: 'PO-2025-016',
          vendor: '3M India',
          date: '01/04',
          category: 'Consumables',
          value: '₹92,000',
          deliveryBy: '10/04',
          status: 'Closed',
        ),
      ],
      vendors: [
        VendorItem(
          code: 'V-001',
          name: 'Cipla Ltd.',
          category: 'Pharmaceuticals',
          gstin: '27AAACI3528P1ZT',
          contact: '1800-222-123',
          rating: 4.8,
          status: 'Active',
        ),
        VendorItem(
          code: 'V-002',
          name: 'Sun Pharma',
          category: 'Pharmaceuticals',
          gstin: '24AAACS9128C1ZN',
          contact: '022-66455645',
          rating: 4.5,
          status: 'Active',
        ),
        VendorItem(
          code: 'V-003',
          name: 'Becton Dickinson',
          category: 'Surgical/Diagnostics',
          gstin: '07AABCB4876M1ZK',
          contact: '011-42585858',
          rating: 4.7,
          status: 'Active',
        ),
        VendorItem(
          code: 'V-004',
          name: '3M India',
          category: 'Consumables',
          gstin: '07AAACM0035J1ZZ',
          contact: '1800-102-3M3M',
          rating: 4.3,
          status: 'Active',
        ),
        VendorItem(
          code: 'V-005',
          name: 'Philips Healthcare',
          category: 'Medical Equipment',
          gstin: '07AABCP2884R1ZF',
          contact: '1860-267-2800',
          rating: 4.6,
          status: 'Active',
        ),
        VendorItem(
          code: 'V-006',
          name: 'Triveni Medical',
          category: 'Local Supplier',
          gstin: '05AAFCT1234A1Z2',
          contact: '0135-2655432',
          rating: 3.9,
          status: 'On Hold',
        ),
      ],
      assets: [
        AssetItem(
          assetId: 'AST-001',
          name: 'Ventilator (ICU)',
          category: 'Medical Equipment',
          location: 'ICU Bed 3',
          purchaseDate: 'Jan 2023',
          amcExpiry: 'Dec 2025',
          status: 'Active',
        ),
        AssetItem(
          assetId: 'AST-002',
          name: 'ECG Machine',
          category: 'Diagnostic',
          location: 'Casualty',
          purchaseDate: 'Mar 2022',
          amcExpiry: 'Feb 2026',
          status: 'Active',
        ),
        AssetItem(
          assetId: 'AST-003',
          name: 'Ultrasound Machine',
          category: 'Radiology',
          location: 'OPD Room 10',
          purchaseDate: 'Jun 2021',
          amcExpiry: 'May 2025',
          status: 'AMC Expiring',
        ),
        AssetItem(
          assetId: 'AST-004',
          name: 'Autoclave 134L',
          category: 'Sterilisation',
          location: 'CSSD',
          purchaseDate: 'Apr 2020',
          amcExpiry: 'Mar 2024',
          status: 'AMC Expired',
        ),
        AssetItem(
          assetId: 'AST-005',
          name: 'Hematology Analyser',
          category: 'Lab Equipment',
          location: 'Lab Room 2',
          purchaseDate: 'Sep 2023',
          amcExpiry: 'Aug 2026',
          status: 'Active',
        ),
        AssetItem(
          assetId: 'AST-006',
          name: 'Digital X-Ray Unit',
          category: 'Radiology',
          location: 'Radiology Wing',
          purchaseDate: 'Jan 2024',
          amcExpiry: 'Dec 2026',
          status: 'Active',
        ),
      ],
      expiryAlerts: [
        ExpiryAlertItem(
          item: 'Metformin 500mg Tab',
          category: 'Medicines',
          batch: 'MF2025A',
          qty: 54,
          expiryDate: '30/04/2026',
          daysLeft: 18,
        ),
        ExpiryAlertItem(
          item: 'Blood Culture Bottle',
          category: 'Lab',
          batch: 'BCB2025X',
          qty: 42,
          expiryDate: '25/04/2026',
          daysLeft: 13,
        ),
        ExpiryAlertItem(
          item: 'IV Cannula 18G Box',
          category: 'Surgical',
          batch: 'IVC2024C',
          qty: 22,
          expiryDate: '20/04/2026',
          daysLeft: 8,
        ),
        ExpiryAlertItem(
          item: 'Haematology Control',
          category: 'Lab',
          batch: 'HC25APR',
          qty: 3,
          expiryDate: '18/04/2026',
          daysLeft: 6,
        ),
        ExpiryAlertItem(
          item: 'Amoxicillin 500mg Cap',
          category: 'Medicines',
          batch: 'AMOX25B',
          qty: 48,
          expiryDate: '15/04/2026',
          daysLeft: 3,
        ),
      ],
    );
  }
}

final inventoryProvider =
    StateNotifierProvider<InventoryNotifier, InventoryState>((ref) {
  return InventoryNotifier();
});

final inventoryTabProvider = StateProvider<String>((ref) => 'Stock');
