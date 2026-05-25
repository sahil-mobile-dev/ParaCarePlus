import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';

class ActiveInsuranceGrid extends StatelessWidget {
  const ActiveInsuranceGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 950
            ? 3
            : (constraints.maxWidth > 650 ? 2 : 1);

        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: AppSpacing.md,
          mainAxisSpacing: AppSpacing.md,
          childAspectRatio: constraints.maxWidth > 950 ? 0.98 : 1.15,
          children: [
            // Ayushman Bharat
            _buildInsuranceCard(
              logo: '🏛️',
              name: 'AB-PMJAY (Ayushman Bharat)',
              policyNo: 'Policy: UK-PMJAY-2024-784921 · Valid till Mar 2027',
              limitLeftLabel: '₹1,20,000 used',
              limitRightLabel: '₹5,00,000 total',
              pctUsed: 0.24,
              subText: '₹3,80,000 remaining (76%)',
              progressColors: [const Color(0xFF3A86FF), const Color(0xFF00B4D8)],
              details: [
                _DetailItem('Family Members', '5 members'),
                _DetailItem('Cashless Hospitals', '1,800+ in Uttarakhand'),
                _DetailItem('Renewal', 'Mar 2027', color: AppColors.success),
                _DetailItem('Claims', '3 this year'),
              ],
              cardGradient: const LinearGradient(
                colors: [Color(0xFF0A2240), Color(0xFF0D3360)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderColor: const Color(0xFF3A86FF).withValues(alpha: 0.3),
            ),

            // CGHS
            _buildInsuranceCard(
              logo: '💊',
              name: 'CGHS — Central Govt Health Scheme',
              policyNo: 'CGHS ID: UK-DEH-2218-A · Valid till Mar 2027',
              limitLeftLabel: 'OPD coverage active',
              limitRightLabel: 'Unlimited OPD',
              pctUsed: 0.6,
              subText: 'OPD + Medicines covered · IPD up to ₹2L',
              progressColors: [const Color(0xFF00C897), const Color(0xFF0D9488)],
              details: [
                _DetailItem('Category', 'Category II'),
                _DetailItem('CGHS Wellness Centre', 'Dehradun'),
                _DetailItem('Premium', '₹650/month', color: AppColors.success),
                _DetailItem('Referral Required', 'For specialists'),
              ],
              cardGradient: const LinearGradient(
                colors: [Color(0xFF0A2A1A), Color(0xFF0D3D22)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderColor: const Color(0xFF00C897).withValues(alpha: 0.3),
            ),

            // Star Health Private
            _buildInsuranceCard(
              logo: '🏦',
              name: 'Star Health — Top-up Policy',
              policyNo: 'Policy: SH-2023-UKX-88812 · Valid till Dec 2026',
              limitLeftLabel: 'No claims used',
              limitRightLabel: '₹3,00,000 deductible top-up',
              pctUsed: 0.0,
              subText: 'Activates after ₹3L base coverage exhausted',
              progressColors: [const Color(0xFFFFD166), const Color(0xFFF77F00)],
              details: [
                _DetailItem('Sum Insured', '₹10,00,000'),
                _DetailItem('Premium', '₹8,400/year'),
                _DetailItem('Renewal', 'Dec 2026', color: const Color(0xFFFFD166)),
                _DetailItem('Network Hospitals', '9,800+'),
              ],
              cardGradient: const LinearGradient(
                colors: [Color(0xFF1A1A0A), Color(0xFF2A2A10)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderColor: const Color(0xFFFFD166).withValues(alpha: 0.3),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInsuranceCard({
    required String logo,
    required String name,
    required String policyNo,
    required String limitLeftLabel,
    required String limitRightLabel,
    required double pctUsed,
    required String subText,
    required List<Color> progressColors,
    required List<_DetailItem> details,
    required Gradient cardGradient,
    required Color borderColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: cardGradient,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo & Name
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(logo, style: const TextStyle(fontSize: 18)),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                policyNo,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: AppColors.secondaryText, fontSize: 10.5),
              ),
            ],
          ),

          // Progress tracker
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    limitLeftLabel,
                    style: const TextStyle(color: Colors.white70, fontSize: 10),
                  ),
                  Text(
                    limitRightLabel,
                    style: const TextStyle(color: Colors.white70, fontSize: 10),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: pctUsed > 0 ? pctUsed : 0.02,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: progressColors),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subText,
                style: const TextStyle(color: AppColors.secondaryText, fontSize: 10),
              ),
            ],
          ),

          // Detail cards grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 2.8,
            children: details.map((d) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      d.label,
                      style: const TextStyle(
                        color: Colors.white38,
                        fontSize: 8.5,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 1),
                    Text(
                      d.val,
                      style: TextStyle(
                        color: d.color ?? Colors.white,
                        fontSize: 10.5,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _DetailItem {
  final String label;
  final String val;
  final Color? color;

  _DetailItem(this.label, this.val, {this.color});
}
