import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class DirectoryTab extends StatefulWidget {
  const DirectoryTab({super.key});

  @override
  State<DirectoryTab> createState() => _DirectoryTabState();
}

class _DirectoryTabState extends State<DirectoryTab> {
  final List<Map<String, String>> _tpas = [
    {
      'name': 'Star Health Insurance Co.',
      'email': 'coordinator.star@healthtpa.com',
      'phone': '+91 1800 342 9001',
      'coordinator': 'Mr. Ashish Negi',
      'coordinatorPhone': '+91 98765 43210',
      'address': 'Unit 401, 4th Floor, Sector 62, Noida, UP',
    },
    {
      'name': 'Niva Bupa Health Insurance',
      'email': 'claims.support@nivabupa.com',
      'phone': '+91 1800 419 1122',
      'coordinator': 'Mrs. Sunita Rawat',
      'coordinatorPhone': '+91 87654 32109',
      'address': 'Plot No. 12, Cyber City, Phase 2, Gurugram, HR',
    },
    {
      'name': 'HDFC ERGO General Insurance',
      'email': 'tpa.desk@hdfcergo.com',
      'phone': '+91 1800 2700 700',
      'coordinator': 'Mr. Vijay Saxena',
      'coordinatorPhone': '+91 76543 21098',
      'address': '6th Floor, HDFC House, Senapati Bapat Marg, Mumbai, MH',
    },
    {
      'name': 'ICICI Lombard GIC Ltd.',
      'email': 'corporate.claims@icicilombard.com',
      'phone': '+91 1800 2666',
      'coordinator': 'Mr. Raman Malhotra',
      'coordinatorPhone': '+91 65432 10987',
      'address': 'Tower A, Interface 11, Link Road, Malad West, Mumbai, MH',
    },
  ];

  List<Map<String, String>> _filteredTpas = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredTpas = List.from(_tpas);
  }

  void _filterTpas(String query) {
    setState(() {
      _filteredTpas = _tpas.where((tpa) {
        final name = tpa['name']?.toLowerCase() ?? '';
        final email = tpa['email']?.toLowerCase() ?? '';
        final coordinator = tpa['coordinator']?.toLowerCase() ?? '';
        final q = query.toLowerCase();
        return name.contains(q) || email.contains(q) || coordinator.contains(q);
      }).toList();
    });
  }

  void _showActionToast(String action) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.primary,
        content: Text('Simulating database action: $action'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _addTpaDialog() {
    final formKey = GlobalKey<FormState>();
    var name = '';
    var email = '';
    var phone = '';
    var coordinator = '';
    var coordinatorPhone = '';
    var address = '';

    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          title: Text(
            'Register New Corporate TPA Partner',
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.primaryText,
            ),
          ),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'TPA / Insurer Company Name',
                      labelStyle: TextStyle(color: AppColors.secondaryText),
                    ),
                    style: const TextStyle(color: AppColors.primaryText),
                    validator: (val) =>
                        val == null || val.isEmpty ? 'Required' : null,
                    onSaved: (val) => name = val ?? '',
                  ),
                  const SizedBox(height: AppSpacing.md),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Primary Corporate Email',
                      labelStyle: TextStyle(color: AppColors.secondaryText),
                    ),
                    style: const TextStyle(color: AppColors.primaryText),
                    validator: (val) => val == null || !val.contains('@')
                        ? 'Enter a valid email'
                        : null,
                    onSaved: (val) => email = val ?? '',
                  ),
                  const SizedBox(height: AppSpacing.md),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Corporate Helpdesk Phone',
                      labelStyle: TextStyle(color: AppColors.secondaryText),
                    ),
                    style: const TextStyle(color: AppColors.primaryText),
                    validator: (val) =>
                        val == null || val.isEmpty ? 'Required' : null,
                    onSaved: (val) => phone = val ?? '',
                  ),
                  const SizedBox(height: AppSpacing.md),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'HIMS Coordinator Name',
                      labelStyle: TextStyle(color: AppColors.secondaryText),
                    ),
                    style: const TextStyle(color: AppColors.primaryText),
                    validator: (val) =>
                        val == null || val.isEmpty ? 'Required' : null,
                    onSaved: (val) => coordinator = val ?? '',
                  ),
                  const SizedBox(height: AppSpacing.md),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Coordinator Contact Number',
                      labelStyle: TextStyle(color: AppColors.secondaryText),
                    ),
                    style: const TextStyle(color: AppColors.primaryText),
                    validator: (val) =>
                        val == null || val.isEmpty ? 'Required' : null,
                    onSaved: (val) => coordinatorPhone = val ?? '',
                  ),
                  const SizedBox(height: AppSpacing.md),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Registered Regional Office Address',
                      labelStyle: TextStyle(color: AppColors.secondaryText),
                    ),
                    style: const TextStyle(color: AppColors.primaryText),
                    maxLines: 2,
                    validator: (val) =>
                        val == null || val.isEmpty ? 'Required' : null,
                    onSaved: (val) => address = val ?? '',
                  ),
                ],
              ),
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
                if (formKey.currentState?.validate() ?? false) {
                  formKey.currentState?.save();
                  setState(() {
                    _tpas.add({
                      'name': name,
                      'email': email,
                      'phone': phone,
                      'coordinator': coordinator,
                      'coordinatorPhone': coordinatorPhone,
                      'address': address,
                    });
                    _filterTpas(_searchController.text);
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: AppColors.success,
                      content: Text(
                        'Successfully registered $name with HIMS network!',
                      ),
                    ),
                  );
                }
              },
              child: const Text(
                'Register Partner',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Title Bar & Add Button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TPA Management',
                  style: AppTextStyles.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Manage corporate healthcare TPA networks and insurer details',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.secondaryText,
                  ),
                ),
              ],
            ),
            ElevatedButton.icon(
              onPressed: _addTpaDialog,
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Add TPA'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),

        // Datatable Container Card
        Container(
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Search & Actions Toolbar
              Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isNarrow = constraints.maxWidth < 600;
                    return Flex(
                      direction: isNarrow ? Axis.vertical : Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: isNarrow
                          ? CrossAxisAlignment.stretch
                          : CrossAxisAlignment.center,
                      children: [
                        // Search Input
                        SizedBox(
                          width: isNarrow ? double.infinity : 280,
                          height: 38,
                          child: TextField(
                            controller: _searchController,
                            onChanged: _filterTpas,
                            style: const TextStyle(
                              color: AppColors.primaryText,
                              fontSize: 13,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Search patient, MRN, bill or TPA...',
                              hintStyle: const TextStyle(
                                color: AppColors.secondaryText,
                                fontSize: 13,
                              ),
                              prefixIcon: const Icon(
                                Icons.search_rounded,
                                color: AppColors.secondaryText,
                                size: 16,
                              ),
                              fillColor: AppColors.background,
                              filled: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: const BorderSide(
                                  color: AppColors.border,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: const BorderSide(
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (isNarrow) const SizedBox(height: AppSpacing.md),
                        // Action Utility Icons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            _actionIcon(Icons.refresh_rounded, 'Refresh', () {
                              _searchController.clear();
                              _filterTpas('');
                              _showActionToast('Table Refreshed');
                            }),
                            _actionIcon(
                              Icons.copy_rounded,
                              'Copy',
                              () => _showActionToast('Copied to Clipboard'),
                            ),
                            _actionIcon(
                              Icons.insert_drive_file_outlined,
                              'CSV',
                              () => _showActionToast('Exported CSV'),
                            ),
                            _actionIcon(
                              Icons.table_view_outlined,
                              'Excel',
                              () => _showActionToast('Exported Excel'),
                            ),
                            _actionIcon(
                              Icons.picture_as_pdf_outlined,
                              'PDF',
                              () => _showActionToast('Exported PDF'),
                            ),
                            _actionIcon(
                              Icons.print_rounded,
                              'Print',
                              () => _showActionToast('Sent to Printer'),
                            ),
                            _actionIcon(
                              Icons.view_column_rounded,
                              'Columns',
                              () => _showActionToast('Column Visibility Open'),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
              const Divider(color: AppColors.border, height: 1),

              // The Datatable
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 1000),
                  child: _filteredTpas.isEmpty
                      ? Container(
                          padding: const EdgeInsets.all(40),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.business_rounded,
                                color: AppColors.border,
                                size: 48,
                              ),
                              const SizedBox(height: AppSpacing.sm),
                              Text(
                                'No matching TPA records found',
                                style: AppTextStyles.labelLarge.copyWith(
                                  color: AppColors.secondaryText,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Table(
                          columnWidths: const {
                            0: FlexColumnWidth(0.6),
                            1: FlexColumnWidth(2.2),
                            2: FlexColumnWidth(2.5),
                            3: FlexColumnWidth(1.8),
                            4: FlexColumnWidth(1.8),
                            5: FlexColumnWidth(1.8),
                            6: FlexColumnWidth(2.8),
                            7: FlexColumnWidth(1.2),
                          },
                          children: [
                            TableRow(
                              decoration: const BoxDecoration(
                                color: AppColors.background,
                              ),
                              children: [
                                _headerCell('#'),
                                _headerCell('Name'),
                                _headerCell('Email'),
                                _headerCell('Phone'),
                                _headerCell('Contact Person'),
                                _headerCell('Contact Person Phone'),
                                _headerCell('Address'),
                                _headerCell('Action'),
                              ],
                            ),
                            ...List.generate(_filteredTpas.length, (index) {
                              final item = _filteredTpas[index];
                              return _buildTableRow(index + 1, item);
                            }),
                          ],
                        ),
                ),
              ),
              const Divider(color: AppColors.border, height: 1),

              // Datatable Pagination / Entries Summary Footer
              Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Showing 1 to ${_filteredTpas.length} of ${_filteredTpas.length} entries',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.secondaryText,
                      ),
                    ),
                    Row(
                      children: [
                        _pageButton('«', isEnabled: false),
                        _pageButton('‹', isEnabled: false),
                        _pageButton('1', isSelected: true),
                        _pageButton('›', isEnabled: false),
                        _pageButton('»', isEnabled: false),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _actionIcon(IconData icon, String tooltip, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(left: 6),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.border),
      ),
      child: IconButton(
        icon: Icon(icon, color: AppColors.primaryText, size: 15),
        tooltip: tooltip,
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
        onPressed: onTap,
      ),
    );
  }

  TableRow _buildTableRow(int serial, Map<String, String> item) {
    return TableRow(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      children: [
        _cell(serial.toString(), isBold: true),
        _cell(item['name'] ?? ''),
        _cell(item['email'] ?? ''),
        _cell(item['phone'] ?? ''),
        _cell(item['coordinator'] ?? ''),
        _cell(item['coordinatorPhone'] ?? ''),
        _cell(item['address'] ?? ''),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.phone_in_talk_rounded,
                  color: AppColors.success,
                  size: 16,
                ),
                tooltip: 'Call Coordinator',
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: AppColors.primary,
                      content: Text(
                        'Calling coordinator ${item['coordinator']} at ${item['coordinatorPhone']}...',
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(width: 12),
              IconButton(
                icon: const Icon(
                  Icons.info_outline,
                  color: AppColors.primary,
                  size: 16,
                ),
                tooltip: 'More Details',
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
                onPressed: () {
                  showDialog<void>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: AppColors.surface,
                        title: Text(
                          item['name'] ?? '',
                          style: AppTextStyles.titleMedium,
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _detailField('Company Name', item['name']),
                            _detailField('Corporate Email', item['email']),
                            _detailField('Corporate Phone', item['phone']),
                            _detailField(
                              'HIMS Coordinator',
                              item['coordinator'],
                            ),
                            _detailField(
                              'Coordinator Phone',
                              item['coordinatorPhone'],
                            ),
                            _detailField('Registered Address', item['address']),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              'Close',
                              style: TextStyle(color: AppColors.primary),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _detailField(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              color: AppColors.secondaryText,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value ?? '--',
            style: const TextStyle(fontSize: 12, color: AppColors.primaryText),
          ),
        ],
      ),
    );
  }

  Widget _headerCell(String t) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      child: Text(
        t,
        style: AppTextStyles.labelSmall.copyWith(
          color: AppColors.secondaryText,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _cell(String val, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          val,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _pageButton(
    String label, {
    bool isSelected = false,
    bool isEnabled = true,
  }) {
    return Container(
      margin: const EdgeInsets.only(left: 4),
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.primary
            : (isEnabled ? AppColors.surface : Colors.transparent),
        borderRadius: BorderRadius.circular(4),
        border: isEnabled ? Border.all(color: AppColors.border) : null,
      ),
      child: InkWell(
        onTap: isEnabled ? () {} : null,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          width: 28,
          height: 28,
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isSelected
                  ? Colors.white
                  : (isEnabled
                        ? AppColors.primaryText
                        : AppColors.secondaryText),
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
