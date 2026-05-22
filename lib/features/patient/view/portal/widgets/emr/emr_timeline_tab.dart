import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class EMRTimelineTab extends StatefulWidget {
  const EMRTimelineTab({super.key});

  @override
  State<EMRTimelineTab> createState() => _EMRTimelineTabState();
}

class _EMRTimelineTabState extends State<EMRTimelineTab> {
  String _selectedFilter = 'all';

  final List<Map<String, dynamic>> _allEvents = [
    {
      'year': '2026',
      'date': '12 May 2026',
      'type': 'lab',
      'title': 'HbA1c & Lipid Profile — Lab Results',
      'desc':
          'HbA1c: 7.4% (slight elevation). LDL: 142 mg/dL (borderline high). Triglycerides: 168 mg/dL. Physician notified via portal. Diet modification recommended.',
      'location': 'Doon Diagnostics',
      'doctor': 'Dr. Priya Negi (Endocrinology)',
      'tags': ['Lab Report', 'Action Needed'],
      'icon': Icons.science_rounded,
      'color': const Color(0xFFFFD166),
    },
    {
      'year': '2026',
      'date': '8 May 2026',
      'type': 'tele',
      'title': 'Teleconsultation — Endocrinology Review',
      'desc':
          '30-min video call with Dr. Rajesh Kumar. Reviewed blood sugar trends. Metformin dose adjusted from 500mg BD to 850mg BD. Follow-up HbA1c in 3 months. ePrescription issued.',
      'location': 'ParaCare+ Telemedicine',
      'doctor': 'Dr. Rajesh Kumar',
      'tags': ['Teleconsult', 'ePrescription Issued'],
      'icon': Icons.video_camera_back_rounded,
      'color': const Color(0xFF3A86FF),
    },
    {
      'year': '2026',
      'date': '02 Apr 2026',
      'type': 'visit',
      'title': 'OPD Visit — Cardiology & Vaccination',
      'desc':
          'Routine cardiology review. BP: 132/84. ECG normal sinus rhythm. Echo: mild LVH noted. COVID Booster (5th dose — Covaxin) administered. Next echo in 6 months.',
      'location': 'AIIMS Rishikesh',
      'doctor': 'Dr. Anjali Sharma',
      'tags': ['OPD Visit', 'Vaccination'],
      'icon': Icons.local_hospital_rounded,
      'color': const Color(0xFF00B4D8),
    },
    {
      'year': '2026',
      'date': '18 Feb 2026',
      'type': 'rx',
      'title': 'Prescription Updated — Hypertension Protocol',
      'desc':
          'Losartan 50mg added to regimen (Amlodipine 5mg continued). BP target <130/80. DASH diet counselling given. Home BP monitoring advised twice daily.',
      'location': 'Doon Hospital',
      'doctor': 'Dr. Suresh Rawat (Medicine)',
      'tags': ['Prescription', 'OPD'],
      'icon': Icons.medication_rounded,
      'color': const Color(0xFFF77F00),
    },
    {
      'year': '2025',
      'date': '14 Nov 2025',
      'type': 'visit',
      'title': 'Emergency Visit — Hypertensive Crisis',
      'desc':
          'BP 172/104 on admission. IV Labetalol administered. Monitored for 6 hours. BP stabilised at 145/88 on discharge. Medication compliance counselled. ECG and echo ordered.',
      'location': 'Doon Hospital Emergency',
      'doctor': 'Dr. Vikas Mehta',
      'tags': ['Emergency', 'IPD Short Stay'],
      'icon': Icons.warning_rounded,
      'color': const Color(0xFFFF4D6D),
    },
    {
      'year': '2025',
      'date': '05 Mar 2025',
      'type': 'surgery',
      'title': 'Knee Arthroscopy — Right Knee',
      'desc':
          'Laparoscopic arthroscopy for meniscal tear. General anaesthesia. Duration: 55 mins. Post-op recovery uneventful. Physiotherapy started day 2. Discharged day 3. AB-PMJAY claim: ₹12,400 approved.',
      'location': 'Max Hospital Dehradun',
      'doctor': 'Dr. Anil Gupta (Orthopaedics)',
      'tags': ['Surgery', 'Discharge Summary'],
      'icon': Icons.biotech_rounded,
      'color': const Color(0xFFC77DFF),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredEvents = _allEvents.where((e) {
      if (_selectedFilter == 'all') return true;
      return e['type'] == _selectedFilter;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Filter Toolbar
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'CHRONOLOGICAL JOURNEY',
              style: AppTextStyles.labelSmall,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: AppColors.surface,
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedFilter,
                  dropdownColor: AppColors.surface,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                  icon: const Icon(
                    Icons.arrow_drop_down_rounded,
                    color: AppColors.secondaryText,
                  ),
                  onChanged: (String? val) {
                    if (val != null) {
                      setState(() {
                        _selectedFilter = val;
                      });
                    }
                  },
                  items: const [
                    DropdownMenuItem(value: 'all', child: Text('All Events')),
                    DropdownMenuItem(value: 'visit', child: Text('Visits')),
                    DropdownMenuItem(value: 'lab', child: Text('Lab Tests')),
                    DropdownMenuItem(value: 'rx', child: Text('Prescriptions')),
                    DropdownMenuItem(value: 'tele', child: Text('Teleconsult')),
                    DropdownMenuItem(
                      value: 'surgery',
                      child: Text('Surgeries'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),

        // Timeline Items
        if (filteredEvents.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Column(
                children: [
                  const Icon(
                    Icons.folder_open_rounded,
                    color: AppColors.secondaryText,
                    size: 40,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'No events found for this filter.',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: AppColors.secondaryText,
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredEvents.length,
            itemBuilder: (context, index) {
              final event = filteredEvents[index];
              final isLast = index == filteredEvents.length - 1;
              final showYearDivider =
                  index == 0 ||
                  filteredEvents[index - 1]['year'] != event['year'];
              final color = event['color'] as Color;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (showYearDivider) ...[
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 48,
                        top: 12,
                        bottom: 8,
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.calendar_today_rounded,
                            color: Color(0xFF00B4D8),
                            size: 14,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            event['year'] as String,
                            style: AppTextStyles.labelMedium.copyWith(
                              color: const Color(0xFF00B4D8),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Visual Timeline Line and Circle
                      Column(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: color.withValues(alpha: 0.15),
                              border: Border.all(color: color, width: 1.5),
                            ),
                            child: Icon(
                              event['icon'] as IconData,
                              color: color,
                              size: 14,
                            ),
                          ),
                          if (!isLast)
                            Container(
                              width: 2,
                              height: 140,
                              color: AppColors.border,
                            ),
                        ],
                      ),
                      const SizedBox(width: 14),

                      // Card Details
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.card,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                event['date'] as String,
                                style: const TextStyle(
                                  color: AppColors.secondaryText,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                event['title'] as String,
                                style: AppTextStyles.labelMedium.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                event['desc'] as String,
                                style: const TextStyle(
                                  color: AppColors.secondaryText,
                                  fontSize: 11,
                                  height: 1.4,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.place_rounded,
                                    color: AppColors.secondaryText,
                                    size: 11,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    event['location'] as String,
                                    style: const TextStyle(
                                      color: AppColors.secondaryText,
                                      fontSize: 10,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Icon(
                                    Icons.person_rounded,
                                    color: AppColors.secondaryText,
                                    size: 11,
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      event['doctor'] as String,
                                      style: const TextStyle(
                                        color: AppColors.secondaryText,
                                        fontSize: 10,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 6,
                                runSpacing: 4,
                                children: (event['tags'] as List<String>)
                                    .map(
                                      (t) => Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: color.withValues(alpha: 0.1),
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                        child: Text(
                                          t,
                                          style: TextStyle(
                                            color: color,
                                            fontSize: 8.5,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),

        // Load More Button
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: TextButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Loading older events from ABHA Health Locker...',
                    ),
                  ),
                );
              },
              icon: const Icon(
                Icons.arrow_downward_rounded,
                color: Color(0xFF00B4D8),
                size: 14,
              ),
              label: const Text(
                'Load Older Records (12 more)',
                style: TextStyle(
                  color: Color(0xFF00B4D8),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
