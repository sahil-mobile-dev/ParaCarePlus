import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class LeaveTab extends StatefulWidget {
  const LeaveTab({super.key});

  @override
  State<LeaveTab> createState() => _LeaveTabState();
}

class _LeaveTabState extends State<LeaveTab> {
  final List<Map<String, dynamic>> _leaveRequests = [
    {
      'id': 'REQ-2098',
      'name': 'Shashi Kiran',
      'role': 'Senior Staff Nurse',
      'type': 'Casual Leave',
      'dates': 'May 24 - May 26',
      'days': 3,
      'reason': 'Family emergency in hometown',
    },
    {
      'id': 'REQ-2099',
      'name': 'Sanjay Sen',
      'role': 'Billing Executive',
      'type': 'Sick Leave',
      'dates': 'May 22 - May 23',
      'days': 2,
      'reason': 'Dental surgery recovery',
    },
  ];

  void _handleLeaveAction(int index, bool approved) {
    final reqName = _leaveRequests[index]['name'];
    final reqType = _leaveRequests[index]['type'];

    setState(() {
      _leaveRequests.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: approved ? AppColors.success : AppColors.error,
        content: Text(
          approved
              ? 'Leave request for $reqName ($reqType) has been APPROVED!'
              : 'Leave request for $reqName ($reqType) has been REJECTED.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildBalancesGrid(),
        const SizedBox(height: AppSpacing.lg),
        _buildRequestsListCard(),
      ],
    );
  }

  Widget _buildBalancesGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _balanceTile(
                'Sick Leave Balance',
                '12 days left',
                'Accrued Monthly',
                AppColors.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _balanceTile(
                'Casual Leave Balance',
                '08 days left',
                'Resets annually',
                AppColors.success,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _balanceTile(
          'Earned / Annual Leave',
          '22 days left',
          'Carry-forward active',
          AppColors.secondaryAccent,
        ),
      ],
    );
  }

  Widget _balanceTile(String label, String value, String sub, Color color) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.secondaryText,
                ),
              ),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppTextStyles.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(sub, style: AppTextStyles.bodySmall.copyWith(fontSize: 10)),
        ],
      ),
    );
  }

  Widget _buildRequestsListCard() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.beach_access_rounded,
                color: AppColors.primary,
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                'Pending Staff Leave Requests',
                style: AppTextStyles.titleSmall,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          const Divider(color: AppColors.border, height: 1),
          const SizedBox(height: 12),
          if (_leaveRequests.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 36),
              child: Center(
                child: Text(
                  'No pending leave requests found.',
                  style: TextStyle(color: AppColors.secondaryText),
                ),
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _leaveRequests.length,
              itemBuilder: (context, index) {
                final req = _leaveRequests[index];
                final name = req['name'] as String;
                final role = req['role'] as String;
                final type = req['type'] as String;
                final dates = req['dates'] as String;
                final days = req['days'].toString();
                final reason = req['reason'] as String;
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.border,
                        radius: 20,
                        child: Text(
                          name.split(' ').last.substring(0, 1),
                          style: const TextStyle(
                            color: AppColors.primaryText,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Text(
                                '$name ($role)',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.secondaryAccent.withValues(
                                      alpha: 0.1,
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    type,
                                    style: const TextStyle(
                                      color: AppColors.secondaryAccent,
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Dates : $dates \n($days Days)',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.primaryText,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Reason: "$reason"',
                              style: AppTextStyles.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () => _handleLeaveAction(index, true),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.success,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              minimumSize: const Size(0, 32),
                            ),
                            child: const Text(
                              'APPROVE',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          OutlinedButton(
                            onPressed: () => _handleLeaveAction(index, false),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: AppColors.error),
                              foregroundColor: AppColors.error,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              minimumSize: const Size(0, 32),
                            ),
                            child: const Text(
                              'REJECT',
                              style: TextStyle(
                                fontSize: 10,
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
        ],
      ),
    );
  }
}
