import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class WorklistTab extends StatefulWidget {
  const WorklistTab({super.key});

  @override
  State<WorklistTab> createState() => _WorklistTabState();
}

class _WorklistTabState extends State<WorklistTab> {
  final List<Map<String, dynamic>> _orders = [
    {
      'id': 'RAD-8910',
      'name': 'Rajesh Sharma',
      'mrn': 'MRN-7819',
      'ageSex': '45y / Male',
      'modality': 'CT - Brain W/O Contrast',
      'clinician': 'Dr. Alok Verma',
      'priority': 'STAT',
      'priorityColor': AppColors.error,
      'status': 'In Queue',
      'statusColor': AppColors.secondaryAccent,
    },
    {
      'id': 'RAD-8911',
      'name': 'Priya Patel',
      'mrn': 'MRN-3420',
      'ageSex': '29y / Female',
      'modality': 'MRI - Knee Joint Left',
      'clinician': 'Dr. S. K. Nayak',
      'priority': 'Urgent',
      'priorityColor': AppColors.secondaryAccent,
      'status': 'Scanning',
      'statusColor': AppColors.primary,
    },
    {
      'id': 'RAD-8912',
      'name': 'Gurpreet Singh',
      'mrn': 'MRN-9081',
      'ageSex': '62y / Male',
      'modality': 'XR - Chest AP View',
      'clinician': 'Dr. Meera Gupta',
      'priority': 'Routine',
      'priorityColor': AppColors.success,
      'status': 'Completed',
      'statusColor': AppColors.success,
    },
    {
      'id': 'RAD-8913',
      'name': 'Kavita Joshi',
      'mrn': 'MRN-5522',
      'ageSex': '38y / Female',
      'modality': 'USG - Whole Abdomen',
      'clinician': 'Dr. Alok Verma',
      'priority': 'Urgent',
      'priorityColor': AppColors.secondaryAccent,
      'status': 'In Queue',
      'statusColor': AppColors.secondaryAccent,
    },
    {
      'id': 'RAD-8914',
      'name': 'Ram Prasad',
      'mrn': 'MRN-1120',
      'ageSex': '50y / Male',
      'modality': 'MRI - Lumbar Spine',
      'clinician': 'Dr. Vineet Roy',
      'priority': 'Routine',
      'priorityColor': AppColors.success,
      'status': 'Scheduled',
      'statusColor': Colors.grey,
    },
  ];

  String _searchQuery = '';
  String _selectedModality = 'All';

  @override
  Widget build(BuildContext context) {
    final filtered = _orders.where((order) {
      final name = order['name'] as String;
      final mrn = order['mrn'] as String;
      final modality = order['modality'] as String;

      final matchesSearch =
          name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          mrn.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          modality.toLowerCase().contains(_searchQuery.toLowerCase());

      final matchesModality =
          _selectedModality == 'All' ||
          modality.split(' ').first == _selectedModality;

      return matchesSearch && matchesModality;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFiltersRow(),
        const SizedBox(height: AppSpacing.lg),
        _buildTableCard(filtered),
      ],
    );
  }

  Widget _buildFiltersRow() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: AppTextStyles.bodyMedium,
              onChanged: (val) => setState(() => _searchQuery = val),
              decoration: const InputDecoration(
                hintText: 'Search by Patient Name, MRN or Modality...',
                prefixIcon: Icon(Icons.search),
                hintStyle: TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 13,
                ),
                border: InputBorder.none,

                isDense: true,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.border),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedModality,
                dropdownColor: AppColors.card,
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.primaryText,
                ),
                items: ['All', 'CT', 'MRI', 'XR', 'USG'].map((String val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: Text(val == 'All' ? 'All Modalities' : '$val Scans'),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) {
                    setState(() => _selectedModality = val);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableCard(List<Map<String, dynamic>> items) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.list_alt_rounded,
                      color: AppColors.primary,
                      size: 30,
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Active Radiographic Worklist',
                          style: AppTextStyles.titleSmall,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '${items.length} Active Orders',
                            style: AppTextStyles.labelSmall.copyWith(
                              color: AppColors.primaryLight,
                              fontWeight: FontWeight.bold,
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
          const Divider(color: AppColors.border, height: 1),
          if (items.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 48),
              child: Center(
                child: Text(
                  'No scans matching the criteria found.',
                  style: TextStyle(color: AppColors.secondaryText),
                ),
              ),
            )
          else
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 900),
                child: Table(
                  columnWidths: const {
                    0: FlexColumnWidth(1.2),
                    1: FlexColumnWidth(1.8),
                    2: FlexColumnWidth(2),
                    3: FlexColumnWidth(1.5),
                    4: FlexColumnWidth(),
                    5: FlexColumnWidth(),
                    6: FlexColumnWidth(1.5),
                  },
                  children: [
                    TableRow(
                      decoration: const BoxDecoration(
                        color: AppColors.background,
                      ),
                      children: [
                        _headerCell('Order ID'),
                        _headerCell('Patient MRN'),
                        _headerCell('Modality Requested'),
                        _headerCell('Requesting Clinician'),
                        _headerCell('Priority'),
                        _headerCell('Scan Status'),
                        _headerCell('Quick Dispatch'),
                      ],
                    ),
                    ...items.map(_buildRow),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  TableRow _buildRow(Map<String, dynamic> item) {
    final id = item['id'] as String;
    final name = item['name'] as String;
    final mrn = item['mrn'] as String;
    final ageSex = item['ageSex'] as String;
    final modality = item['modality'] as String;
    final clinician = item['clinician'] as String;
    final priority = item['priority'] as String;
    final priorityColor = item['priorityColor'] as Color;
    final status = item['status'] as String;
    final statusColor = item['statusColor'] as Color;

    return TableRow(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      children: [
        _dataCell(id, isBold: true),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text('$mrn | $ageSex', style: AppTextStyles.bodySmall),
            ],
          ),
        ),
        _dataCell(modality),
        _dataCell(clinician),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: priorityColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: priorityColor.withValues(alpha: 0.3)),
              ),
              child: Text(
                priority,
                style: TextStyle(
                  color: priorityColor,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: statusColor.withValues(alpha: 0.3)),
              ),
              child: Text(
                status,
                style: TextStyle(
                  color: statusColor,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Row(
            children: [
              if (status == 'In Queue')
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      item['status'] = 'Scanning';
                      item['statusColor'] = AppColors.primary;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: AppColors.primary,
                        content: Text('Starting $modality for $name...'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    minimumSize: const Size(0, 30),
                  ),
                  child: const Text(
                    'Start Scan',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                )
              else if (status == 'Scanning')
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      item['status'] = 'Completed';
                      item['statusColor'] = AppColors.success;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: AppColors.success,
                        content: Text(
                          '$modality completed! Diagnostics uploaded.',
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.success,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    minimumSize: const Size(0, 30),
                  ),
                  child: const Text(
                    'Finish Scan',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                )
              else
                OutlinedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Viewing diagnostics archives for $id'),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.border),
                    foregroundColor: AppColors.primaryText,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    minimumSize: const Size(0, 30),
                  ),
                  child: const Text('Details', style: TextStyle(fontSize: 11)),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _headerCell(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      child: Text(
        text,
        style: AppTextStyles.labelSmall.copyWith(
          color: AppColors.secondaryText,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _dataCell(String text, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: TextStyle(
            color: AppColors.primaryText,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
