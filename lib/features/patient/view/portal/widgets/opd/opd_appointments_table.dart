import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';

class OpdAppointmentsTable extends StatefulWidget {
  const OpdAppointmentsTable({super.key});

  @override
  State<OpdAppointmentsTable> createState() => _OpdAppointmentsTableState();
}

class _OpdAppointmentsTableState extends State<OpdAppointmentsTable> {
  String _filter = 'all';

  final List<Map<String, dynamic>> _appointments = [
    {
      'id': 'APT-001',
      'date': '20 May 2026',
      'time': '10:30 AM',
      'doctor': 'Dr. Anjali Sharma',
      'specialty': 'Cardiology',
      'hospital': 'AIIMS Rishikesh',
      'isOpd': true,
      'status': 'Confirmed',
      'statusColor': AppColors.success,
      'actions': ['View', 'Cancel'],
    },
    {
      'id': 'APT-002',
      'date': '22 May 2026',
      'time': '4:00 PM',
      'doctor': 'Dr. Rajesh Kumar',
      'specialty': 'Endocrinology',
      'hospital': 'Teleconsult',
      'isOpd': false,
      'status': 'Teleconsult',
      'statusColor': Colors.blueAccent,
      'actions': ['Join', 'Reschedule'],
    },
    {
      'id': 'APT-003',
      'date': '28 May 2026',
      'time': '11:00 AM',
      'doctor': 'Dr. Meena Bisht',
      'specialty': 'Ophthalmology',
      'hospital': 'Doon Hospital',
      'isOpd': true,
      'status': 'Pending',
      'statusColor': AppColors.secondaryAccent,
      'actions': ['View', 'Cancel'],
    },
    {
      'id': 'APT-004',
      'date': '8 May 2026',
      'time': '3:30 PM',
      'doctor': 'Dr. Rajesh Kumar',
      'specialty': 'Endocrinology',
      'hospital': 'Teleconsult',
      'isOpd': false,
      'status': 'Completed',
      'statusColor': AppColors.secondaryText,
      'actions': ['Notes', 'Rx'],
    },
    {
      'id': 'APT-005',
      'date': '2 Apr 2026',
      'time': '10:00 AM',
      'doctor': 'Dr. Anjali Sharma',
      'specialty': 'Cardiology',
      'hospital': 'AIIMS Rishikesh',
      'isOpd': true,
      'status': 'Completed',
      'statusColor': AppColors.secondaryText,
      'actions': ['Notes', 'Feedback'],
    },
    {
      'id': 'APT-006',
      'date': '10 Mar 2026',
      'time': '9:00 AM',
      'doctor': 'Dr. Suresh Rawat',
      'specialty': 'Internal Medicine',
      'hospital': 'Doon Hospital',
      'isOpd': true,
      'status': 'Cancelled',
      'statusColor': AppColors.error,
      'actions': ['Rebook'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredAppts = _appointments.where((appt) {
      if (_filter == 'all') return true;
      final status = appt['status'].toString().toLowerCase();
      if (_filter == 'upcoming') {
        return status == 'confirmed' ||
            status == 'teleconsult' ||
            status == 'pending';
      }
      return status == _filter;
    }).toList();

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filter Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.calendar_month_rounded,
                    color: AppColors.primaryLight,
                    size: 18,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'All Appointments',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.04),
                  border: Border.all(color: AppColors.border),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _filter,
                    dropdownColor: AppColors.surface,
                    style: const TextStyle(color: Colors.white, fontSize: 11),
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: AppColors.secondaryText,
                      size: 18,
                    ),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() {
                          _filter = val;
                        });
                      }
                    },
                    items: const [
                      DropdownMenuItem(value: 'all', child: Text('All')),
                      DropdownMenuItem(
                        value: 'upcoming',
                        child: Text('Upcoming'),
                      ),
                      DropdownMenuItem(
                        value: 'completed',
                        child: Text('Completed'),
                      ),
                      DropdownMenuItem(
                        value: 'cancelled',
                        child: Text('Cancelled'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Scrollable Table Rows
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowHeight: 38,
              dataRowMinHeight: 48,
              dataRowMaxHeight: 56,
              horizontalMargin: 8,
              columnSpacing: 16,
              dividerThickness: 0.5,
              columns: const [
                DataColumn(
                  label: Text(
                    'ID',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 11,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Date & Time',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 11,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Doctor',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 11,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Specialty',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 11,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Hospital',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 11,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Type',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 11,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Status',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 11,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Actions',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
              rows: filteredAppts.map((appt) {
                final actions = appt['actions'] as List<String>;
                return DataRow(
                  cells: [
                    DataCell(
                      Text(
                        appt['id'] as String,
                        style: const TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    DataCell(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            appt['date'] as String,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            appt['time'] as String,
                            style: const TextStyle(
                              color: AppColors.secondaryText,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    DataCell(
                      Text(
                        appt['doctor'] as String,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11.5,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        appt['specialty'] as String,
                        style: const TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        appt['hospital'] as String,
                        style: const TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    DataCell(
                      Row(
                        children: [
                          Icon(
                            appt['isOpd'] as bool
                                ? Icons.apartment_rounded
                                : Icons.video_call_rounded,
                            color: appt['isOpd'] as bool
                                ? AppColors.primaryLight
                                : Colors.blueAccent,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            appt['isOpd'] as bool ? 'OPD' : 'Video',
                            style: TextStyle(
                              color: appt['isOpd'] as bool
                                  ? AppColors.primaryLight
                                  : Colors.blueAccent,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: (appt['statusColor'] as Color).withValues(
                            alpha: 0.12,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          appt['status'] as String,
                          style: TextStyle(
                            color: appt['statusColor'] as Color,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      Row(
                        children: actions.map((act) {
                          final isRed = act == 'Cancel';
                          return InkWell(
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Triggered $act action...'),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 6),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.04),
                                border: Border.all(color: AppColors.border),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                act,
                                style: TextStyle(
                                  color: isRed
                                      ? AppColors.error
                                      : AppColors.secondaryText,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
