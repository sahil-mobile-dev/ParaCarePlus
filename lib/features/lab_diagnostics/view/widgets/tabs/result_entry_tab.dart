import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/lab_diagnostics/model/lab_diagnostics_model.dart';
import 'package:paracareplus/features/lab_diagnostics/view_model/lab_diagnostics_view_model.dart';
import 'package:paracareplus/features/lab_diagnostics/view/widgets/lab_modals.dart';

class ResultEntryTab extends ConsumerStatefulWidget {
  const ResultEntryTab({super.key});

  @override
  ConsumerState<ResultEntryTab> createState() => _ResultEntryTabState();
}

class _ResultEntryTabState extends ConsumerState<ResultEntryTab> {
  final _searchController = TextEditingController();
  LabSampleItem? _loadedSample;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadSample() {
    final query = _searchController.text.trim().toLowerCase();
    if (query.isEmpty) return;

    final state = ref.read(labDiagnosticsProvider);
    try {
      final found = state.samples.firstWhere(
        (s) => s.id.toLowerCase() == query || s.mrn.toLowerCase() == query,
      );
      setState(() => _loadedSample = found);
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No matching sample found. Try "LAB-2024-001847" or "MRN-10021".'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Load Bar
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _searchController,
                style: AppTextStyles.bodyMedium,
                decoration: InputDecoration(
                  hintText: 'Enter Sample ID or Patient MRN to load parameters...',
                  prefixIcon: const Icon(Icons.qr_code_rounded, color: AppColors.secondaryText),
                  filled: true,
                  fillColor: AppColors.card,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                onSubmitted: (_) => _loadSample(),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              ),
              onPressed: _loadSample,
              child: const Text('LOAD SAMPLE', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        if (_loadedSample == null)
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
            ),
            child: const Row(
              children: [
                Icon(Icons.info_outline, color: AppColors.primaryLight),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Enter a valid Sample ID above and click Load Sample to view test parameters for diagnostic result entry.',
                    style: TextStyle(color: AppColors.primaryLight),
                  ),
                ),
              ],
            ),
          )
        else ...[
          // Render inline patient info
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_loadedSample!.patientName, style: AppTextStyles.labelLarge.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(
                      '${_loadedSample!.mrn} | Tests: ${_loadedSample!.tests} | Collected: ${_loadedSample!.collected}',
                      style: AppTextStyles.bodySmall.copyWith(color: AppColors.secondaryText),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.success),
                  icon: const Icon(Icons.edit_note_rounded, color: Colors.white),
                  label: const Text('LAUNCH RESULT ENTRY PANEL', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    LabModals.showResultEntry(context, ref, _loadedSample!);
                    setState(() => _loadedSample = null); // Reset
                  },
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
