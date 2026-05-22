import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/patient_portal_drawer.dart';
import 'package:paracareplus/routes/route_names.dart';

class PatientFeedbackScreen extends ConsumerStatefulWidget {
  const PatientFeedbackScreen({super.key});

  @override
  ConsumerState<PatientFeedbackScreen> createState() =>
      _PatientFeedbackScreenState();
}

class _PatientFeedbackScreenState extends ConsumerState<PatientFeedbackScreen> {
  int _rating = 5;
  String _selectedCategory = 'General Feedback';
  final TextEditingController _feedbackController = TextEditingController();

  double _cleanlinessVal = 4;
  double _staffVal = 5;
  double _billingVal = 3;

  final List<Map<String, dynamic>> _pastFeedbacks = [
    {
      'date': '2026-05-18',
      'category': 'OPD Care Quality',
      'rating': 5,
      'content': 'Excellent consultation with Dr. Rawat. Highly recommended.',
      'status': 'Acknowledged',
      'reply':
          'Thank you for your feedback! We are glad you had a smooth visit.',
    },
    {
      'date': '2026-04-10',
      'category': 'Billing Dispute',
      'rating': 3,
      'content': 'Long queues at the third-floor checkout desk.',
      'status': 'Resolved',
      'reply':
          'We have added another billing executive to the 3rd floor cashier block to reduce wait times.',
    },
  ];

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const PatientPortalDrawer(
        activeRouteName: RouteNames.patientFeedback,
      ),
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: const Text('Reviews & Care Feedback'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu_rounded, color: AppColors.primaryText),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildRatingHeader(),
            const SizedBox(height: AppSpacing.md),
            _buildMetricsSliders(),
            const SizedBox(height: AppSpacing.md),
            _buildFeedbackForm(),
            const SizedBox(height: AppSpacing.lg),
            _buildPastFeedbacksSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingHeader() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          const Text(
            'HOW WAS YOUR RECENT EXPERIENCE?',
            style: AppTextStyles.labelSmall,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              final starIndex = index + 1;
              return IconButton(
                icon: Icon(
                  starIndex <= _rating
                      ? Icons.star_rounded
                      : Icons.star_border_rounded,
                  color: starIndex <= _rating
                      ? AppColors.secondaryAccent
                      : AppColors.secondaryText,
                  size: 36,
                ),
                onPressed: () {
                  setState(() {
                    _rating = starIndex;
                  });
                },
              );
            }),
          ),
          const SizedBox(height: 8),
          Text(
            _getRatingText(_rating),
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  String _getRatingText(int rating) {
    switch (rating) {
      case 1:
        return 'Very Dissatisfied - Needs Urgent Action';
      case 2:
        return 'Dissatisfied - Found Issues';
      case 3:
        return 'Neutral - Average Experience';
      case 4:
        return 'Satisfied - Good Services';
      case 5:
        return 'Excellent - Extremely satisfied';
      default:
        return 'Rate us';
    }
  }

  Widget _buildMetricsSliders() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'DETAILED SATISFACTION SCORES',
            style: AppTextStyles.labelLarge,
          ),
          const SizedBox(height: 12),
          _buildSliderItem('Hospital Cleanliness & Hygiene', _cleanlinessVal, (
            v,
          ) {
            setState(() => _cleanlinessVal = v);
          }),
          _buildSliderItem('Staff Response & Treatment Behavior', _staffVal, (
            v,
          ) {
            setState(() => _staffVal = v);
          }),
          _buildSliderItem(
            'Billing Desk & Checkout Process Speed',
            _billingVal,
            (v) {
              setState(() => _billingVal = v);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSliderItem(
    String title,
    double val,
    ValueChanged<double> onChange,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
              Text(
                '${val.round()} / 5',
                style: const TextStyle(
                  color: AppColors.secondaryAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Slider(
            value: val,
            min: 1,
            max: 5,
            divisions: 4,
            activeColor: AppColors.primaryLight,
            inactiveColor: AppColors.border,
            onChanged: onChange,
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackForm() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'LOG INCIDENT OR WRITTEN REVIEW',
            style: AppTextStyles.labelLarge,
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: _selectedCategory,
            dropdownColor: AppColors.surface,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Feedback Category',
              labelStyle: const TextStyle(color: AppColors.secondaryText),
              filled: true,
              fillColor: AppColors.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
            ),
            items:
                [
                      'General Feedback',
                      'Staff Behavior',
                      'Billing Dispute',
                      'Facility Issues',
                      'Technical / App Bug',
                    ]
                    .map(
                      (cat) => DropdownMenuItem(value: cat, child: Text(cat)),
                    )
                    .toList(),
            onChanged: (val) {
              setState(() {
                _selectedCategory = val ?? 'General Feedback';
              });
            },
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _feedbackController,
            maxLines: 4,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText:
                  'Provide details about your review or describe an incident for quality audit inspection...',
              hintStyle: const TextStyle(
                color: AppColors.secondaryText,
                fontSize: 12,
              ),
              filled: true,
              fillColor: AppColors.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.success,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
            ),
            onPressed: () {
              if (_feedbackController.text.trim().isEmpty) return;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Feedback submitted successfully. Checked by Quality Assurance Desk.',
                  ),
                  backgroundColor: AppColors.success,
                ),
              );
              _feedbackController.clear();
            },
            child: const Text(
              'SUBMIT AUDIT REPORT',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPastFeedbacksSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'YOUR HISTORICAL FEEDBACK & RESOLUTIONS',
          style: AppTextStyles.labelSmall,
        ),
        const SizedBox(height: AppSpacing.sm),
        ..._pastFeedbacks.map((f) {
          final category = f['category'] as String;
          final status = f['status'] as String;
          final date = f['date'] as String;
          final rating = f['rating'] as int;
          final content = f['content'] as String;
          final reply = f['reply'] as String?;

          return Container(
            margin: const EdgeInsets.only(bottom: AppSpacing.md),
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      category,
                      style: AppTextStyles.labelMedium.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: status == 'Resolved'
                            ? AppColors.success.withValues(alpha: 0.15)
                            : AppColors.secondaryAccent.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: status == 'Resolved'
                              ? AppColors.success
                              : AppColors.secondaryAccent,
                        ),
                      ),
                      child: Text(
                        status.toUpperCase(),
                        style: TextStyle(
                          color: status == 'Resolved'
                              ? AppColors.success
                              : AppColors.secondaryAccent,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: const TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < rating
                          ? Icons.star_rounded
                          : Icons.star_border_rounded,
                      color: AppColors.secondaryAccent,
                      size: 14,
                    );
                  }),
                ),
                const SizedBox(height: 8),
                Text(
                  content,
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
                if (reply != null) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'QA Audit Resolution Reply:',
                          style: TextStyle(
                            color: AppColors.secondaryAccent,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          reply,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 11,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          );
        }),
      ],
    );
  }
}
