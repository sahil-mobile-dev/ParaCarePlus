import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

enum BillingSubTab {
  dashboard('Dashboard', Icons.analytics_outlined),
  newBill('New Bill / Invoice', Icons.add_card_outlined),
  records('Bill Records', Icons.receipt_long_outlined),
  payments('Payments', Icons.payments_outlined),
  insurance('Insurance / TPA', Icons.shield_outlined),
  credit('Credit / Advances', Icons.account_balance_wallet_outlined),
  refunds('Refunds', Icons.assignment_return_outlined),
  revenue('Revenue Reports', Icons.insert_chart_outlined);

  const BillingSubTab(this.label, this.icon);
  final String label;
  final IconData icon;
}

class PatientBillsTab extends StatefulWidget {
  const PatientBillsTab({super.key});

  @override
  State<PatientBillsTab> createState() => _PatientBillsTabState();
}

class _PatientBillsTabState extends State<PatientBillsTab> {
  BillingSubTab _activeSubTab = BillingSubTab.dashboard;

  // 1. Bill Records Database
  final List<Map<String, dynamic>> _billRecords = [
    {
      'no': 'BL-001',
      'patient': 'Ramesh Kumar',
      'uhid': 'UK-00421',
      'visit': 'IPD',
      'date': '26/05/2026',
      'amount': 12500,
      'paid': 12500,
      'balance': 0,
      'status': 'Paid',
    },
    {
      'no': 'BL-002',
      'patient': 'Savita Devi',
      'uhid': 'UK-00318',
      'visit': 'OPD',
      'date': '26/05/2026',
      'amount': 850,
      'paid': 850,
      'balance': 0,
      'status': 'Paid',
    },
    {
      'no': 'BL-003',
      'patient': 'Kishore Negi',
      'uhid': 'UK-00512',
      'visit': 'IPD',
      'date': '25/05/2026',
      'amount': 4500,
      'paid': 2000,
      'balance': 2500,
      'status': 'Partial',
    },
    {
      'no': 'BL-004',
      'patient': 'Meena Bisht',
      'uhid': 'UK-00290',
      'visit': 'OPD',
      'date': '25/05/2026',
      'amount': 1200,
      'paid': 0,
      'balance': 1200,
      'status': 'Pending',
    },
    {
      'no': 'BL-005',
      'patient': 'Arjun Singh',
      'uhid': 'UK-00601',
      'visit': 'Emergency',
      'date': '24/05/2026',
      'amount': 3200,
      'paid': 3200,
      'balance': 0,
      'status': 'Paid',
    },
    {
      'no': 'BL-006',
      'patient': 'Pushpa Karki',
      'uhid': 'UK-00445',
      'visit': 'OPD',
      'date': '24/05/2026',
      'amount': 650,
      'paid': 650,
      'balance': 0,
      'status': 'Paid',
    },
    {
      'no': 'BL-007',
      'patient': 'Mohan Lal',
      'uhid': 'UK-00389',
      'visit': 'IPD',
      'date': '23/05/2026',
      'amount': 8900,
      'paid': 0,
      'balance': 8900,
      'status': 'Credit',
    },
    {
      'no': 'BL-008',
      'patient': 'Anita Thapa',
      'uhid': 'UK-00271',
      'visit': 'OPD',
      'date': '22/05/2026',
      'amount': 720,
      'paid': 720,
      'balance': 0,
      'status': 'Paid',
    },
  ];

  // 2. Recent Payments Collection Logs
  final List<Map<String, dynamic>> _collections = [
    {
      'time': '08:22 AM',
      'patient': 'Savita Devi',
      'amount': 850,
      'mode': 'UPI',
      'by': 'Mohan (Cashier)',
    },
    {
      'time': '09:05 AM',
      'patient': 'Ramesh Kumar',
      'amount': 12500,
      'mode': 'Card',
      'by': 'Reena (Cashier)',
    },
    {
      'time': '10:30 AM',
      'patient': 'Arjun Singh',
      'amount': 3200,
      'mode': 'Cash',
      'by': 'Mohan (Cashier)',
    },
    {
      'time': '11:15 AM',
      'patient': 'Kishore Negi',
      'amount': 2000,
      'mode': 'UPI',
      'by': 'Reena (Cashier)',
    },
  ];

  // 3. Pre-Auth Insurance Logs
  final List<Map<String, dynamic>> _preAuthRequests = [
    {
      'patient': 'Ramesh Kumar',
      'uhid': 'UK-00421',
      'procedure': 'Angioplasty Stent',
      'amount': 145000,
      'status': 'Approved',
      'tpa': 'MD India TPA',
    },
    {
      'patient': 'Karan Singh',
      'uhid': 'UK-00510',
      'procedure': 'Coronary Angiography',
      'amount': 18000,
      'status': 'Under Process',
      'tpa': 'Star Health TPA',
    },
    {
      'patient': 'Amit Bisht',
      'uhid': 'UK-00513',
      'procedure': 'CCU Ward Stay (4 Days)',
      'amount': 60000,
      'status': 'Under Process',
      'tpa': 'Star Health TPA',
    },
    {
      'patient': 'Anita Dhyani',
      'uhid': 'UK-00515',
      'procedure': 'Double Valve replacement',
      'amount': 380000,
      'status': 'Query Raised',
      'tpa': 'HDFC Ergo TPA',
    },
  ];

  // 4. Advances & Deposits Logs
  final List<Map<String, dynamic>> _deposits = [
    {
      'patient': 'Sanjay Rawat',
      'uhid': 'UK-00508',
      'date': '24/05/2026',
      'amount': 50000,
      'used': 15000,
      'balance': 35000,
    },
    {
      'patient': 'Mohan Lal',
      'uhid': 'UK-00389',
      'date': '23/05/2026',
      'amount': 10000,
      'used': 10000,
      'balance': 0,
    },
    {
      'patient': 'Amit Bisht',
      'uhid': 'UK-00513',
      'date': '22/05/2026',
      'amount': 25000,
      'used': 5000,
      'balance': 20000,
    },
  ];

  // 5. Refund logs
  final List<Map<String, dynamic>> _refunds = [
    {
      'no': 'RF-011',
      'billNo': 'BL-004',
      'patient': 'Meena Bisht',
      'reason': 'Lab test cancelled',
      'amount': 450,
      'by': 'Dr. Sharma',
      'status': 'Approved',
    },
    {
      'no': 'RF-012',
      'billNo': 'BL-007',
      'patient': 'Mohan Lal',
      'reason': 'Double billing error',
      'amount': 1200,
      'by': 'Admin',
      'status': 'Pending',
    },
  ];

  // New Invoice Generator Active States
  final _newBillUhid = TextEditingController(text: 'UK-00421');
  final _newBillPatient = TextEditingController(text: 'Ramesh Kumar');
  final _newBillType = 'OPD';
  var _newBillPayType = 'Cash';

  // Dynamic invoice service lines
  final List<Map<String, dynamic>> _activeInvoiceItems = [
    {
      'name': 'Doctor Consultation Charge',
      'category': 'Consultation',
      'qty': 1,
      'rate': 800,
    },
    {
      'name': 'CBC with Hemoglobin test',
      'category': 'Investigation',
      'qty': 1,
      'rate': 450,
    },
  ];

  final _customServiceName = TextEditingController();
  final _customServiceRate = TextEditingController();

  // Discount settings
  var _discountType = 'None';
  final _discountValue = TextEditingController(text: '0');

  // Collect Payment Form States
  final _collectBillNo = TextEditingController(text: 'BL-003');
  final _collectUhid = TextEditingController(text: 'UK-00512');
  final _collectPatient = TextEditingController(text: 'Kishore Negi');
  var _collectAmount = 2500;
  var _collectMode = 'UPI';

  @override
  void dispose() {
    _newBillUhid.dispose();
    _newBillPatient.dispose();
    _customServiceName.dispose();
    _customServiceRate.dispose();
    _discountValue.dispose();
    _collectBillNo.dispose();
    _collectUhid.dispose();
    _collectPatient.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopbar(context),
          const SizedBox(height: AppSpacing.lg),
          _buildStatsGrid(),
          const SizedBox(height: AppSpacing.lg),
          _buildTabBar(),
          const SizedBox(height: AppSpacing.md),
          _buildSelectedSubTabContent(context),
        ],
      ),
    );
  }

  Widget _buildTopbar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'PARACARE+ HMIS → BILLING & FINANCE',
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.secondaryText,
                letterSpacing: 0.8,
              ),
            ),
            Row(
              children: [
                const Icon(
                  Icons.account_balance_wallet_rounded,
                  color: AppColors.success,
                  size: 28,
                ),
                const SizedBox(width: 8),
                Text(
                  'Billing & Finance Command Desk',
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.add_card_rounded, size: 16),
              label: const Text('Generate New Bill'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
              ),
              onPressed: () {
                setState(() => _activeSubTab = BillingSubTab.newBill);
              },
            ),
            const SizedBox(width: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.download_rounded, size: 16),
              label: const Text('Export Records'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.surface,
                foregroundColor: AppColors.primaryText,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Financial billing summary exported to CSV successfully.',
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsGrid() {
    final totalRev = _billRecords.fold<int>(
      0,
      (sum, r) => sum + (r['amount'] as int),
    );
    final outstanding = _billRecords.fold<int>(
      0,
      (sum, r) => sum + (r['balance'] as int),
    );
    final pendingClaims = _preAuthRequests
        .where((r) => r['status'] == 'Under Process')
        .length;

    return Column(
      children: [
        Row(
          children: [
            _buildStatCard(
              "Today's Collections",
              '₹${totalRev - outstanding}',
              'Paid transactions',
              AppColors.success,
              Icons.check_circle_outline,
            ),
            const SizedBox(width: 12),
            _buildStatCard(
              'Generated Bills',
              '${_billRecords.length} Bills',
              'OPD / IPD Ledger',
              AppColors.primary,
              Icons.assignment_outlined,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            _buildStatCard(
              'Outstanding Dues',
              '₹$outstanding',
              'Pending collection',
              AppColors.secondaryAccent,
              Icons.hourglass_empty_rounded,
            ),
            const SizedBox(width: 12),
            _buildStatCard(
              'Claims Under Process',
              '$pendingClaims Claims',
              'Pre-auth verification',
              AppColors.error,
              Icons.security_outlined,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String label,
    String value,
    String meta,
    Color accentColor,
    IconData icon,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.grey, width: 1),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.secondaryText,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  value,
                  style: AppTextStyles.titleMedium.copyWith(
                    color: accentColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 18.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  meta,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.secondaryText,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Icon(
                icon,
                color: AppColors.border.withValues(alpha: 0.5),
                size: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: BillingSubTab.values.map((tab) {
            final isSelected = _activeSubTab == tab;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: ChoiceChip(
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      tab.icon,
                      size: 14,
                      color: isSelected
                          ? Colors.white
                          : AppColors.secondaryText,
                    ),
                    const SizedBox(width: 6),
                    Text(tab.label),
                  ],
                ),
                selected: isSelected,
                onSelected: (val) {
                  if (val) {
                    setState(() => _activeSubTab = tab);
                  }
                },
                selectedColor: AppColors.success,
                backgroundColor: Colors.transparent,
                labelStyle: AppTextStyles.labelSmall.copyWith(
                  color: isSelected ? Colors.white : AppColors.primaryText,
                  fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                side: BorderSide.none,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildSelectedSubTabContent(BuildContext context) {
    switch (_activeSubTab) {
      case BillingSubTab.dashboard:
        return _buildDashboardPanel(context);
      case BillingSubTab.newBill:
        return _buildNewBillPanel(context);
      case BillingSubTab.records:
        return _buildRecordsPanel();
      case BillingSubTab.payments:
        return _buildPaymentsPanel();
      case BillingSubTab.insurance:
        return _buildInsurancePanel(context);
      case BillingSubTab.credit:
        return _buildCreditPanel(context);
      case BillingSubTab.refunds:
        return _buildRefundsPanel(context);
      case BillingSubTab.revenue:
        return _buildRevenueReportsPanel();
    }
  }

  // Sub Tab 1: Dashboard Panel
  Widget _buildDashboardPanel(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left - Recent Transactions list
        Container(
          height: 390,
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'RECENT BILLING TRANSACTIONS',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: AppColors.secondaryText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () =>
                        setState(() => _activeSubTab = BillingSubTab.records),
                    child: const Text('View All Ledger'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 300,
                child: ListView.separated(
                  itemCount: _billRecords.take(5).length,
                  separatorBuilder: (_, __) =>
                      const Divider(color: AppColors.border, height: 1),
                  itemBuilder: (context, idx) {
                    final item = _billRecords[idx];
                    final isPaid = item['status'] == 'Paid';
                    final statusColor = isPaid
                        ? AppColors.success
                        : AppColors.secondaryAccent;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['no'] as String,
                                  style: const TextStyle(
                                    color: AppColors.primaryText,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  'UHID: ${item['uhid']} · Visit: ${item['visit']}',
                                  style: const TextStyle(
                                    color: AppColors.secondaryText,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              item['patient'] as String,
                              style: const TextStyle(
                                color: AppColors.primaryText,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.5,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '₹${item['amount']}',
                              style: const TextStyle(
                                color: AppColors.primaryText,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.5,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: statusColor.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: statusColor,
                                width: 0.5,
                              ),
                            ),
                            child: Text(
                              item['status'] as String,
                              style: TextStyle(
                                color: statusColor,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Right - Billing KPIs
        Container(
          height: 360,
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "TODAY'S FINANCIAL KPIS",
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.secondaryText,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildKpiRow('Average Consultation Bill', '₹950', 'General OPD'),
              _buildKpiRow(
                'UPI / Digital Payment Ratio',
                '78%',
                'Live tracker',
              ),
              _buildKpiRow('Cash Collections', '₹34,500', 'Live cashier box'),
              _buildKpiRow(
                'Ayushman Scheme Approvals',
                '₹1.1L',
                'PMJAY panels',
              ),
              _buildKpiRow(
                'Refund Requests Raised',
                '2 Requests',
                'Biomedical checks',
              ),
              const Divider(color: AppColors.border, height: 24),
              const Text(
                'FINANCIAL RECONCILIATION',
                style: TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'All digital bank channels UPI/NEFT reconciled at 12:00 AM daily. Physical cashier logs require mandatory approval before shifts swap.',
                style: TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 11,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildKpiRow(String label, String val, String meta) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  meta,
                  style: const TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          Text(
            val,
            style: const TextStyle(
              color: AppColors.success,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  // Sub Tab 2: New Bill / Invoice Panel
  Widget _buildNewBillPanel(BuildContext context) {
    // Math logic
    final subtotal = _activeInvoiceItems.fold(0, (sum, item) {
      return sum + ((item['qty'] as int) * (item['rate'] as int));
    });
    var discount = 0;
    final discVal = int.tryParse(_discountValue.text) ?? 0;
    if (_discountType == 'Percentage') {
      discount = subtotal * discVal ~/ 100;
    } else if (_discountType == 'Flat Amount') {
      discount = discVal;
    }

    final gst = ((subtotal - discount) * 0.05).toInt();
    final grandTotal = (subtotal - discount) + (gst * 2);

    return Column(
      children: [
        // Left Column: Bill items & details builder
        // Container(
        //   height: 360,
        //   padding: const EdgeInsets.all(AppSpacing.md),
        //   decoration: BoxDecoration(
        //     color: AppColors.card,
        //     borderRadius: BorderRadius.circular(14),
        //     border: Border.all(color: AppColors.border),
        //   ),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Text(
        //         'PATIENT INFORMATION & ADMISSION TYPE',
        //         style: AppTextStyles.labelSmall.copyWith(
        //           color: AppColors.secondaryText,
        //           fontWeight: FontWeight.bold,
        //         ),
        //       ),
        //       const SizedBox(height: 12),
        //       Row(
        //         children: [
        //           Expanded(
        //             child: Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 const Text(
        //                   'Patient UHID',
        //                   style: AppTextStyles.labelSmall,
        //                 ),
        //                 const SizedBox(height: 4),
        //                 TextField(
        //                   controller: _newBillUhid,
        //                   style: const TextStyle(
        //                     color: AppColors.primaryText,
        //                     fontSize: 12.5,
        //                   ),
        //                   decoration: InputDecoration(
        //                     filled: true,
        //                     fillColor: AppColors.background,
        //                     border: OutlineInputBorder(
        //                       borderRadius: BorderRadius.circular(8),
        //                     ),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //           const SizedBox(width: 8),
        //           Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               const Text(
        //                 'Patient Name',
        //                 style: AppTextStyles.labelSmall,
        //               ),
        //               const SizedBox(height: 4),
        //               TextField(
        //                 controller: _newBillPatient,
        //                 style: const TextStyle(
        //                   color: AppColors.primaryText,
        //                   fontSize: 12.5,
        //                 ),
        //                 decoration: InputDecoration(
        //                   filled: true,
        //                   fillColor: AppColors.background,
        //                   border: OutlineInputBorder(
        //                     borderRadius: BorderRadius.circular(8),
        //                   ),
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ],
        //       ),
        //       const SizedBox(height: 8),
        //       Row(
        //         children: [
        //           Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               const Text('Visit Type', style: AppTextStyles.labelSmall),
        //               const SizedBox(height: 4),
        //               DropdownButtonFormField<String>(
        //                 dropdownColor: AppColors.card,
        //                 initialValue: _newBillType,
        //                 items: ['OPD', 'IPD', 'Emergency', 'Day Care']
        //                     .map(
        //                       (t) => DropdownMenuItem(
        //                         value: t,
        //                         child: Text(
        //                           t,
        //                           style: const TextStyle(
        //                             color: AppColors.primaryText,
        //                           ),
        //                         ),
        //                       ),
        //                     )
        //                     .toList(),
        //                 onChanged: (val) {
        //                   if (val != null) setState(() => _newBillType = val);
        //                 },
        //                 decoration: InputDecoration(
        //                   filled: true,
        //                   fillColor: AppColors.background,
        //                   border: OutlineInputBorder(
        //                     borderRadius: BorderRadius.circular(8),
        //                   ),
        //                 ),
        //               ),
        //             ],
        //           ),
        //           const SizedBox(width: 8),
        //           Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               const Text('Department', style: AppTextStyles.labelSmall),
        //               const SizedBox(height: 4),
        //               DropdownButtonFormField<String>(
        //                 dropdownColor: AppColors.card,
        //                 initialValue: _newBillDept,
        //                 items:
        //                     [
        //                           'General Medicine',
        //                           'Cardiology',
        //                           'Surgery',
        //                           'Orthopaedics',
        //                           'Pediatrics',
        //                         ]
        //                         .map(
        //                           (d) => DropdownMenuItem(
        //                             value: d,
        //                             child: Text(
        //                               d,
        //                               style: const TextStyle(
        //                                 color: AppColors.primaryText,
        //                                 fontSize: 12,
        //                               ),
        //                             ),
        //                           ),
        //                         )
        //                         .toList(),
        //                 onChanged: (val) {
        //                   if (val != null) setState(() => _newBillDept = val);
        //                 },
        //                 decoration: InputDecoration(
        //                   filled: true,
        //                   fillColor: AppColors.background,
        //                   border: OutlineInputBorder(
        //                     borderRadius: BorderRadius.circular(8),
        //                   ),
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ],
        //       ),
        //     ],
        //   ),
        // ),
        // const SizedBox(height: 12),
        // // Service catalog card
        // Container(
        //   height: 450,
        //   padding: const EdgeInsets.all(AppSpacing.md),
        //   decoration: BoxDecoration(
        //     color: AppColors.card,
        //     borderRadius: BorderRadius.circular(14),
        //     border: Border.all(color: AppColors.border),
        //   ),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           Text(
        //             'SERVICES & ITEM CHARGES',
        //             style: AppTextStyles.labelSmall.copyWith(
        //               color: AppColors.secondaryText,
        //               fontWeight: FontWeight.bold,
        //             ),
        //           ),
        //           TextButton.icon(
        //             icon: const Icon(Icons.add, size: 14),
        //             label: const Text('Add Service Line'),
        //             onPressed: () => _openAddCustomServiceDialog(context),
        //           ),
        //         ],
        //       ),
        //       const SizedBox(height: 8),
        //       // Render list
        //       ..._activeInvoiceItems.map((item) {
        //         return Container(
        //           margin: const EdgeInsets.only(bottom: 6),
        //           padding: const EdgeInsets.all(8),
        //           decoration: BoxDecoration(
        //             color: AppColors.background.withValues(alpha: 0.5),
        //             borderRadius: BorderRadius.circular(8),
        //             border: Border.all(color: AppColors.border),
        //           ),
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               Expanded(
        //                 child: Column(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     Text(
        //                       item['name'] as String,
        //                       style: const TextStyle(
        //                         color: AppColors.primaryText,
        //                         fontWeight: FontWeight.bold,
        //                         fontSize: 12,
        //                       ),
        //                     ),
        //                     Text(
        //                       'Category: ${item['category']} · Qty: ${item['qty']}',
        //                       style: const TextStyle(
        //                         color: AppColors.secondaryText,
        //                         fontSize: 10,
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //               Text(
        //                 '₹${item['rate']}',
        //                 style: const TextStyle(
        //                   color: AppColors.primaryText,
        //                   fontWeight: FontWeight.bold,
        //                   fontSize: 12.5,
        //                 ),
        //               ),
        //               IconButton(
        //                 icon: const Icon(
        //                   Icons.delete_outline,
        //                   color: AppColors.error,
        //                   size: 18,
        //                 ),
        //                 onPressed: () {
        //                   setState(() {
        //                     _activeInvoiceItems.remove(item);
        //                   });
        //                 },
        //               ),
        //             ],
        //           ),
        //         );
        //       }),
        //     ],
        //   ),
        // ),
        // const SizedBox(height: 12),
        // // Discounts card
        Container(
          height: 250,
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SCHEME DISCOUNTS & INSURANCE CO-PAY',
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.secondaryText,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  SizedBox(
                    width: 250,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Discount Type',
                          style: AppTextStyles.labelSmall,
                        ),
                        const SizedBox(height: 4),
                        DropdownButtonFormField<String>(
                          dropdownColor: AppColors.card,
                          initialValue: _discountType,
                          items:
                              [
                                    'None',
                                    'Percentage',
                                    'Flat Amount',
                                    'State Govt Scheme',
                                  ]
                                  .map(
                                    (d) => DropdownMenuItem(
                                      value: d,
                                      child: Text(
                                        d,
                                        style: const TextStyle(
                                          color: AppColors.primaryText,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (val) {
                            if (val != null) {
                              setState(() => _discountType = val);
                            }
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.background,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Value', style: AppTextStyles.labelSmall),
                      const SizedBox(height: 4),
                      TextField(
                        controller: _discountValue,
                        style: const TextStyle(
                          color: AppColors.primaryText,
                          fontSize: 13,
                        ),
                        onChanged: (val) => setState(() {}),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.background,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Right Column: Live summary & print actions
        Container(
          height: 400,
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'INVOICE LEDGER SUMMARY',
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.secondaryText,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildSummaryLine('Subtotal', '₹$subtotal'),
              _buildSummaryLine(
                'Discount',
                '- ₹$discount',
                color: AppColors.secondaryAccent,
              ),
              _buildSummaryLine('CGST (5%)', '₹$gst'),
              _buildSummaryLine('SGST (5%)', '₹$gst'),
              const Divider(color: AppColors.border, height: 20),
              _buildSummaryLine('GRAND TOTAL', '₹$grandTotal', isHeader: true),
              const SizedBox(height: 16),
              const Text('Payment Mode', style: AppTextStyles.labelSmall),
              const SizedBox(height: 6),
              DropdownButtonFormField<String>(
                dropdownColor: AppColors.card,
                initialValue: _newBillPayType,
                items:
                    [
                          'Cash',
                          'UPI',
                          'Credit Card',
                          'Insurance TPA',
                          'Net Banking',
                        ]
                        .map(
                          (p) => DropdownMenuItem(
                            value: p,
                            child: Text(
                              p,
                              style: const TextStyle(
                                color: AppColors.primaryText,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _newBillPayType = val);
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.background,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const Spacer(),
              ElevatedButton.icon(
                icon: const Icon(Icons.print_rounded, size: 16),
                label: const Text('Approve & Print Bill'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.success,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(42),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _billRecords.insert(0, {
                      'no': 'BL-00${_billRecords.length + 1}',
                      'patient': _newBillPatient.text.isEmpty
                          ? 'Karan Kumar'
                          : _newBillPatient.text,
                      'uhid': _newBillUhid.text.isEmpty
                          ? 'UK-00516'
                          : _newBillUhid.text,
                      'visit': _newBillType,
                      'date': 'Today',
                      'amount': grandTotal,
                      'paid': grandTotal,
                      'balance': 0,
                      'status': 'Paid',
                    });
                    _collections.insert(0, {
                      'time': '01:10 PM',
                      'patient': _newBillPatient.text,
                      'amount': grandTotal,
                      'mode': _newBillPayType,
                      'by': 'Alok Verma (Cardiologist)',
                    });
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Invoice generated for ${_newBillPatient.text}. Reconciled grand total: ₹$grandTotal.',
                      ),
                      backgroundColor: AppColors.success,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryLine(
    String label,
    String val, {
    Color? color,
    bool isHeader = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: isHeader
                ? AppTextStyles.labelLarge.copyWith(fontWeight: FontWeight.bold)
                : AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.secondaryText,
                  ),
          ),
          Text(
            val,
            style: isHeader
                ? AppTextStyles.labelLarge.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.success,
                    fontSize: 16,
                  )
                : AppTextStyles.bodyMedium.copyWith(
                    color: color ?? AppColors.primaryText,
                    fontWeight: FontWeight.bold,
                  ),
          ),
        ],
      ),
    );
  }

  // Sub Tab 3: Bill Records Panel
  Widget _buildRecordsPanel() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CENTRAL FINANCIAL BILLING DATABASE',
            style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.secondaryText,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.separated(
              itemCount: _billRecords.length,
              separatorBuilder: (_, __) =>
                  const Divider(color: AppColors.border, height: 1),
              itemBuilder: (context, idx) {
                final r = _billRecords[idx];
                final status = r['status'] as String;
                final isPaid = status == 'Paid';

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.description_outlined,
                        color: AppColors.success,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              r['patient'] as String,
                              style: const TextStyle(
                                color: AppColors.primaryText,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              'Bill No: ${r['no']} · UHID: ${r['uhid']}',
                              style: const TextStyle(
                                color: AppColors.secondaryText,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Text(
                          r['visit'] as String,
                          style: const TextStyle(
                            color: AppColors.primaryText,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total: ₹${r['amount']}',
                              style: const TextStyle(
                                color: AppColors.primaryText,
                                fontSize: 11.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Paid: ₹${r['paid']}',
                              style: const TextStyle(
                                color: AppColors.success,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Text(
                          r['date'] as String,
                          style: const TextStyle(
                            color: AppColors.secondaryText,
                            fontSize: 11,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color:
                              (isPaid
                                      ? AppColors.success
                                      : AppColors.secondaryAccent)
                                  .withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isPaid
                                ? AppColors.success
                                : AppColors.secondaryAccent,
                            width: 0.5,
                          ),
                        ),
                        child: Text(
                          status,
                          style: TextStyle(
                            color: isPaid
                                ? AppColors.success
                                : AppColors.secondaryAccent,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Sub Tab 4: Payments Panel
  Widget _buildPaymentsPanel() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Left Column: Collect payment form
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'COLLECT PENDING PAYMENT',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: AppColors.secondaryText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text('Bill Number', style: AppTextStyles.labelSmall),
                  const SizedBox(height: 4),
                  TextField(
                    controller: _collectBillNo,
                    style: const TextStyle(
                      color: AppColors.primaryText,
                      fontSize: 13,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.background,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('Patient Name', style: AppTextStyles.labelSmall),
                  const SizedBox(height: 4),
                  TextField(
                    controller: _collectPatient,
                    style: const TextStyle(
                      color: AppColors.primaryText,
                      fontSize: 13,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.background,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Amount to Collect (₹)',
                              style: AppTextStyles.labelSmall,
                            ),
                            const SizedBox(height: 4),
                            DropdownButtonFormField<int>(
                              dropdownColor: AppColors.card,
                              initialValue: _collectAmount,
                              items: [500, 1200, 2500, 8900]
                                  .map(
                                    (a) => DropdownMenuItem(
                                      value: a,
                                      child: Text(
                                        '₹$a',
                                        style: const TextStyle(
                                          color: AppColors.primaryText,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (val) {
                                if (val != null) {
                                  setState(() => _collectAmount = val);
                                }
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppColors.background,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Payment Mode',
                              style: AppTextStyles.labelSmall,
                            ),
                            const SizedBox(height: 4),
                            DropdownButtonFormField<String>(
                              dropdownColor: AppColors.card,
                              initialValue: _collectMode,
                              items:
                                  ['Cash', 'UPI', 'Credit Card', 'Net Banking']
                                      .map(
                                        (m) => DropdownMenuItem(
                                          value: m,
                                          child: Text(
                                            m,
                                            style: const TextStyle(
                                              color: AppColors.primaryText,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                              onChanged: (val) {
                                if (val != null) {
                                  setState(() => _collectMode = val);
                                }
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppColors.background,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: AppColors.border, height: 20),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.check_circle_outline, size: 16),
                    label: const Text('Collect Payment & Reconcile'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.success,
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(42),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _collections.insert(0, {
                          'time': '01:12 PM',
                          'patient': _collectPatient.text,
                          'amount': _collectAmount,
                          'mode': _collectMode,
                          'by': 'Alok Verma (Cardiologist)',
                        });
                        // Update the balance and paid amount of that bill record
                        final billIdx = _billRecords.indexWhere(
                          (b) => b['no'] == _collectBillNo.text,
                        );
                        if (billIdx != -1) {
                          final balance =
                              _billRecords[billIdx]['balance'] as int;
                          final paid = _billRecords[billIdx]['paid'] as int;
                          _billRecords[billIdx]['balance'] =
                              (balance - _collectAmount).clamp(0, 999999);
                          _billRecords[billIdx]['paid'] = paid + _collectAmount;
                          if (_billRecords[billIdx]['balance'] == 0) {
                            _billRecords[billIdx]['status'] = 'Paid';
                          }
                        }
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Successfully collected ₹$_collectAmount for Bill ${_collectBillNo.text}.',
                          ),
                          backgroundColor: AppColors.success,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Right Column: Collection logs
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "TODAY'S CASHIER COLLECTED LOGS",
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.secondaryText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: ListView.separated(
                    itemCount: _collections.length,
                    separatorBuilder: (_, __) =>
                        const Divider(color: AppColors.border, height: 1),
                    itemBuilder: (context, idx) {
                      final c = _collections[idx];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  c['patient'] as String,
                                  style: const TextStyle(
                                    color: AppColors.primaryText,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  'Mode: ${c['mode']} · Collected by: ${c['by']}',
                                  style: const TextStyle(
                                    color: AppColors.secondaryText,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '₹${c['amount']}',
                                  style: const TextStyle(
                                    color: AppColors.success,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.5,
                                  ),
                                ),
                                Text(
                                  c['time'] as String,
                                  style: const TextStyle(
                                    color: AppColors.secondaryText,
                                    fontSize: 9,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Sub Tab 5: Insurance / TPA Panel
  Widget _buildInsurancePanel(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Left Column: Pre-Auth list
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'PRE-AUTH TPA VALIDATION LOGS',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: AppColors.secondaryText,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.add, size: 14),
                      label: const Text('Raise Pre-Auth'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                      ),
                      onPressed: () => _openNewPreAuthDialog(context),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: ListView.separated(
                    itemCount: _preAuthRequests.length,
                    separatorBuilder: (_, __) =>
                        const Divider(color: AppColors.border, height: 1),
                    itemBuilder: (context, idx) {
                      final p = _preAuthRequests[idx];
                      final status = p['status'] as String;
                      final isApproved = status == 'Approved';

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  p['patient'] as String,
                                  style: const TextStyle(
                                    color: AppColors.primaryText,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  'Procedure: ${p['procedure']} · TPA: ${p['tpa']}',
                                  style: const TextStyle(
                                    color: AppColors.secondaryText,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Est: ₹${p['amount']}',
                                  style: const TextStyle(
                                    color: AppColors.primaryText,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11.5,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        (isApproved
                                                ? AppColors.success
                                                : AppColors.secondaryAccent)
                                            .withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    status,
                                    style: TextStyle(
                                      color: isApproved
                                          ? AppColors.success
                                          : AppColors.secondaryAccent,
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Right Column: Corporate panel eligibility indicators
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'GOVERNMENT & CORPORATE PANELS CO-PAY',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.secondaryText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                _buildCorporateRow(
                  'Ayushman Bharat (PMJAY)',
                  'Full Cashless',
                  AppColors.success,
                ),
                _buildCorporateRow(
                  'CGHS Central Govt Health Scheme',
                  'Co-Pay (10%)',
                  AppColors.success,
                ),
                _buildCorporateRow(
                  'Uttarakhand State Govt Pensioners',
                  'Full Cashless',
                  AppColors.success,
                ),
                _buildCorporateRow(
                  'Star Health Insurance TPA',
                  'Pre-auth Required',
                  AppColors.secondaryAccent,
                ),
                _buildCorporateRow(
                  'MD India TPA Corporate Panel',
                  'Pre-auth Required',
                  AppColors.secondaryAccent,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCorporateRow(String org, String status, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              org,
              style: const TextStyle(
                color: AppColors.primaryText,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: color,
                fontSize: 8.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Sub Tab 6: Credit / Advances
  Widget _buildCreditPanel(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'PATIENT ADVANCE DEPOSITS REGISTER',
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.secondaryText,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.add_business_rounded, size: 14),
                label: const Text('Record Advance Deposit'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                ),
                onPressed: () => _openNewDepositDialog(context),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.separated(
              itemCount: _deposits.length,
              separatorBuilder: (_, __) =>
                  const Divider(color: AppColors.border, height: 1),
              itemBuilder: (context, idx) {
                final d = _deposits[idx];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.account_balance_rounded,
                        color: AppColors.success,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              d['patient'] as String,
                              style: const TextStyle(
                                color: AppColors.primaryText,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              'UHID: ${d['uhid']} · Date: ${d['date']}',
                              style: const TextStyle(
                                color: AppColors.secondaryText,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Total Deposited',
                              style: TextStyle(
                                color: AppColors.secondaryText,
                                fontSize: 9.5,
                              ),
                            ),
                            Text(
                              '₹${d['amount']}',
                              style: const TextStyle(
                                color: AppColors.primaryText,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Used in billing',
                              style: TextStyle(
                                color: AppColors.secondaryText,
                                fontSize: 9.5,
                              ),
                            ),
                            Text(
                              '₹${d['used']}',
                              style: const TextStyle(
                                color: AppColors.secondaryAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Available Balance',
                              style: TextStyle(
                                color: AppColors.secondaryText,
                                fontSize: 9.5,
                              ),
                            ),
                            Text(
                              '₹${d['balance']}',
                              style: const TextStyle(
                                color: AppColors.success,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Sub Tab 7: Refunds Panel
  Widget _buildRefundsPanel(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'REFUND & CANCELLED TRANSACTIONS LEDGER',
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.secondaryText,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.undo_rounded, size: 14),
                label: const Text('New Refund Request'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.error,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                ),
                onPressed: () => _openNewRefundDialog(context),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.separated(
              itemCount: _refunds.length,
              separatorBuilder: (_, __) =>
                  const Divider(color: AppColors.border, height: 1),
              itemBuilder: (context, idx) {
                final r = _refunds[idx];
                final isApproved = r['status'] == 'Approved';

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.assignment_return_outlined,
                        color: AppColors.error,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              r['patient'] as String,
                              style: const TextStyle(
                                color: AppColors.primaryText,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              'Refund No: ${r['no']} · Bill: ${r['billNo']} · Reason: ${r['reason']}',
                              style: const TextStyle(
                                color: AppColors.secondaryText,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '₹${r['amount']}',
                          style: const TextStyle(
                            color: AppColors.error,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Req by: ${r['by']}',
                          style: const TextStyle(
                            color: AppColors.primaryText,
                            fontSize: 11,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color:
                              (isApproved
                                      ? AppColors.success
                                      : AppColors.secondaryAccent)
                                  .withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isApproved
                                ? AppColors.success
                                : AppColors.secondaryAccent,
                            width: 0.5,
                          ),
                        ),
                        child: Text(
                          r['status'] as String,
                          style: TextStyle(
                            color: isApproved
                                ? AppColors.success
                                : AppColors.secondaryAccent,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Sub Tab 8: Revenue Reports
  Widget _buildRevenueReportsPanel() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'DEPARTMENTAL REVENUE DISTRIBUTION TRACKER',
            style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.secondaryText,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView(
              children: [
                _buildDeptRevenueRow(
                  'General Medicine OPD',
                  '₹1,24,000',
                  0.35,
                  AppColors.success,
                ),
                _buildDeptRevenueRow(
                  'Cardiology Diagnostics Desk',
                  '₹89,500',
                  0.25,
                  AppColors.primary,
                ),
                _buildDeptRevenueRow(
                  'Surgical IPD OT Consumables',
                  '₹55,000',
                  0.16,
                  AppColors.secondaryAccent,
                ),
                _buildDeptRevenueRow(
                  'Bio-chemical Pathology Panel LIS',
                  '₹45,000',
                  0.13,
                  AppColors.primaryLight,
                ),
                _buildDeptRevenueRow(
                  'Radiology Scan Imaging RIS',
                  '₹38,000',
                  0.11,
                  AppColors.error,
                ),
                const Divider(color: AppColors.border, height: 24),
                const Text(
                  'Uttarakhand Health Dept Compliance:',
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Daily hospital finance log sent securely to Uttrakhand Integrated Financial Management System (IFMS) under digital signatures.',
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 10.5,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeptRevenueRow(
    String dept,
    String amt,
    double ratio,
    Color barColor,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                dept,
                style: const TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '$amt (${(ratio * 100).toInt()}%)',
                style: TextStyle(
                  color: barColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          LinearProgressIndicator(
            value: ratio,
            backgroundColor: AppColors.background,
            color: barColor,
            borderRadius: BorderRadius.circular(4),
            minHeight: 6,
          ),
        ],
      ),
    );
  }

  // Pre-Auth request dialog
  void _openNewPreAuthDialog(BuildContext context) {
    final patientName = TextEditingController();
    final patientUhid = TextEditingController();
    final procedureName = TextEditingController();
    final estAmount = TextEditingController();
    var tpa = 'MD India TPA';

    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.card,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Raise Insurance Pre-Authorization',
            style: AppTextStyles.labelLarge,
          ),
          content: StatefulBuilder(
            builder: (context, setDlgState) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Patient Name', style: AppTextStyles.labelSmall),
                    const SizedBox(height: 6),
                    TextField(
                      controller: patientName,
                      style: const TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 13,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.background,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text('Patient UHID', style: AppTextStyles.labelSmall),
                    const SizedBox(height: 6),
                    TextField(
                      controller: patientUhid,
                      style: const TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 13,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.background,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Select TPA Company',
                      style: AppTextStyles.labelSmall,
                    ),
                    const SizedBox(height: 6),
                    DropdownButtonFormField<String>(
                      dropdownColor: AppColors.card,
                      initialValue: tpa,
                      items:
                          [
                                'MD India TPA',
                                'Star Health TPA',
                                'HDFC Ergo TPA',
                                'ICICI Lombard TPA',
                              ]
                              .map(
                                (t) => DropdownMenuItem(
                                  value: t,
                                  child: Text(
                                    t,
                                    style: const TextStyle(
                                      color: AppColors.primaryText,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setDlgState(() => tpa = val);
                        }
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.background,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Medical Procedure',
                      style: AppTextStyles.labelSmall,
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      controller: procedureName,
                      style: const TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 13,
                      ),
                      decoration: InputDecoration(
                        hintText: 'e.g. Angioplasty Stent...',
                        hintStyle: const TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 11.5,
                        ),
                        filled: true,
                        fillColor: AppColors.background,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Estimated Amount (₹)',
                      style: AppTextStyles.labelSmall,
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      controller: estAmount,
                      style: const TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 13,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Amount in Rupees...',
                        hintStyle: const TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 11.5,
                        ),
                        filled: true,
                        fillColor: AppColors.background,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(color: AppColors.secondaryText),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
              onPressed: () {
                final amt = int.tryParse(estAmount.text) ?? 50000;
                setState(() {
                  _preAuthRequests.insert(0, {
                    'patient': patientName.text.isEmpty
                        ? 'Amit Bisht'
                        : patientName.text,
                    'uhid': patientUhid.text.isEmpty
                        ? 'UK-00513'
                        : patientUhid.text,
                    'procedure': procedureName.text.isEmpty
                        ? 'Medical rounds'
                        : procedureName.text,
                    'amount': amt,
                    'status': 'Under Process',
                    'tpa': tpa,
                  });
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Pre-authorization insurance claim filed successfully.',
                    ),
                  ),
                );
              },
              child: const Text(
                'Submit Request',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  // Record Deposit Dialog
  void _openNewDepositDialog(BuildContext context) {
    final patientName = TextEditingController();
    final patientUhid = TextEditingController();
    final depAmount = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.card,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Record Advance Deposit',
            style: AppTextStyles.labelLarge,
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Patient Name', style: AppTextStyles.labelSmall),
                const SizedBox(height: 6),
                TextField(
                  controller: patientName,
                  style: const TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 13,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.background,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text('Patient UHID', style: AppTextStyles.labelSmall),
                const SizedBox(height: 6),
                TextField(
                  controller: patientUhid,
                  style: const TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 13,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.background,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Deposit Amount (₹)',
                  style: AppTextStyles.labelSmall,
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: depAmount,
                  style: const TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 13,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.background,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(color: AppColors.secondaryText),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.success,
              ),
              onPressed: () {
                final amt = int.tryParse(depAmount.text) ?? 10000;
                setState(() {
                  _deposits.insert(0, {
                    'patient': patientName.text.isEmpty
                        ? 'Karan Singh'
                        : patientName.text,
                    'uhid': patientUhid.text.isEmpty
                        ? 'UK-00510'
                        : patientUhid.text,
                    'date': 'Today',
                    'amount': amt,
                    'used': 0,
                    'balance': amt,
                  });
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Advance deposit credited successfully to patient's wallet.",
                    ),
                  ),
                );
              },
              child: const Text(
                'Record Deposit',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  // Record Refund Dialog
  void _openNewRefundDialog(BuildContext context) {
    final billNo = TextEditingController();
    final patientName = TextEditingController();
    final refAmount = TextEditingController();
    final refReason = TextEditingController(text: 'Service Not Rendered');

    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.card,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Request Refund Request',
            style: AppTextStyles.labelLarge,
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Bill Number', style: AppTextStyles.labelSmall),
                const SizedBox(height: 6),
                TextField(
                  controller: billNo,
                  style: const TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 13,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.background,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text('Patient Name', style: AppTextStyles.labelSmall),
                const SizedBox(height: 6),
                TextField(
                  controller: patientName,
                  style: const TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 13,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.background,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Refund Amount (₹)',
                  style: AppTextStyles.labelSmall,
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: refAmount,
                  style: const TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 13,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.background,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text('Reason', style: AppTextStyles.labelSmall),
                const SizedBox(height: 6),
                TextField(
                  controller: refReason,
                  style: const TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 13,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.background,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(color: AppColors.secondaryText),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
              onPressed: () {
                final amt = int.tryParse(refAmount.text) ?? 500;
                setState(() {
                  _refunds.insert(0, {
                    'no': 'RF-0${_refunds.length + 13}',
                    'billNo': billNo.text.isEmpty ? 'BL-008' : billNo.text,
                    'patient': patientName.text.isEmpty
                        ? 'Karan Singh'
                        : patientName.text,
                    'reason': refReason.text,
                    'amount': amt,
                    'by': 'Alok Verma (Cardiologist)',
                    'status': 'Pending',
                  });
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Refund request raised. Awaiting senior medical admin sign-off.',
                    ),
                  ),
                );
              },
              child: const Text(
                'File Refund',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
