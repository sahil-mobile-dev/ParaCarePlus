import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/patient_portal_drawer.dart';
import 'package:paracareplus/routes/route_names.dart';

class PatientMapsScreen extends ConsumerStatefulWidget {
  const PatientMapsScreen({super.key});

  @override
  ConsumerState<PatientMapsScreen> createState() => _PatientMapsScreenState();
}

class _PatientMapsScreenState extends ConsumerState<PatientMapsScreen> {
  String _selectedCategory = 'All';
  String _searchQuery = '';
  int _selectedFacilityIndex = 0;

  final List<Map<String, dynamic>> _facilities = [
    {
      'name': 'ParaCare Central Hospital',
      'type': 'Hospital',
      'distance': '0.8 km',
      'address': 'Rajpur Road, Dehradun, Uttarakhand',
      'phone': '+91 98765 43210',
      'lat': 50.0,
      'lng': 80.0,
      'status': 'Open 24/7',
      'specialty': 'Multispecialty & Emergency',
    },
    {
      'name': 'ParaCare Pathology Lab',
      'type': 'Lab',
      'distance': '1.5 km',
      'address': 'EC Road, Dehradun, Uttarakhand',
      'phone': '+91 98765 43211',
      'lat': 120.0,
      'lng': 160.0,
      'status': 'Closes at 8 PM',
      'specialty': 'Advanced Diagnostic & Radiology',
    },
    {
      'name': 'ParaCare Pharmacy & Wellness',
      'type': 'Pharmacy',
      'distance': '0.4 km',
      'address': 'Clock Tower Square, Dehradun, Uttarakhand',
      'phone': '+91 98765 43212',
      'lat': 180.0,
      'lng': 70.0,
      'status': 'Open 24/7',
      'specialty': '24Hr Medicines & Critical Care Items',
    },
    {
      'name': 'Doon Specialty Clinic',
      'type': 'Clinic',
      'distance': '2.9 km',
      'address': 'Vasant Vihar, Dehradun, Uttarakhand',
      'phone': '+91 98765 43213',
      'lat': 220.0,
      'lng': 140.0,
      'status': 'Closes at 6 PM',
      'specialty': 'Cardiology & Endocrinology Care',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredFacilities = _facilities.where((f) {
      final matchesCategory =
          _selectedCategory == 'All' || f['type'] == _selectedCategory;
      final matchesSearch =
          f['name'].toString().toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          f['specialty'].toString().toLowerCase().contains(
            _searchQuery.toLowerCase(),
          );
      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const PatientPortalDrawer(
        activeRouteName: RouteNames.patientMaps,
      ),
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: const Text('Smart Locator & Maps'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu_rounded, color: AppColors.primaryText),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSearchAndFilters(),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // List side
                Expanded(
                  flex: 5,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    physics: const BouncingScrollPhysics(),
                    itemCount: filteredFacilities.length,
                    itemBuilder: (context, index) {
                      final item = filteredFacilities[index];
                      final type = item['type'] as String;
                      final name = item['name'] as String;
                      final specialty = item['specialty'] as String;
                      final distance = item['distance'] as String;
                      final address = item['address'] as String;
                      final status = item['status'] as String;
                      final isSelected = _selectedFacilityIndex == index;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedFacilityIndex = index;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: AppSpacing.md),
                          padding: const EdgeInsets.all(AppSpacing.md),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.surface
                                : AppColors.card,
                            borderRadius: BorderRadius.circular(AppRadius.md),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primaryLight
                                  : AppColors.border,
                              width: isSelected ? 1.5 : 1.0,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getTypeColor(
                                        type,
                                      ).withValues(alpha: 0.15),
                                      borderRadius: BorderRadius.circular(
                                        AppRadius.xs,
                                      ),
                                      border: Border.all(
                                        color: _getTypeColor(type),
                                      ),
                                    ),
                                    child: Text(
                                      type.toUpperCase(),
                                      style: TextStyle(
                                        color: _getTypeColor(type),
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    distance,
                                    style: const TextStyle(
                                      color: AppColors.secondaryText,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                specialty,
                                style: const TextStyle(
                                  color: AppColors.secondaryText,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    size: 14,
                                    color: AppColors.secondaryText,
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      address,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: AppColors.secondaryText,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    status,
                                    style: const TextStyle(
                                      color: AppColors.success,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons.phone,
                                          size: 16,
                                          color: AppColors.primaryLight,
                                        ),
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                        onPressed: () {},
                                      ),
                                      const SizedBox(width: 12),
                                      const Icon(
                                        Icons.directions,
                                        size: 16,
                                        color: AppColors.secondaryAccent,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Map side
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: AppSpacing.md,
                      right: AppSpacing.md,
                      bottom: AppSpacing.md,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(AppRadius.md),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Stack(
                        children: [
                          CustomPaint(
                            size: Size.infinite,
                            painter: _ClinicMapPainter(
                              facilities: filteredFacilities,
                              selectedIdx: _selectedFacilityIndex,
                            ),
                          ),
                          Positioned(
                            bottom: 12,
                            left: 12,
                            right: 12,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.background.withValues(
                                  alpha: 0.85,
                                ),
                                borderRadius: BorderRadius.circular(
                                  AppRadius.sm,
                                ),
                                border: Border.all(color: AppColors.border),
                              ),
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.info_outline_rounded,
                                    size: 14,
                                    color: AppColors.secondaryAccent,
                                  ),
                                  SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      'ABDM Linked Live GPS Tracking Map (Uttarakhand State Division)',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      color: AppColors.surface,
      child: Column(
        children: [
          TextField(
            onChanged: (val) {
              setState(() {
                _searchQuery = val;
              });
            },
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Search diagnostics, pharmacies, clinics...',
              hintStyle: const TextStyle(color: AppColors.secondaryText),
              prefixIcon: const Icon(
                Icons.search,
                color: AppColors.secondaryText,
              ),
              filled: true,
              fillColor: AppColors.card,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.sm),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.sm),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.sm),
                borderSide: const BorderSide(color: AppColors.primaryLight),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: ['All', 'Hospital', 'Clinic', 'Lab', 'Pharmacy'].map((
              cat,
            ) {
              final isSelected = _selectedCategory == cat;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Text(cat),
                  selected: isSelected,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.black : Colors.white70,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                    fontSize: 12,
                  ),
                  backgroundColor: AppColors.card,
                  selectedColor: AppColors.secondaryAccent,
                  checkmarkColor: Colors.black,
                  onSelected: (val) {
                    setState(() {
                      _selectedCategory = cat;
                      _selectedFacilityIndex = 0;
                    });
                  },
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'Hospital':
        return AppColors.error;
      case 'Lab':
        return AppColors.primaryLight;
      case 'Pharmacy':
        return AppColors.success;
      case 'Clinic':
        return AppColors.secondaryAccent;
      default:
        return Colors.blue;
    }
  }
}

class _ClinicMapPainter extends CustomPainter {
  _ClinicMapPainter({required this.facilities, required this.selectedIdx});
  final List<Map<String, dynamic>> facilities;
  final int selectedIdx;

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = AppColors.border.withValues(alpha: 0.4)
      ..strokeWidth = 0.5;

    // Draw coordinate grids
    for (double i = 0; i < size.width; i += 30) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), gridPaint);
    }
    for (double i = 0; i < size.height; i += 30) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), gridPaint);
    }

    // Draw user location center (Dehradun central tag)
    final userPaint = Paint()
      ..color = AppColors.primaryLight
      ..style = PaintingStyle.fill;

    final pulsePaint = Paint()
      ..color = AppColors.primaryLight.withValues(alpha: 0.2)
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    canvas
      ..drawCircle(center, 24, pulsePaint)
      ..drawCircle(center, 8, userPaint);

    // Draw facilities points
    for (var i = 0; i < facilities.length; i++) {
      final f = facilities[i];
      final isSel = i == selectedIdx;

      final lat = f['lat'] as double;
      final lng = f['lng'] as double;
      final type = f['type'] as String;
      final name = f['name'] as String;

      final point = Offset(lng, lat);

      final pinPaint = Paint()
        ..color = _getTypeColor(type)
        ..style = PaintingStyle.fill;

      if (isSel) {
        canvas.drawCircle(
          point,
          14,
          Paint()..color = _getTypeColor(type).withValues(alpha: 0.3),
        );
      }
      canvas
        ..drawCircle(point, 8, pinPaint)
        ..drawCircle(point, 4, Paint()..color = Colors.white);

      // Simple text tags
      const textStyle = TextStyle(
        color: Colors.white,
        fontSize: 8,
        fontWeight: FontWeight.bold,
      );
      final textPainter = TextPainter(
        text: TextSpan(text: name, style: textStyle),
        textDirection: TextDirection.ltr,
      );
      textPainter
        ..layout(maxWidth: 100)
        ..paint(canvas, Offset(lng - textPainter.width / 2, lat + 12));
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'Hospital':
        return AppColors.error;
      case 'Lab':
        return AppColors.primaryLight;
      case 'Pharmacy':
        return AppColors.success;
      case 'Clinic':
        return AppColors.secondaryAccent;
      default:
        return Colors.blue;
    }
  }

  @override
  bool shouldRepaint(covariant _ClinicMapPainter oldDelegate) =>
      oldDelegate.selectedIdx != selectedIdx ||
      oldDelegate.facilities != facilities;
}
