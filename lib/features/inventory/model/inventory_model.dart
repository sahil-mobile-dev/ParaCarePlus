class InventoryItem {
  final String code;
  final String name;
  final String category;
  final String unit;
  final int qtyInHand;
  final int reorderLevel;
  final double unitCost;
  final String store;
  final String status; // 'In Stock', 'Low Stock'

  const InventoryItem({
    required this.code,
    required this.name,
    required this.category,
    required this.unit,
    required this.qtyInHand,
    required this.reorderLevel,
    required this.unitCost,
    required this.store,
    required this.status,
  });

  double get value => qtyInHand * unitCost;

  InventoryItem copyWith({
    String? code,
    String? name,
    String? category,
    String? unit,
    int? qtyInHand,
    int? reorderLevel,
    double? unitCost,
    String? store,
    String? status,
  }) {
    return InventoryItem(
      code: code ?? this.code,
      name: name ?? this.name,
      category: category ?? this.category,
      unit: unit ?? this.unit,
      qtyInHand: qtyInHand ?? this.qtyInHand,
      reorderLevel: reorderLevel ?? this.reorderLevel,
      unitCost: unitCost ?? this.unitCost,
      store: store ?? this.store,
      status: status ?? this.status,
    );
  }
}

class IndentItem {
  final String indentNo;
  final String dept;
  final String date;
  final int itemsCount;
  final String requestedBy;
  final String status; // 'Pending', 'Approved', 'Issued', 'Rejected'

  const IndentItem({
    required this.indentNo,
    required this.dept,
    required this.date,
    required this.itemsCount,
    required this.requestedBy,
    required this.status,
  });

  IndentItem copyWith({
    String? indentNo,
    String? dept,
    String? date,
    int? itemsCount,
    String? requestedBy,
    String? status,
  }) {
    return IndentItem(
      indentNo: indentNo ?? this.indentNo,
      dept: dept ?? this.dept,
      date: date ?? this.date,
      itemsCount: itemsCount ?? this.itemsCount,
      requestedBy: requestedBy ?? this.requestedBy,
      status: status ?? this.status,
    );
  }
}

class GrnItem {
  final String grnNo;
  final String poRef;
  final String vendor;
  final String date;
  final int itemsCount;
  final String value; // e.g. "₹2,42,500" or raw number
  final String status; // 'Completed', 'Partial'

  const GrnItem({
    required this.grnNo,
    required this.poRef,
    required this.vendor,
    required this.date,
    required this.itemsCount,
    required this.value,
    required this.status,
  });

  GrnItem copyWith({
    String? grnNo,
    String? poRef,
    String? vendor,
    String? date,
    int? itemsCount,
    String? value,
    String? status,
  }) {
    return GrnItem(
      grnNo: grnNo ?? this.grnNo,
      poRef: poRef ?? this.poRef,
      vendor: vendor ?? this.vendor,
      date: date ?? this.date,
      itemsCount: itemsCount ?? this.itemsCount,
      value: value ?? this.value,
      status: status ?? this.status,
    );
  }
}

class PurchaseOrderItem {
  final String poNo;
  final String vendor;
  final String date;
  final String category;
  final String value;
  final String deliveryBy;
  final String status; // 'Open', 'Partial GRN', 'Overdue', 'Closed'

  const PurchaseOrderItem({
    required this.poNo,
    required this.vendor,
    required this.date,
    required this.category,
    required this.value,
    required this.deliveryBy,
    required this.status,
  });

  PurchaseOrderItem copyWith({
    String? poNo,
    String? vendor,
    String? date,
    String? category,
    String? value,
    String? deliveryBy,
    String? status,
  }) {
    return PurchaseOrderItem(
      poNo: poNo ?? this.poNo,
      vendor: vendor ?? this.vendor,
      date: date ?? this.date,
      category: category ?? this.category,
      value: value ?? this.value,
      deliveryBy: deliveryBy ?? this.deliveryBy,
      status: status ?? this.status,
    );
  }
}

class VendorItem {
  final String code;
  final String name;
  final String category;
  final String gstin;
  final String contact;
  final double rating;
  final String status; // 'Active', 'On Hold'

  const VendorItem({
    required this.code,
    required this.name,
    required this.category,
    required this.gstin,
    required this.contact,
    required this.rating,
    required this.status,
  });

  VendorItem copyWith({
    String? code,
    String? name,
    String? category,
    String? gstin,
    String? contact,
    double? rating,
    String? status,
  }) {
    return VendorItem(
      code: code ?? this.code,
      name: name ?? this.name,
      category: category ?? this.category,
      gstin: gstin ?? this.gstin,
      contact: contact ?? this.contact,
      rating: rating ?? this.rating,
      status: status ?? this.status,
    );
  }
}

class AssetItem {
  final String assetId;
  final String name;
  final String category;
  final String location;
  final String purchaseDate;
  final String amcExpiry;
  final String status; // 'Active', 'AMC Expiring', 'AMC Expired'

  const AssetItem({
    required this.assetId,
    required this.name,
    required this.category,
    required this.location,
    required this.purchaseDate,
    required this.amcExpiry,
    required this.status,
  });

  AssetItem copyWith({
    String? assetId,
    String? name,
    String? category,
    String? location,
    String? purchaseDate,
    String? amcExpiry,
    String? status,
  }) {
    return AssetItem(
      assetId: assetId ?? this.assetId,
      name: name ?? this.name,
      category: category ?? this.category,
      location: location ?? this.location,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      amcExpiry: amcExpiry ?? this.amcExpiry,
      status: status ?? this.status,
    );
  }
}

class ExpiryAlertItem {
  final String item;
  final String category;
  final String batch;
  final int qty;
  final String expiryDate;
  final int daysLeft;

  const ExpiryAlertItem({
    required this.item,
    required this.category,
    required this.batch,
    required this.qty,
    required this.expiryDate,
    required this.daysLeft,
  });

  ExpiryAlertItem copyWith({
    String? item,
    String? category,
    String? batch,
    int? qty,
    String? expiryDate,
    int? daysLeft,
  }) {
    return ExpiryAlertItem(
      item: item ?? this.item,
      category: category ?? this.category,
      batch: batch ?? this.batch,
      qty: qty ?? this.qty,
      expiryDate: expiryDate ?? this.expiryDate,
      daysLeft: daysLeft ?? this.daysLeft,
    );
  }
}
