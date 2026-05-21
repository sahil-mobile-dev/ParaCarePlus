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
  final List<Map<String, String>> _staff = [
    {
      'id': 'EMP-1042',
      'name': 'Dr. Alok Verma',
      'designation': 'HOD Cardiology',
      'department': 'Cardiology',
      'email': 'alok.verma@paracare.com',
      'phone': '+91 98765 43210',
      'status': 'Active',
    },
    {
      'id': 'EMP-2210',
      'name': 'Shashi Kiran',
      'designation': 'Senior Staff Nurse',
      'department': 'Emergency Medicine',
      'email': 'shashi.k@paracare.com',
      'phone': '+91 88765 99011',
      'status': 'On Leave',
    },
    {
      'id': 'EMP-1102',
      'name': 'Dr. Meera Gupta',
      'designation': 'Senior Radiologist',
      'department': 'Radiology / RIS',
      'email': 'meera.g@paracare.com',
      'phone': '+91 99881 22340',
      'status': 'Active',
    },
    {
      'id': 'EMP-3049',
      'name': 'Aman Rawat',
      'designation': 'HR Operations Lead',
      'department': 'Human Resources',
      'email': 'aman.r@paracare.com',
      'phone': '+91 77665 44210',
      'status': 'Active',
    },
    {
      'id': 'EMP-4421',
      'name': 'Sanjay Sen',
      'designation': 'Billing Executive',
      'department': 'Billing & Finance',
      'email': 'sanjay.sen@paracare.com',
      'phone': '+91 91223 88401',
      'status': 'Active',
    },
  ];

  String _searchQuery = '';
  String _selectedDept = 'All';

  @override
  Widget build(BuildContext context) {
    final filtered = _staff.where((person) {
      final matchesSearch =
          person['name']!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          person['designation']!.toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          person['id']!.toLowerCase().contains(_searchQuery.toLowerCase());

      final matchesDept =
          _selectedDept == 'All' || person['department'] == _selectedDept;

      return matchesSearch && matchesDept;
    }).toList();

    return Column(
      children: [
        _buildFiltersRow(),
        const SizedBox(height: AppSpacing.lg),
        _buildDirectoryGrid(filtered),
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
                hintText: 'Search by employee name, role or ID...',
                hintStyle: TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 13,
                ),
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: AppColors.secondaryText,
                  size: 18,
                ),
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
                value: _selectedDept,
                dropdownColor: AppColors.card,
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.primaryText,
                ),
                items:
                    [
                      'All',
                      'Cardiology',
                      'Emergency Medicine',
                      'Radiology / RIS',
                      'Human Resources',
                    ].map((String val) {
                      return DropdownMenuItem<String>(
                        value: val,
                        child: Text(val == 'All' ? 'All Departments' : val),
                      );
                    }).toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _selectedDept = val);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDirectoryGrid(List<Map<String, String>> items) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cols = constraints.maxWidth > 900
            ? 3
            : (constraints.maxWidth > 600 ? 2 : 1);
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cols,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 2.5,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final person = items[index];
            final isOnLeave = person['status'] == 'On Leave';
            return Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.primary.withValues(
                          alpha: 0.1,
                        ),
                        radius: 20,
                        child: Text(
                          person['name']!.split(' ').last.substring(0, 1),
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  person['id']!,
                                  style: AppTextStyles.labelSmall.copyWith(
                                    fontSize: 8,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        (isOnLeave
                                                ? AppColors.error
                                                : AppColors.success)
                                            .withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    person['status']!,
                                    style: TextStyle(
                                      color: isOnLeave
                                          ? AppColors.error
                                          : AppColors.success,
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              person['name']!,
                              style: AppTextStyles.bodyMedium.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              person['designation']!,
                              style: AppTextStyles.bodySmall.copyWith(
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: AppColors.border, height: 1),
                  Column(
                    children: [
                      _contactRow(Icons.mail_outline_rounded, person['email']!),
                      _contactRow(Icons.phone_iphone_rounded, person['phone']!),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _contactRow(IconData icon, String val) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(icon, color: AppColors.secondaryText, size: 12),
          const SizedBox(width: 8),
          Text(
            val,
            style: AppTextStyles.bodySmall.copyWith(
              fontSize: 10,
              color: AppColors.primaryText,
            ),
          ),
        ],
      ),
    );
  }
}
