import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/radiology_imaging/view_model/radiology_imaging_view_model.dart';

class RadiologyProtocolsTab extends ConsumerWidget {
  const RadiologyProtocolsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(radiologyImagingProvider);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border.withValues(alpha: 0.4)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.menu_book_rounded, color: AppColors.primaryLight, size: 16),
              const SizedBox(width: 8),
              const Text(
                'IMAGING PROTOCOL LIBRARY',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                  color: AppColors.secondaryText,
                  fontFamily: AppTextStyles.fontFamily,
                ),
              ),
              const Spacer(),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                onPressed: () {},
                icon: const Icon(Icons.add, size: 14, color: Colors.white),
                label: const Text('Add Protocol', style: TextStyle(fontSize: 11, color: Colors.white)),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth > 800 ? 3 : 2;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.8,
                ),
                itemCount: state.protocols.length,
                itemBuilder: (context, index) {
                  final p = state.protocols[index];
                  final colHex = int.parse('FF${p.themeHex}', radix: 16);
                  final color = Color(colHex);

                  return Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.15),
                      border: Border.all(color: AppColors.border.withValues(alpha: 0.2)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.description_rounded, size: 14, color: color),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                p.name,
                                style: const TextStyle(color: Colors.white, fontSize: 11.5, fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Expanded(
                          child: Text(
                            p.desc,
                            style: const TextStyle(color: AppColors.secondaryText, fontSize: 10),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
