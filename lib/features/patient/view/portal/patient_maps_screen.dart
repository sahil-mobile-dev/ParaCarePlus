import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/maps/maps_indoor_panel.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/maps/maps_main_workspace.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/maps/maps_mini_panels.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/maps/maps_stats_bar.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/maps/maps_type_selector.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/patient_portal_drawer.dart';
import 'package:paracareplus/routes/route_names.dart';

class PatientMapsScreen extends ConsumerStatefulWidget {
  const PatientMapsScreen({super.key});

  @override
  ConsumerState<PatientMapsScreen> createState() => _PatientMapsScreenState();
}

class _PatientMapsScreenState extends ConsumerState<PatientMapsScreen> {
  String _selectedMapType = 'hospitals';

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: AppColors.surface,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const PatientPortalDrawer(
        activeRouteName: RouteNames.patientMaps,
      ),
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu_rounded, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Row(
          children: [
            const Icon(
              Icons.map_rounded,
              color: AppColors.primaryLight,
              size: 18,
            ),
            const SizedBox(width: 8),
            const Text(
              'Smart Maps & GIS Features',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.primaryLight.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.primaryLight.withValues(alpha: 0.3),
                ),
              ),
              child: const Text(
                '📍 Rishikesh, Uttarakhand',
                style: TextStyle(
                  color: AppColors.primaryLight,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        actions: [
          _AppBarBtn(
            label: 'My Location',
            icon: Icons.my_location_rounded,
            onTap: () => _showSnack('Located: Ramesh Kumar · Rishikesh'),
          ),
          const SizedBox(width: 8),
          _AppBarBtn(
            label: 'Export Map',
            icon: Icons.download_rounded,
            onTap: () => _showSnack('Map exported as PNG'),
          ),
          const SizedBox(width: 8),
          _AppBarBtn(
            label: 'Live Track',
            icon: Icons.satellite_alt_rounded,
            onTap: () => _showSnack('Live tracking activated'),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Map type selector
              MapsTypeSelector(
                selectedType: _selectedMapType,
                onTypeSelect: (t) => setState(() => _selectedMapType = t),
              ),
              const SizedBox(height: AppSpacing.md),

              // Stats bar
              const MapsStatsBar(),
              const SizedBox(height: AppSpacing.md),

              // Main workspace
              SizedBox(
                height: 1350,
                child: MapsMainWorkspace(mapType: _selectedMapType),
              ),
              const SizedBox(height: AppSpacing.md),

              // Mini map panels
              const MapsMiniPanels(),
              const SizedBox(height: AppSpacing.md),

              // Indoor navigator
              const MapsIndoorPanel(),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppBarBtn extends StatelessWidget {
  const _AppBarBtn({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: AppColors.secondaryText),
            const SizedBox(width: 5),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.secondaryText,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
