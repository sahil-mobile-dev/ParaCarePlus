import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

enum BloodSubTab {
  inventory('Inventory', Icons.inventory_2_outlined),
  donors('Donor Registry', Icons.people_outline_rounded),
  donations('Blood Donations', Icons.volunteer_activism_outlined),
  requests('Requests', Icons.pending_actions_outlined),
  crossMatch('Cross-Match', Icons.biotech_outlined),
  issue('Issue Blood', Icons.outbox_outlined),
  disposal('Expiry / Disposal', Icons.delete_sweep_outlined);

  const BloodSubTab(this.label, this.icon);
  final String label;
  final IconData icon;
}

class BloodRequestsTab extends StatefulWidget {
  const BloodRequestsTab({super.key});

  @override
  State<BloodRequestsTab> createState() => _BloodRequestsTabState();
}

class _BloodRequestsTabState extends State<BloodRequestsTab> {
  BloodSubTab _activeSubTab = BloodSubTab.inventory;

  // 1. Stock / Inventory Data
  final List<Map<String, dynamic>> _bloodStock = [
    {
      'bag': 'BB-UK-2026-0234',
      'group': 'B+',
      'comp': 'PCV/RCC',
      'vol': '280mL',
      'collected': '12/05/2026',
      'expiry': '26/05/2026',
      'days': 0,
      'status': 'Expired',
    },
    {
      'bag': 'BB-UK-2026-0235',
      'group': 'O+',
      'comp': 'Whole Blood',
      'vol': '450mL',
      'collected': '16/05/2026',
      'expiry': '30/05/2026',
      'days': 4,
      'status': 'Available',
    },
    {
      'bag': 'BB-UK-2026-0236',
      'group': 'A+',
      'comp': 'PCV/RCC',
      'vol': '280mL',
      'collected': '18/05/2026',
      'expiry': '01/06/2026',
      'days': 6,
      'status': 'Available',
    },
    {
      'bag': 'BB-UK-2026-0237',
      'group': 'AB+',
      'comp': 'FFP',
      'vol': '200mL',
      'collected': '10/05/2026',
      'expiry': '10/11/2026',
      'days': 168,
      'status': 'Available',
    },
    {
      'bag': 'BB-UK-2026-0238',
      'group': 'O-',
      'comp': 'PCV/RCC',
      'vol': '280mL',
      'collected': '22/05/2026',
      'expiry': '05/06/2026',
      'days': 10,
      'status': 'Reserved',
    },
    {
      'bag': 'BB-UK-2026-0239',
      'group': 'B+',
      'comp': 'Platelets',
      'vol': '60mL',
      'collected': '24/05/2026',
      'expiry': '29/05/2026',
      'days': 3,
      'status': 'Available',
    },
    {
      'bag': 'BB-UK-2026-0240',
      'group': 'A-',
      'comp': 'PCV/RCC',
      'vol': '280mL',
      'collected': '23/05/2026',
      'expiry': '06/06/2026',
      'days': 11,
      'status': 'Available',
    },
  ];

  // 2. Donor Registry Data
  final List<Map<String, dynamic>> _donors = [
    {
      'id': 'D-0012',
      'name': 'Suresh Negi',
      'age': 32,
      'sex': 'M',
      'group': 'O+',
      'mobile': '98765-11234',
      'lastDon': '15/02/2026',
      'total': 8,
      'eligible': 'Yes',
    },
    {
      'id': 'D-0034',
      'name': 'Priya Rawat',
      'age': 28,
      'sex': 'F',
      'group': 'A+',
      'mobile': '87654-22345',
      'lastDon': '20/03/2026',
      'total': 4,
      'eligible': 'No (90d)',
    },
    {
      'id': 'D-0056',
      'name': 'Ramesh Bisht',
      'age': 41,
      'sex': 'M',
      'group': 'B+',
      'mobile': '76543-33456',
      'lastDon': '10/04/2026',
      'total': 12,
      'eligible': 'Yes',
    },
    {
      'id': 'D-0078',
      'name': 'Anita Sharma',
      'age': 35,
      'sex': 'F',
      'group': 'AB+',
      'mobile': '65432-44567',
      'lastDon': '05/05/2026',
      'total': 3,
      'eligible': 'No (90d)',
    },
    {
      'id': 'D-0089',
      'name': 'Kishore Pant',
      'age': 25,
      'sex': 'M',
      'group': 'O-',
      'mobile': '54321-55678',
      'lastDon': '01/03/2026',
      'total': 6,
      'eligible': 'Yes',
    },
  ];

  // 3. Blood Donations Data
  final List<Map<String, dynamic>> _donations = [
    {
      'bag': 'BB-UK-2026-0234',
      'donor': 'Ramesh Bisht',
      'group': 'B+',
      'date': '05/05/2026',
      'vol': '450mL',
      'screen': 'All Clear',
      'type': 'Walk-in',
      'comp': 'PCV/RCC',
      'status': 'Expired',
    },
    {
      'bag': 'BB-UK-2026-0235',
      'donor': 'Suresh Negi',
      'group': 'O+',
      'date': '06/05/2026',
      'vol': '450mL',
      'screen': 'All Clear',
      'type': 'Camp',
      'comp': 'Whole Blood',
      'status': 'Available',
    },
    {
      'bag': 'BB-UK-2026-0236',
      'donor': 'Mohan Verma',
      'group': 'A+',
      'date': '08/05/2026',
      'vol': '450mL',
      'screen': 'All Clear',
      'type': 'Walk-in',
      'comp': 'PCV/RCC',
      'status': 'Available',
    },
    {
      'bag': 'BB-UK-2026-0237',
      'donor': 'Deepak Kumar',
      'group': 'AB+',
      'date': '10/05/2026',
      'vol': '450mL',
      'screen': 'All Clear',
      'type': 'Walk-in',
      'comp': 'FFP',
      'status': 'Available',
    },
  ];

  // 4. Requests Data
  final List<Map<String, dynamic>> _requests = [
    {
      'no': 'REQ-001',
      'patient': 'Kishore Negi',
      'ward': 'Surgery',
      'group': 'B+',
      'comp': 'PCV/RCC',
      'units': 2,
      'urgency': 'Urgent',
      'by': 'Dr. Sharma',
      'status': 'Pending',
    },
    {
      'no': 'REQ-002',
      'patient': 'Ram Chandra',
      'ward': 'ICU',
      'group': 'O+',
      'comp': 'Whole Blood',
      'units': 3,
      'urgency': 'Emergency',
      'by': 'Dr. Rawat',
      'status': 'Cross-Matching',
    },
    {
      'no': 'REQ-003',
      'patient': 'Meena Bisht',
      'ward': 'Gynae',
      'group': 'A+',
      'comp': 'FFP',
      'units': 2,
      'urgency': 'Routine',
      'by': 'Dr. Singh',
      'status': 'Issued',
    },
    {
      'no': 'REQ-004',
      'patient': 'Arjun Pant',
      'ward': 'Medicine',
      'group': 'O-',
      'comp': 'PCV/RCC',
      'units': 1,
      'urgency': 'Urgent',
      'by': 'Dr. Verma',
      'status': 'Pending',
    },
  ];

  // 5. Cross Match Data
  final List<Map<String, dynamic>> _crossMatchHistory = [
    {
      'patient': 'Kishore Negi',
      'bag': 'BB-UK-2026-0234',
      'group': 'B+',
      'result': 'Compatible',
      'date': '24/05/2026',
      'by': 'Mohan (Lab Tech)',
    },
    {
      'patient': 'Meena Bisht',
      'bag': 'BB-UK-2026-0220',
      'group': 'A+',
      'result': 'Compatible',
      'date': '22/05/2026',
      'by': 'Reena (Lab Tech)',
    },
    {
      'patient': 'Arjun Pant',
      'bag': 'BB-UK-2026-0228',
      'group': 'O-',
      'result': 'Compatible',
      'date': '21/05/2026',
      'by': 'Mohan (Lab Tech)',
    },
    {
      'patient': 'Pushpa Devi',
      'bag': 'BB-UK-2026-0215',
      'group': 'AB+',
      'result': 'Incompatible',
      'date': '19/05/2026',
      'by': 'Reena (Lab Tech)',
    },
  ];

  // 6. Issued Logs Data
  final List<Map<String, dynamic>> _issuedHistory = [
    {
      'no': 'ISS-001',
      'patient': 'Meena Bisht',
      'bag': 'BB-UK-2026-0220',
      'comp': 'FFP',
      'date': '22/05/2026',
      'status': 'Issued',
    },
    {
      'no': 'ISS-002',
      'patient': 'Arjun Pant',
      'bag': 'BB-UK-2026-0228',
      'comp': 'PCV',
      'date': '21/05/2026',
      'status': 'Issued',
    },
    {
      'no': 'ISS-003',
      'patient': 'Pushpa Devi',
      'bag': 'BB-UK-2026-0195',
      'comp': 'Platelets',
      'date': '18/05/2026',
      'status': 'Transfused',
    },
  ];

  // Forms / Dialog Controllers
  final _newRequestPatient = TextEditingController();
  final _newRequestUhid = TextEditingController();
  var _newRequestGroup = 'B+';
  var _newRequestComp = 'PCV/RCC';
  var _newRequestUnits = 2;
  var _newRequestUrgency = 'Urgent';
  var _newRequestWard = 'ICU';

  final _newDonorName = TextEditingController();
  final _newDonorAge = TextEditingController();
  final _newDonorPhone = TextEditingController();
  var _newDonorGroup = 'O+';
  var _newDonorSex = 'M';

  // Cross Match Active Simulator Fields
  final _cmPatientName = TextEditingController(text: 'Kishore Negi');
  final _cmPatientUhid = TextEditingController(text: 'UK-00512');
  var _cmPatientGroup = 'B+';
  final _cmDonorBag = TextEditingController(text: 'BB-UK-2026-0239');
  var _cmDonorGroup = 'B+';
  var _cmMajorResult = 'Compatible';
  var _cmMinorResult = 'Compatible';
  var _cmAutocontrol = 'Negative';

  // Issue Blood Fields
  final _issueReqNo = TextEditingController(text: 'REQ-001');
  final _issueUhid = TextEditingController(text: 'UK-00512');
  final _issuePatientName = TextEditingController(text: 'Kishore Negi');
  final _issueBagId = TextEditingController(text: 'BB-UK-2026-0239');
  var _issueComp = 'PCV/RCC';
  var _issueUnits = 1;
  final _issueNurse = TextEditingController();

  @override
  void dispose() {
    _newRequestPatient.dispose();
    _newRequestUhid.dispose();
    _newDonorName.dispose();
    _newDonorAge.dispose();
    _newDonorPhone.dispose();
    _cmPatientName.dispose();
    _cmPatientUhid.dispose();
    _cmDonorBag.dispose();
    _issueReqNo.dispose();
    _issueUhid.dispose();
    _issuePatientName.dispose();
    _issueBagId.dispose();
    _issueNurse.dispose();
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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PARACARE+ HMIS → BLOOD BANK',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.secondaryText,
                    letterSpacing: 0.8,
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.water_drop_rounded,
                      color: AppColors.error,
                      size: 28,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Blood Bank Management System',
                      style: AppTextStyles.titleMedium.copyWith(
                        color: AppColors.primaryText,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.volunteer_activism, size: 16),
              label: const Text('Record Donation'),
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
              onPressed: () => _openDonorRecordDialog(context),
            ),
            const SizedBox(width: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.add_circle_outline, size: 16),
              label: const Text('New Blood Request'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
              ),
              onPressed: () => _openNewRequestDialog(context),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsGrid() {
    // Inventory total counts
    final totalUnits = _bloodStock
        .where((b) => b['status'] == 'Available' || b['status'] == 'Reserved')
        .fold(0, (sum, item) {
          final volStr = item['vol'].toString().replaceAll('mL', '');
          final vol = int.tryParse(volStr) ?? 350;
          return sum + (vol > 200 ? 1 : 1);
        });

    final pendingReqs = _requests.where((r) => r['status'] == 'Pending').length;
    final urgentReqs = _requests
        .where((r) => r['urgency'] == 'Urgent' || r['urgency'] == 'Emergency')
        .length;
    final expiredUnits = _bloodStock
        .where((b) => b['status'] == 'Expired')
        .length;

    return Column(
      children: [
        Row(
          children: [
            _buildStatCard(
              'Total Stock',
              '$totalUnits Units',
              'All Blood Groups',
              AppColors.primary,
              Icons.water_drop_outlined,
            ),
            const SizedBox(width: 12),
            _buildStatCard(
              'Registered Donors',
              '${_donors.length * 250}',
              ' Uttarakhand Region',
              AppColors.success,
              Icons.people_alt_outlined,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildStatCard(
              'Pending Requests',
              '$pendingReqs Active',
              '$urgentReqs Critical',
              AppColors.secondaryAccent,
              Icons.assignment_late_outlined,
            ),
            const SizedBox(width: 12),
            _buildStatCard(
              'Expired / Disposed',
              '$expiredUnits Bags',
              'Disposal queue',
              AppColors.error,
              Icons.delete_outline_outlined,
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
          color: AppColors.surface,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(16),
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
                    fontSize: 20,
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
          children: BloodSubTab.values.map((tab) {
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
                selectedColor: AppColors.error,
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
      case BloodSubTab.inventory:
        return _buildInventoryPanel();
      case BloodSubTab.donors:
        return _buildDonorsPanel(context);
      case BloodSubTab.donations:
        return _buildDonationsPanel();
      case BloodSubTab.requests:
        return _buildRequestsPanel();
      case BloodSubTab.crossMatch:
        return _buildCrossMatchPanel();
      case BloodSubTab.issue:
        return _buildIssuePanel();
      case BloodSubTab.disposal:
        return _buildDisposalPanel();
    }
  }

  // Sub Tab 1: Inventory Panel
  Widget _buildInventoryPanel() {
    return Column(
      children: [
        Container(
          height: 560,
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
                'BLOOD UNIT STOCK REGISTER',
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.secondaryText,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.separated(
                  itemCount: _bloodStock.length,
                  separatorBuilder: (_, __) =>
                      const Divider(color: AppColors.border, height: 1),
                  itemBuilder: (context, idx) {
                    final item = _bloodStock[idx];
                    final isExpired = item['status'] == 'Expired';
                    final daysLeft = item['days'] as int;

                    var statusColor = AppColors.success;
                    if (isExpired) {
                      statusColor = AppColors.error;
                    } else if (item['status'] == 'Reserved') {
                      statusColor = AppColors.secondaryAccent;
                    }

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
                                  item['bag'] as String,
                                  style: const TextStyle(
                                    color: AppColors.primaryText,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    fontFamily: 'monospace',
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Col: ${item['collected']}',
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
                              item['group'] as String,
                              style: const TextStyle(
                                color: AppColors.error,
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['comp'] as String,
                                  style: const TextStyle(
                                    color: AppColors.primaryText,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  item['vol'] as String,
                                  style: const TextStyle(
                                    color: AppColors.secondaryText,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['expiry'] as String,
                                  style: const TextStyle(
                                    color: AppColors.primaryText,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  isExpired ? 'Expired' : '$daysLeft days left',
                                  style: TextStyle(
                                    color: isExpired
                                        ? AppColors.error
                                        : daysLeft <= 5
                                        ? AppColors.secondaryAccent
                                        : AppColors.success,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
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
        // Stock status metrics & low alerts
        Column(
          children: [
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
                    'GROUP INVENTORY METRICS',
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.secondaryText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildGroupProgressRow('O+', 78, 80, AppColors.success),
                  _buildGroupProgressRow('B+', 68, 80, AppColors.success),
                  _buildGroupProgressRow('A+', 52, 60, AppColors.success),
                  _buildGroupProgressRow('AB+', 34, 40, AppColors.success),
                  _buildGroupProgressRow(
                    'O-',
                    12,
                    20,
                    AppColors.secondaryAccent,
                  ),
                  _buildGroupProgressRow('A-', 8, 15, AppColors.error),
                  _buildGroupProgressRow('B-', 5, 12, AppColors.error),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              height: 165,
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
                    'CRITICAL STOCK ALERTS',
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.error,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildCriticalAlert(
                    'A-',
                    8,
                    'Critical Low stock. Procurement recommended.',
                  ),
                  _buildCriticalAlert(
                    'B-',
                    5,
                    'Immediate procurement needed. Camp collection request filed.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGroupProgressRow(
    String group,
    int count,
    int total,
    Color color,
  ) {
    final ratio = count / total;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 32,
            child: Text(
              group,
              style: const TextStyle(
                color: AppColors.primaryText,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            child: LinearProgressIndicator(
              value: ratio.clamp(0, 1),
              backgroundColor: AppColors.background,
              color: color,
              borderRadius: BorderRadius.circular(4),
              minHeight: 6,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '$count Units',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.primaryText,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCriticalAlert(String group, int count, String msg) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            color: AppColors.error,
            size: 18,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Group $group ($count Units left)',
                  style: const TextStyle(
                    color: AppColors.error,
                    fontWeight: FontWeight.bold,
                    fontSize: 11.5,
                  ),
                ),
                Text(
                  msg,
                  style: const TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Sub Tab 2: Donor Registry
  Widget _buildDonorsPanel(BuildContext context) {
    return Container(
      height: 490,
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
                'DONOR REGISTRY DATABASE',
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.secondaryText,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.person_add_alt_1_rounded, size: 14),
                label: const Text('Register New Donor'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                ),
                onPressed: () => _openNewDonorDialog(context),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            height: 400,
            child: ListView.separated(
              itemCount: _donors.length,
              separatorBuilder: (_, __) =>
                  const Divider(color: AppColors.border, height: 1),
              itemBuilder: (context, idx) {
                final d = _donors[idx];
                final isEligible = d['eligible'] == 'Yes';

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: AppColors.background,
                        radius: 18,
                        child: Icon(
                          Icons.person_rounded,
                          color: AppColors.secondaryText,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              d['name'] as String,
                              style: const TextStyle(
                                color: AppColors.primaryText,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              'ID: ${d['id']} · Age/Sex: ${d['age']}/${d['sex']}',
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
                          d['group'] as String,
                          style: const TextStyle(
                            color: AppColors.error,
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Mob: ${d['mobile']}',
                          style: const TextStyle(
                            color: AppColors.primaryText,
                            fontSize: 11.5,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Last: ${d['lastDon']}',
                              style: const TextStyle(
                                color: AppColors.secondaryText,
                                fontSize: 10,
                              ),
                            ),
                            Text(
                              'Total: ${d['total']} times',
                              style: const TextStyle(
                                color: AppColors.primaryText,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color:
                              (isEligible
                                      ? AppColors.success
                                      : AppColors.secondaryAccent)
                                  .withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isEligible
                                ? AppColors.success
                                : AppColors.secondaryAccent,
                            width: 0.5,
                          ),
                        ),
                        child: Text(
                          d['eligible'] as String,
                          style: TextStyle(
                            color: isEligible
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

  // Sub Tab 3: Donations Panel
  Widget _buildDonationsPanel() {
    return Container(
      height: 480,
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
            'BLOOD DONATION RECORDS',
            style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.secondaryText,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 400,
            child: ListView.separated(
              itemCount: _donations.length,
              separatorBuilder: (_, __) =>
                  const Divider(color: AppColors.border, height: 1),
              itemBuilder: (context, idx) {
                final don = _donations[idx];
                final status = don['status'] as String;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      const Icon(Icons.water, color: AppColors.error, size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              don['donor'] as String,
                              style: const TextStyle(
                                color: AppColors.primaryText,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              'Bag ID: ${don['bag']} · Date: ${don['date']}',
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
                          don['group'] as String,
                          style: const TextStyle(
                            color: AppColors.error,
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              don['comp'] as String,
                              style: const TextStyle(
                                color: AppColors.primaryText,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Volume: ${don['vol']}',
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Screening: ${don['screen']}',
                              style: const TextStyle(
                                color: AppColors.success,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Source: ${don['type']}',
                              style: const TextStyle(
                                color: AppColors.secondaryText,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color:
                              (status == 'Available'
                                      ? AppColors.success
                                      : AppColors.error)
                                  .withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: status == 'Available'
                                ? AppColors.success
                                : AppColors.error,
                            width: 0.5,
                          ),
                        ),
                        child: Text(
                          status,
                          style: TextStyle(
                            color: status == 'Available'
                                ? AppColors.success
                                : AppColors.error,
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

  // Sub Tab 4: Requests Panel
  Widget _buildRequestsPanel() {
    return Container(
      height: 500,
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
            'TRANSFUSION REQUEST DESK',
            style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.secondaryText,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 400,
            child: ListView.separated(
              itemCount: _requests.length,
              separatorBuilder: (_, __) =>
                  const Divider(color: AppColors.border, height: 1),
              itemBuilder: (context, idx) {
                final r = _requests[idx];
                final status = r['status'] as String;
                final urgency = r['urgency'] as String;

                var urgColor = AppColors.primary;
                if (urgency == 'Emergency' || urgency == 'STAT') {
                  urgColor = AppColors.error;
                } else if (urgency == 'Urgent') {
                  urgColor = AppColors.secondaryAccent;
                }

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
                              r['patient'] as String,
                              style: const TextStyle(
                                color: AppColors.primaryText,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              'Req ID: ${r['no']} · Ward: ${r['ward']}',
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
                          r['group'] as String,
                          style: const TextStyle(
                            color: AppColors.error,
                            fontWeight: FontWeight.w900,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              r['comp'] as String,
                              style: const TextStyle(
                                color: AppColors.primaryText,
                                fontSize: 11.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${r['units']} Units requested',
                              style: const TextStyle(
                                color: AppColors.secondaryText,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: urgColor.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            urgency,
                            style: TextStyle(
                              color: urgColor,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'By: ${r['by']}',
                              style: const TextStyle(
                                color: AppColors.primaryText,
                                fontSize: 11,
                              ),
                            ),
                            Text(
                              status,
                              style: const TextStyle(
                                color: AppColors.secondaryText,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.biotech,
                              color: AppColors.primaryLight,
                              size: 18,
                            ),
                            onPressed: () {
                              setState(() {
                                _cmPatientName.text = r['patient'] as String;
                                _cmPatientGroup = r['group'] as String;
                                _cmDonorGroup = r['group'] as String;
                                _activeSubTab = BloodSubTab.crossMatch;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Details loaded into Cross-Match Testing Simulator.',
                                  ),
                                ),
                              );
                            },
                            tooltip: 'Cross Match',
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.outbox,
                              color: AppColors.success,
                              size: 18,
                            ),
                            onPressed: () {
                              setState(() {
                                _issuePatientName.text = r['patient'] as String;
                                _issueReqNo.text = r['no'] as String;
                                _issueComp = r['comp'] as String;
                                _issueUnits = r['units'] as int;
                                _activeSubTab = BloodSubTab.issue;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Details loaded into Blood Issuance form.',
                                  ),
                                ),
                              );
                            },
                            tooltip: 'Issue Blood',
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
    );
  }

  // Sub Tab 5: Cross Match testing simulator
  Widget _buildCrossMatchPanel() {
    final cmPass =
        _cmMajorResult == 'Compatible' &&
        _cmMinorResult == 'Compatible' &&
        _cmAutocontrol == 'Negative';

    return Column(
      children: [
        Container(
          height: 620,
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
                  'CROSS-MATCH COMPATIBILITY TESTING',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.secondaryText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                const Text('Patient Name', style: AppTextStyles.labelSmall),
                const SizedBox(height: 4),
                TextField(
                  controller: _cmPatientName,
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
                            'Patient UHID',
                            style: AppTextStyles.labelSmall,
                          ),
                          const SizedBox(height: 4),
                          TextField(
                            controller: _cmPatientUhid,
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
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Blood Group',
                            style: AppTextStyles.labelSmall,
                          ),
                          const SizedBox(height: 4),
                          DropdownButtonFormField<String>(
                            dropdownColor: AppColors.card,
                            initialValue: _cmPatientGroup,
                            items:
                                [
                                      'A+',
                                      'A-',
                                      'B+',
                                      'B-',
                                      'O+',
                                      'O-',
                                      'AB+',
                                      'AB-',
                                    ]
                                    .map(
                                      (g) => DropdownMenuItem(
                                        value: g,
                                        child: Text(
                                          g,
                                          style: const TextStyle(
                                            color: AppColors.primaryText,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                            onChanged: (val) {
                              if (val != null) {
                                setState(() => _cmPatientGroup = val);
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
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Donor Bag ID',
                            style: AppTextStyles.labelSmall,
                          ),
                          const SizedBox(height: 4),
                          TextField(
                            controller: _cmDonorBag,
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
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Donor Group',
                            style: AppTextStyles.labelSmall,
                          ),
                          const SizedBox(height: 4),
                          DropdownButtonFormField<String>(
                            dropdownColor: AppColors.card,
                            initialValue: _cmDonorGroup,
                            items:
                                [
                                      'A+',
                                      'A-',
                                      'B+',
                                      'B-',
                                      'O+',
                                      'O-',
                                      'AB+',
                                      'AB-',
                                    ]
                                    .map(
                                      (g) => DropdownMenuItem(
                                        value: g,
                                        child: Text(
                                          g,
                                          style: const TextStyle(
                                            color: AppColors.primaryText,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                            onChanged: (val) {
                              if (val != null) {
                                setState(() => _cmDonorGroup = val);
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
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Major Cross-Match',
                            style: AppTextStyles.labelSmall,
                          ),
                          const SizedBox(height: 4),
                          DropdownButtonFormField<String>(
                            dropdownColor: AppColors.card,
                            initialValue: _cmMajorResult,
                            items:
                                [
                                      'Compatible',
                                      'Incompatible',
                                      'Weakly Reactive',
                                    ]
                                    .map(
                                      (r) => DropdownMenuItem(
                                        value: r,
                                        child: Text(
                                          r,
                                          style: const TextStyle(
                                            color: AppColors.primaryText,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                            onChanged: (val) {
                              if (val != null) {
                                setState(() => _cmMajorResult = val);
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
                            'Minor Cross-Match',
                            style: AppTextStyles.labelSmall,
                          ),
                          const SizedBox(height: 4),
                          DropdownButtonFormField<String>(
                            dropdownColor: AppColors.card,
                            initialValue: _cmMinorResult,
                            items:
                                [
                                      'Compatible',
                                      'Incompatible',
                                      'Weakly Reactive',
                                    ]
                                    .map(
                                      (r) => DropdownMenuItem(
                                        value: r,
                                        child: Text(
                                          r,
                                          style: const TextStyle(
                                            color: AppColors.primaryText,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                            onChanged: (val) {
                              if (val != null) {
                                setState(() => _cmMinorResult = val);
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
                const SizedBox(height: 8),
                const Text('Autocontrol', style: AppTextStyles.labelSmall),
                const SizedBox(height: 4),
                DropdownButtonFormField<String>(
                  dropdownColor: AppColors.card,
                  initialValue: _cmAutocontrol,
                  items: ['Negative', 'Positive']
                      .map(
                        (r) => DropdownMenuItem(
                          value: r,
                          child: Text(
                            r,
                            style: const TextStyle(
                              color: AppColors.primaryText,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (val) {
                    if (val != null) {
                      setState(() => _cmAutocontrol = val);
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
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: cmPass
                        ? AppColors.success.withValues(alpha: 0.15)
                        : AppColors.error.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: cmPass ? AppColors.success : AppColors.error,
                      width: 0.8,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        cmPass
                            ? Icons.check_circle_rounded
                            : Icons.cancel_outlined,
                        color: cmPass ? AppColors.success : AppColors.error,
                        size: 26,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        cmPass
                            ? 'COMPATIBLE – SAFE TO ISSUE'
                            : 'INCOMPATIBLE – DO NOT ISSUE',
                        style: TextStyle(
                          color: cmPass ? AppColors.success : AppColors.error,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  icon: const Icon(Icons.save_rounded, size: 16),
                  label: const Text('Save Crossmatch Result'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: cmPass
                        ? AppColors.success
                        : AppColors.error,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _crossMatchHistory.insert(0, {
                        'patient': _cmPatientName.text,
                        'bag': _cmDonorBag.text,
                        'group': _cmPatientGroup,
                        'result': cmPass ? 'Compatible' : 'Incompatible',
                        'date': 'Today',
                        'by': 'Alok Verma (Cardiologist)',
                      });
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Cross-match record saved and locked into PACS/LIS databases.',
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Container(
          height: 260,
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
                'COMPATIBILITY TESTING HISTORY',
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.secondaryText,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.separated(
                  itemCount: _crossMatchHistory.length,
                  separatorBuilder: (_, __) =>
                      const Divider(color: AppColors.border, height: 1),
                  itemBuilder: (context, idx) {
                    final c = _crossMatchHistory[idx];
                    final isComp = c['result'] == 'Compatible';

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
                                'Bag: ${c['bag']} · Group: ${c['group']}',
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
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      (isComp
                                              ? AppColors.success
                                              : AppColors.error)
                                          .withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  c['result'] as String,
                                  style: TextStyle(
                                    color: isComp
                                        ? AppColors.success
                                        : AppColors.error,
                                    fontSize: 8.5,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'By: ${c['by']} · ${c['date']}',
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
      ],
    );
  }

  // Sub Tab 6: Issue Blood
  Widget _buildIssuePanel() {
    return Column(
      children: [
        // Left Column: Issue form
        Container(
          height: 450,
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
                  'DISPATCH / ISSUE BLOOD UNIT',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.secondaryText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Request Ref No',
                            style: AppTextStyles.labelSmall,
                          ),
                          const SizedBox(height: 4),
                          TextField(
                            controller: _issueReqNo,
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
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Patient UHID',
                            style: AppTextStyles.labelSmall,
                          ),
                          const SizedBox(height: 4),
                          TextField(
                            controller: _issueUhid,
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
                  ],
                ),
                const SizedBox(height: 8),
                const Text('Patient Name', style: AppTextStyles.labelSmall),
                const SizedBox(height: 4),
                TextField(
                  controller: _issuePatientName,
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
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Bag ID(s) to Dispatch',
                            style: AppTextStyles.labelSmall,
                          ),
                          const SizedBox(height: 4),
                          TextField(
                            controller: _issueBagId,
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
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Units', style: AppTextStyles.labelSmall),
                          const SizedBox(height: 4),
                          DropdownButtonFormField<int>(
                            dropdownColor: AppColors.card,
                            initialValue: _issueUnits,
                            items: [1, 2, 3, 4]
                                .map(
                                  (u) => DropdownMenuItem(
                                    value: u,
                                    child: Text(
                                      '$u Units',
                                      style: const TextStyle(
                                        color: AppColors.primaryText,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (val) {
                              if (val != null) {
                                setState(() => _issueUnits = val);
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
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Component',
                            style: AppTextStyles.labelSmall,
                          ),
                          const SizedBox(height: 4),
                          DropdownButtonFormField<String>(
                            dropdownColor: AppColors.card,
                            initialValue: _issueComp,
                            items:
                                ['Whole Blood', 'PCV/RCC', 'Platelets', 'FFP']
                                    .map(
                                      (c) => DropdownMenuItem(
                                        value: c,
                                        child: Text(
                                          c,
                                          style: const TextStyle(
                                            color: AppColors.primaryText,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                            onChanged: (val) {
                              if (val != null) {
                                setState(() => _issueComp = val);
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
                            'Receiver Ward Nurse',
                            style: AppTextStyles.labelSmall,
                          ),
                          const SizedBox(height: 4),
                          TextField(
                            controller: _issueNurse,
                            style: const TextStyle(
                              color: AppColors.primaryText,
                              fontSize: 13,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Nurse name...',
                              hintStyle: const TextStyle(
                                color: AppColors.secondaryText,
                                fontSize: 11,
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
                    ),
                  ],
                ),
                const Divider(color: AppColors.border, height: 20),
                ElevatedButton.icon(
                  icon: const Icon(Icons.local_shipping_outlined, size: 16),
                  label: const Text('Confirm Dispatch & Print Issue Slip'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.error,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(42),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _issuedHistory.insert(0, {
                        'no': 'ISS-00${_issuedHistory.length + 1}',
                        'patient': _issuePatientName.text,
                        'bag': _issueBagId.text,
                        'comp': _issueComp,
                        'date': 'Today',
                        'status': 'Issued',
                      });
                      // Mark stock bag as Issued (remove/update status)
                      final stockIdx = _bloodStock.indexWhere(
                        (s) => s['bag'] == _issueBagId.text,
                      );
                      if (stockIdx != -1) {
                        _bloodStock.removeAt(stockIdx);
                      }
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Blood unit ${_issueBagId.text} issued to ${_issuePatientName.text}. Inventory stock updated.',
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
        const SizedBox(height: 12),
        // Right Column: Issued logs
        Container(
          height: 205,
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
                'DISPATCH / ISSUANCE REGISTER LOGS',
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.secondaryText,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                height: 150,
                child: ListView.separated(
                  itemCount: _issuedHistory.length,
                  separatorBuilder: (_, __) =>
                      const Divider(color: AppColors.border, height: 1),
                  itemBuilder: (context, idx) {
                    final i = _issuedHistory[idx];
                    final status = i['status'] as String;
                    final isTransfused = status == 'Transfused';

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                i['patient'] as String,
                                style: const TextStyle(
                                  color: AppColors.primaryText,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                'Slip: ${i['no']} · Bag: ${i['bag']} · Comp: ${i['comp']}',
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
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      (isTransfused
                                              ? AppColors.success
                                              : AppColors.primary)
                                          .withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  status,
                                  style: TextStyle(
                                    color: isTransfused
                                        ? AppColors.success
                                        : AppColors.primary,
                                    fontSize: 8.5,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                i['date'] as String,
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
      ],
    );
  }

  // Sub Tab 7: Expiry Disposal
  Widget _buildDisposalPanel() {
    final expiredBags = _bloodStock
        .where((b) => b['status'] == 'Expired')
        .toList();

    return Container(
      height: 140,
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
            'EXPIRY ALERT TRACKING & PATHOLOGICAL DISPOSAL',
            style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.secondaryText,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 75,
            child: expiredBags.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.health_and_safety_outlined,
                          color: AppColors.success,
                          size: 42,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'No Expired Blood Bags',
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Good job! All blood bags are within their pathological lifecycle.',
                          style: TextStyle(
                            color: AppColors.secondaryText,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    itemCount: expiredBags.length,
                    separatorBuilder: (_, __) =>
                        const Divider(color: AppColors.border, height: 1),
                    itemBuilder: (context, idx) {
                      final bag = expiredBags[idx];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.delete_forever_rounded,
                              color: AppColors.error,
                              size: 22,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    bag['bag'] as String,
                                    style: const TextStyle(
                                      color: AppColors.primaryText,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      fontFamily: 'monospace',
                                    ),
                                  ),
                                  Text(
                                    'Component: ${bag['comp']} · Group: ${bag['group']}',
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Expired On: ${bag['expiry']}',
                                    style: const TextStyle(
                                      color: AppColors.error,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text(
                                    'Days Left: 0 days (OVERDUE)',
                                    style: TextStyle(
                                      color: AppColors.error,
                                      fontSize: 9.5,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ElevatedButton.icon(
                              icon: const Icon(Icons.delete_outline, size: 14),
                              label: const Text('Dispose Bag'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.error,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                textStyle: const TextStyle(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  _bloodStock.remove(bag);
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Blood Bag ${bag['bag']} safely disposed under Bio-Medical Waste rules.',
                                    ),
                                    backgroundColor: AppColors.error,
                                  ),
                                );
                              },
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

  // Record Donation modal/dialog
  void _openDonorRecordDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.card,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Row(
            children: [
              Icon(
                Icons.volunteer_activism_rounded,
                color: AppColors.primaryLight,
                size: 22,
              ),
              SizedBox(width: 8),
              Text(
                'Record Blood Donation Bag',
                style: AppTextStyles.labelLarge,
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Select Registered Donor',
                  style: AppTextStyles.labelSmall,
                ),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  dropdownColor: AppColors.card,
                  initialValue: _donors[0]['name'] as String,
                  items: _donors
                      .map(
                        (d) => DropdownMenuItem(
                          value: d['name'] as String,
                          child: Text(
                            d['name'] as String,
                            style: const TextStyle(
                              color: AppColors.primaryText,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (val) {},
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.background,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Volume Collected',
                            style: AppTextStyles.labelSmall,
                          ),
                          const SizedBox(height: 6),
                          DropdownButtonFormField<String>(
                            dropdownColor: AppColors.card,
                            initialValue: '450mL',
                            items: ['350mL', '450mL']
                                .map(
                                  (v) => DropdownMenuItem(
                                    value: v,
                                    child: Text(
                                      v,
                                      style: const TextStyle(
                                        color: AppColors.primaryText,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (val) {},
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
                            'Component Spec',
                            style: AppTextStyles.labelSmall,
                          ),
                          const SizedBox(height: 6),
                          DropdownButtonFormField<String>(
                            dropdownColor: AppColors.card,
                            initialValue: 'PCV/RCC',
                            items:
                                ['Whole Blood', 'PCV/RCC', 'Platelets', 'FFP']
                                    .map(
                                      (c) => DropdownMenuItem(
                                        value: c,
                                        child: Text(
                                          c,
                                          style: const TextStyle(
                                            color: AppColors.primaryText,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                            onChanged: (val) {},
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
                const SizedBox(height: 12),
                const Text(
                  'Pathological Screenings Done',
                  style: AppTextStyles.labelSmall,
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: const Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            color: AppColors.success,
                            size: 14,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'HIV I & II (Non-Reactive)',
                            style: TextStyle(
                              color: AppColors.primaryText,
                              fontSize: 11.5,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            color: AppColors.success,
                            size: 14,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'HBsAg Hepatitis B (Non-Reactive)',
                            style: TextStyle(
                              color: AppColors.primaryText,
                              fontSize: 11.5,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            color: AppColors.success,
                            size: 14,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Syphilis / VDRL (Negative)',
                            style: TextStyle(
                              color: AppColors.primaryText,
                              fontSize: 11.5,
                            ),
                          ),
                        ],
                      ),
                    ],
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
                backgroundColor: AppColors.primary,
              ),
              onPressed: () {
                setState(() {
                  _donations.insert(0, {
                    'bag': 'BB-UK-2026-0304',
                    'donor': 'Ramesh Bisht',
                    'group': 'B+',
                    'date': '26/05/2026',
                    'vol': '450mL',
                    'screen': 'All Clear',
                    'type': 'Walk-in',
                    'comp': 'Whole Blood',
                    'status': 'Available',
                  });
                  _bloodStock.insert(0, {
                    'bag': 'BB-UK-2026-0304',
                    'group': 'B+',
                    'comp': 'Whole Blood',
                    'vol': '450mL',
                    'collected': '26/05/2026',
                    'expiry': '09/07/2026',
                    'days': 45,
                    'status': 'Available',
                  });
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Blood donation bag recorded and added to LIS stock register.',
                    ),
                  ),
                );
              },
              child: const Text(
                'Save Donation',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  // Raise Request dialog
  void _openNewRequestDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.card,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Row(
            children: [
              Icon(Icons.add_alert_rounded, color: AppColors.error, size: 22),
              SizedBox(width: 8),
              Text(
                'Order Transfusion Request',
                style: AppTextStyles.labelLarge,
              ),
            ],
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
                      controller: _newRequestPatient,
                      style: const TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 13,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Enter patient full name...',
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
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'UHID No',
                                style: AppTextStyles.labelSmall,
                              ),
                              const SizedBox(height: 4),
                              TextField(
                                controller: _newRequestUhid,
                                style: const TextStyle(
                                  color: AppColors.primaryText,
                                  fontSize: 13,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'UK-00...',
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
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Ward',
                                style: AppTextStyles.labelSmall,
                              ),
                              const SizedBox(height: 4),
                              DropdownButtonFormField<String>(
                                dropdownColor: AppColors.card,
                                initialValue: _newRequestWard,
                                items:
                                    [
                                          'Medicine',
                                          'Surgery',
                                          'Ortho',
                                          'Gynae',
                                          'ICU',
                                          'OT',
                                        ]
                                        .map(
                                          (w) => DropdownMenuItem(
                                            value: w,
                                            child: Text(
                                              w,
                                              style: const TextStyle(
                                                color: AppColors.primaryText,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                onChanged: (val) {
                                  if (val != null) {
                                    setDlgState(() {
                                      _newRequestWard = val;
                                    });
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
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Blood Group',
                                style: AppTextStyles.labelSmall,
                              ),
                              const SizedBox(height: 6),
                              DropdownButtonFormField<String>(
                                dropdownColor: AppColors.card,
                                initialValue: _newRequestGroup,
                                items:
                                    [
                                          'A+',
                                          'A-',
                                          'B+',
                                          'B-',
                                          'O+',
                                          'O-',
                                          'AB+',
                                          'AB-',
                                        ]
                                        .map(
                                          (g) => DropdownMenuItem(
                                            value: g,
                                            child: Text(
                                              g,
                                              style: const TextStyle(
                                                color: AppColors.primaryText,
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                onChanged: (val) {
                                  if (val != null) {
                                    setDlgState(() {
                                      _newRequestGroup = val;
                                    });
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
                                'Units',
                                style: AppTextStyles.labelSmall,
                              ),
                              const SizedBox(height: 6),
                              DropdownButtonFormField<int>(
                                dropdownColor: AppColors.card,
                                initialValue: _newRequestUnits,
                                items: [1, 2, 3, 4]
                                    .map(
                                      (u) => DropdownMenuItem(
                                        value: u,
                                        child: Text(
                                          '$u Units',
                                          style: const TextStyle(
                                            color: AppColors.primaryText,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (val) {
                                  if (val != null) {
                                    setDlgState(() => _newRequestUnits = val);
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
                    const SizedBox(height: 12),
                    const Text(
                      'Component Spec',
                      style: AppTextStyles.labelSmall,
                    ),
                    const SizedBox(height: 6),
                    DropdownButtonFormField<String>(
                      dropdownColor: AppColors.card,
                      initialValue: _newRequestComp,
                      items: ['Whole Blood', 'PCV/RCC', 'Platelets', 'FFP']
                          .map(
                            (c) => DropdownMenuItem(
                              value: c,
                              child: Text(
                                c,
                                style: const TextStyle(
                                  color: AppColors.primaryText,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setDlgState(() => _newRequestComp = val);
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
                    const SizedBox(height: 12),
                    const Text('Urgency', style: AppTextStyles.labelSmall),
                    const SizedBox(height: 6),
                    DropdownButtonFormField<String>(
                      dropdownColor: AppColors.card,
                      initialValue: _newRequestUrgency,
                      items: ['Routine', 'Urgent', 'Emergency']
                          .map(
                            (u) => DropdownMenuItem(
                              value: u,
                              child: Text(
                                u,
                                style: const TextStyle(
                                  color: AppColors.primaryText,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setDlgState(() => _newRequestUrgency = val);
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
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
              onPressed: () {
                setState(() {
                  _requests.insert(0, {
                    'no': 'REQ-00${_requests.length + 1}',
                    'patient': _newRequestPatient.text.isEmpty
                        ? 'Karan Singh'
                        : _newRequestPatient.text,
                    'ward': _newRequestWard,
                    'group': _newRequestGroup,
                    'comp': _newRequestComp,
                    'units': _newRequestUnits,
                    'urgency': _newRequestUrgency,
                    'by': 'Alok Verma (Cardiologist)',
                    'status': 'Pending',
                  });
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Transfusion order REQ-00${_requests.length} registered successfully under priority $_newRequestUrgency.',
                    ),
                    backgroundColor: AppColors.success,
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

  // Register Donor dialog
  void _openNewDonorDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.card,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Row(
            children: [
              Icon(
                Icons.person_add_rounded,
                color: AppColors.primaryLight,
                size: 22,
              ),
              SizedBox(width: 8),
              Text('Register New Donor', style: AppTextStyles.labelLarge),
            ],
          ),
          content: StatefulBuilder(
            builder: (context, setDlgState) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Full Name', style: AppTextStyles.labelSmall),
                    const SizedBox(height: 6),
                    TextField(
                      controller: _newDonorName,
                      style: const TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 13,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Donor full name...',
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
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Age',
                                style: AppTextStyles.labelSmall,
                              ),
                              const SizedBox(height: 4),
                              TextField(
                                controller: _newDonorAge,
                                style: const TextStyle(
                                  color: AppColors.primaryText,
                                  fontSize: 13,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'e.g. 28',
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
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Sex',
                                style: AppTextStyles.labelSmall,
                              ),
                              const SizedBox(height: 4),
                              DropdownButtonFormField<String>(
                                dropdownColor: AppColors.card,
                                initialValue: _newDonorSex,
                                items: ['M', 'F', 'O']
                                    .map(
                                      (s) => DropdownMenuItem(
                                        value: s,
                                        child: Text(
                                          s,
                                          style: const TextStyle(
                                            color: AppColors.primaryText,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (val) {
                                  if (val != null) {
                                    setDlgState(() => _newDonorSex = val);
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
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Blood Group',
                                style: AppTextStyles.labelSmall,
                              ),
                              const SizedBox(height: 6),
                              DropdownButtonFormField<String>(
                                dropdownColor: AppColors.card,
                                initialValue: _newDonorGroup,
                                items:
                                    [
                                          'A+',
                                          'A-',
                                          'B+',
                                          'B-',
                                          'O+',
                                          'O-',
                                          'AB+',
                                          'AB-',
                                        ]
                                        .map(
                                          (g) => DropdownMenuItem(
                                            value: g,
                                            child: Text(
                                              g,
                                              style: const TextStyle(
                                                color: AppColors.primaryText,
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                onChanged: (val) {
                                  if (val != null) {
                                    setDlgState(() => _newDonorGroup = val);
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
                                'Mobile No',
                                style: AppTextStyles.labelSmall,
                              ),
                              const SizedBox(height: 6),
                              TextField(
                                controller: _newDonorPhone,
                                style: const TextStyle(
                                  color: AppColors.primaryText,
                                  fontSize: 13,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'e.g. 98765-XXXXX',
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
                        ),
                      ],
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
                setState(() {
                  _donors.insert(0, {
                    'id': 'D-00${_donors.length + 12}',
                    'name': _newDonorName.text.isEmpty
                        ? 'Karan Joshi'
                        : _newDonorName.text,
                    'age': int.tryParse(_newDonorAge.text) ?? 30,
                    'sex': _newDonorSex,
                    'group': _newDonorGroup,
                    'mobile': _newDonorPhone.text.isEmpty
                        ? '99887-76655'
                        : _newDonorPhone.text,
                    'lastDon': 'Never',
                    'total': 0,
                    'eligible': 'Yes',
                  });
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Donor registered successfully in Uttrakhand central database.',
                    ),
                  ),
                );
              },
              child: const Text(
                'Register Donor',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
