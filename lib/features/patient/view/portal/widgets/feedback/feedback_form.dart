import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';

class FeedbackForm extends StatefulWidget {
  const FeedbackForm({super.key});

  @override
  State<FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  String _visitType = 'OPD Consultation';
  String _department = 'General Medicine';
  final TextEditingController _doctorCtrl = TextEditingController(
    text: 'Dr. Rajesh Sharma',
  );
  final TextEditingController _commentCtrl = TextEditingController(
    text:
        'Dr. Rajesh was very thorough and explained my BP management plan clearly. The wait was about 45 minutes which was a bit long, but the consultation itself was excellent. The HIMS portal has made it very easy to access my reports and prescriptions online.',
  );

  final Map<String, int> _dimRatings = {
    'Doctor Communication': 5,
    'Wait Time': 4,
    'Facility & Cleanliness': 4,
    'HIMS Portal / App': 5,
    'Pharmacy Service': 5,
    'Lab & Diagnostics': 4,
  };

  final Set<String> _positives = {
    '✅ Caring doctor',
    '✅ Clear explanation',
    '✅ Clean facility',
    '✅ Helpful staff',
  };
  final Set<String> _improvements = {'⚠️ Waiting time'};
  int _nps = 8;

  @override
  void dispose() {
    _doctorCtrl.dispose();
    _commentCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ─── Feedback Form ───
        _PanelBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.edit_rounded,
                    color: AppColors.primaryLight,
                    size: 16,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Submit New Feedback',
                    style: TextStyle(
                      color: AppColors.primaryText,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                'Your feedback helps us improve care quality at AIIMS Rishikesh. Ramesh Kumar · ABHA: 43-8912-3456-7890',
                style: TextStyle(color: AppColors.secondaryText, fontSize: 11),
              ),
              const SizedBox(height: 16),

              // Visit type + Department
              Row(
                children: [
                  Expanded(
                    child: _FormField(
                      label: 'Visit Type',
                      child: _StyledDropdown(
                        value: _visitType,
                        items: const [
                          'OPD Consultation',
                          'IPD Admission',
                          'Emergency Visit',
                          'Telemedicine',
                          'Lab / Radiology',
                          'Pharmacy',
                        ],
                        onChanged: (v) =>
                            setState(() => _visitType = v ?? _visitType),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _FormField(
                      label: 'Department',
                      child: _StyledDropdown(
                        value: _department,
                        items: const [
                          'General Medicine',
                          'Orthopaedics',
                          'Cardiology',
                          'Endocrinology',
                          'Emergency',
                          'Radiology',
                        ],
                        onChanged: (v) =>
                            setState(() => _department = v ?? _department),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Doctor + Date
              Row(
                children: [
                  Expanded(
                    child: _FormField(
                      label: 'Doctor / Staff',
                      child: _StyledInput(controller: _doctorCtrl),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: _FormField(label: 'Visit Date', child: _DateField()),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Star ratings per dimension
              _FormField(
                label: 'Rate Each Dimension',
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    children: _dimRatings.entries.map((e) {
                      final icons = [
                        Icons.person_rounded,
                        Icons.access_time_rounded,
                        Icons.local_hospital_outlined,
                        Icons.smartphone_rounded,
                        Icons.medication_outlined,
                        Icons.science_outlined,
                      ];
                      final colors = [
                        AppColors.primaryLight,
                        AppColors.secondaryAccent,
                        AppColors.success,
                        const Color(0xFFC77DFF),
                        const Color(0xFFF77F00),
                        const Color(0xFF0D9488),
                      ];
                      final idx = _dimRatings.keys.toList().indexOf(e.key);
                      return Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: idx == _dimRatings.length - 1
                                  ? Colors.transparent
                                  : AppColors.border.withValues(alpha: 0.5),
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              icons[idx % icons.length],
                              color: colors[idx % colors.length],
                              size: 14,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                e.key,
                                style: const TextStyle(
                                  color: AppColors.primaryText,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            _StarMini(
                              rating: e.value,
                              onRate: (r) =>
                                  setState(() => _dimRatings[e.key] = r),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Positives chips
              _FormField(
                label: 'What went well? (Select all that apply)',
                child: Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children:
                      [
                        '✅ Caring doctor',
                        '✅ Clear explanation',
                        'Short wait time',
                        '✅ Clean facility',
                        'Easy appointment',
                        '✅ Helpful staff',
                        'Good digital system',
                        'Affordable care',
                      ].map((t) {
                        final sel = _positives.contains(t);
                        return GestureDetector(
                          onTap: () => setState(() {
                            sel ? _positives.remove(t) : _positives.add(t);
                          }),
                          child: _Chip(label: t, selected: sel),
                        );
                      }).toList(),
                ),
              ),
              const SizedBox(height: 12),

              // Improvements chips
              _FormField(
                label: 'What could be improved?',
                child: Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children:
                      [
                        '⚠️ Waiting time',
                        'Parking facilities',
                        'Billing process',
                        'Lab report delays',
                        'Follow-up reminder',
                      ].map((t) {
                        final sel = _improvements.contains(t);
                        return GestureDetector(
                          onTap: () => setState(() {
                            sel
                                ? _improvements.remove(t)
                                : _improvements.add(t);
                          }),
                          child: _Chip(label: t, selected: sel),
                        );
                      }).toList(),
                ),
              ),
              const SizedBox(height: 12),

              // Comments
              _FormField(
                label: 'Your Comments',
                child: TextField(
                  controller: _commentCtrl,
                  minLines: 3,
                  maxLines: 5,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: AppColors.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: AppColors.border),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: AppColors.border),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: AppColors.primaryLight),
                    ),
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // NPS row
              _FormField(
                label:
                    'How likely are you to recommend AIIMS Rishikesh to family/friends? (NPS)',
                child: Column(
                  children: [
                    Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: List.generate(11, (i) {
                        Color btnColor;
                        if (i <= 6) {
                          btnColor = AppColors.error;
                        } else if (i <= 8) {
                          btnColor = AppColors.secondaryAccent;
                        } else {
                          btnColor = AppColors.success;
                        }
                        final isSel = _nps == i;
                        return GestureDetector(
                          onTap: () => setState(() => _nps = i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: isSel
                                  ? btnColor.withValues(alpha: 0.2)
                                  : AppColors.surface,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isSel ? btnColor : AppColors.border,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '$i',
                                style: TextStyle(
                                  color: isSel
                                      ? btnColor
                                      : AppColors.secondaryText,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 4),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Not likely',
                          style: TextStyle(
                            color: AppColors.secondaryText,
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          'Extremely likely',
                          style: TextStyle(
                            color: AppColors.secondaryText,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Submit button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style:
                      ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                      ).copyWith(
                        backgroundColor: WidgetStateProperty.all(
                          Colors.transparent,
                        ),
                        overlayColor: WidgetStateProperty.all(
                          Colors.white.withValues(alpha: 0.1),
                        ),
                      ),
                  onPressed: () {
                    if (_commentCtrl.text.trim().isEmpty) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                          'Feedback submitted! Ref: FB-2026-0519',
                        ),
                        backgroundColor: AppColors.success,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.send_rounded,
                    color: Colors.white,
                    size: 16,
                  ),
                  label: const Text(
                    'Submit Feedback',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ).withGradient(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ─── Past Feedbacks ───
        _PanelBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.history_rounded,
                    color: AppColors.primaryLight,
                    size: 14,
                  ),
                  SizedBox(width: 6),
                  Text(
                    'My Previous Feedbacks',
                    style: TextStyle(
                      color: AppColors.primaryText,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ...[
                (
                  'Dr. Meena Verma — Orthopaedics',
                  'OPD Visit · 28 Apr 2026',
                  5,
                  '"Very detailed examination of my knee X-rays. Dr. Meena explained all treatment options including physiotherapy vs surgery. Felt very reassured."',
                  ['Caring', 'Detailed', 'Reassuring'],
                ),
                (
                  'Dr. Priya Nair — Cardiology',
                  'OPD Visit · 15 Mar 2026',
                  4,
                  '"Good consultation, ECG was done quickly. Waiting time was about 1 hour due to emergency cases. Staff was helpful and explained insurance claim process."',
                  ['Professional', 'Wait time issue'],
                ),
                (
                  'AIIMS Lab — CBC & Biochemistry',
                  'Lab Visit · 10 May 2026',
                  4,
                  '"Reports were available online within 4 hours — excellent turnaround. Sample collection was quick and painless."',
                  ['Fast reports', 'HIMS integration'],
                ),
              ].map(
                (fb) => Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                fb.$1,
                                style: const TextStyle(
                                  color: AppColors.primaryText,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                fb.$2,
                                style: const TextStyle(
                                  color: AppColors.secondaryText,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: List.generate(
                              5,
                              (i) => Icon(
                                i < fb.$3
                                    ? Icons.star_rounded
                                    : Icons.star_border_rounded,
                                color: AppColors.secondaryAccent,
                                size: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        fb.$4,
                        style: const TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 11,
                          fontStyle: FontStyle.italic,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 5,
                        children: fb.$5
                            .map(
                              (t) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryLight.withValues(
                                    alpha: 0.1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: AppColors.primaryLight.withValues(
                                      alpha: 0.2,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  t,
                                  style: const TextStyle(
                                    color: AppColors.primaryLight,
                                    fontSize: 10,
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
        ),
      ],
    );
  }
}

// ─────────────────────── Helper Widgets ───────────────────────

class _PanelBox extends StatelessWidget {
  const _PanelBox({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: child,
    );
  }
}

class _FormField extends StatelessWidget {
  const _FormField({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.primaryText,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        child,
      ],
    );
  }
}

class _StyledDropdown extends StatelessWidget {
  const _StyledDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String value;
  final List<String> items;
  final void Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          dropdownColor: AppColors.surface,
          style: const TextStyle(color: Colors.white, fontSize: 12),
          isExpanded: true,
          icon: const Icon(
            Icons.expand_more_rounded,
            color: AppColors.secondaryText,
            size: 18,
          ),
          items: items
              .map((i) => DropdownMenuItem(value: i, child: Text(i)))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class _StyledInput extends StatelessWidget {
  const _StyledInput({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white, fontSize: 12),
      decoration: const InputDecoration(
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: AppColors.primaryLight),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      ),
    );
  }
}

class _DateField extends StatelessWidget {
  const _DateField();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.calendar_today_rounded,
            color: AppColors.secondaryText,
            size: 14,
          ),
          SizedBox(width: 8),
          Text(
            '2026-05-14',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _StarMini extends StatelessWidget {
  const _StarMini({required this.rating, required this.onRate});

  final int rating;
  final void Function(int) onRate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (i) {
        return GestureDetector(
          onTap: () => onRate(i + 1),
          child: Icon(
            i < rating ? Icons.star_rounded : Icons.star_border_rounded,
            color: AppColors.secondaryAccent,
            size: 16,
          ),
        );
      }),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label, required this.selected});

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: selected
            ? AppColors.primaryLight.withValues(alpha: 0.15)
            : AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: selected ? AppColors.primaryLight : AppColors.border,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: selected ? AppColors.primaryLight : AppColors.secondaryText,
          fontSize: 11,
        ),
      ),
    );
  }
}

// Extension for gradient button
extension on ElevatedButton {
  Widget withGradient() {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primaryLight, Color(0xFF4361EE)],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: this,
    );
  }
}
