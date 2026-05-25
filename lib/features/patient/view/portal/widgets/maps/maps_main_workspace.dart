import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';

class MapsMainWorkspace extends StatefulWidget {
  const MapsMainWorkspace({required this.mapType, super.key});

  final String mapType;

  @override
  State<MapsMainWorkspace> createState() => _MapsMainWorkspaceState();
}

class _MapsMainWorkspaceState extends State<MapsMainWorkspace> {
  int _selectedFacilityIdx = 0;
  String _activeLayer = 'street';
  bool _trafficOn = false;
  final TextEditingController _searchCtrl = TextEditingController(
    text: 'Rishikesh',
  );
  double _radius = 10;

  final List<Map<String, dynamic>> _facilities = const [
    {
      'name': 'AIIMS Rishikesh',
      'dist': '0.2 km',
      'eta': '2 min',
      'badge': 'Open 24/7',
      'badgeColor': AppColors.success,
    },
    {
      'name': 'District Hospital Rishikesh',
      'dist': '3.4 km',
      'eta': '9 min',
      'badge': 'Govt',
      'badgeColor': AppColors.primaryLight,
    },
    {
      'name': 'Swami Ram Himalayan Hospital',
      'dist': '5.1 km',
      'eta': '14 min',
      'badge': 'Private',
      'badgeColor': Color(0xFFC77DFF),
    },
    {
      'name': 'Dehradun General Hospital',
      'dist': '8.7 km',
      'eta': '22 min',
      'badge': 'Govt',
      'badgeColor': AppColors.success,
    },
    {
      'name': 'Himalayan Institute Hospital',
      'dist': '9.3 km',
      'eta': '24 min',
      'badge': 'Private',
      'badgeColor': Color(0xFFC77DFF),
    },
  ];

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  String get _mapTitle {
    const titles = {
      'hospitals': 'Nearest Hospitals — Rishikesh Region',
      'pharmacy': '24×7 Pharmacies — Rishikesh',
      'labs': 'Diagnostic Laboratories — Rishikesh',
      'blood': 'Blood Banks & Donors — Rishikesh',
      'ambulance': 'Live Ambulance Positions',
      'vaccination': 'Vaccination Centres — Uttarakhand',
      'doctors': 'Specialist Doctors — Online & Nearby',
      'route': 'Route to AIIMS Rishikesh',
      'disease': 'Disease Heatmap — Active Alerts',
      'abha': 'ABHA Enrolment Centres',
      'indoor': 'Indoor Navigation — AIIMS Rishikesh',
    };
    return titles[widget.mapType] ?? 'Nearest Hospitals — Rishikesh Region';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 560,
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: [
              // Map title bar
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: AppColors.border)),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on_rounded,
                      color: AppColors.primaryLight,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _mapTitle,
                        style: const TextStyle(
                          color: AppColors.primaryText,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    _LayerBtn(
                      label: 'Street',
                      isActive: _activeLayer == 'street',
                      onTap: () => setState(() => _activeLayer = 'street'),
                    ),
                    const SizedBox(width: 6),
                    _LayerBtn(
                      label: 'Satellite',
                      isActive: _activeLayer == 'satellite',
                      onTap: () => setState(() => _activeLayer = 'satellite'),
                    ),
                    const SizedBox(width: 6),
                    _LayerBtn(
                      label: 'Traffic',
                      isActive: _trafficOn,
                      onTap: () => setState(() => _trafficOn = !_trafficOn),
                    ),
                    const SizedBox(width: 6),
                    _LayerBtn(
                      label: '',
                      icon: Icons.fullscreen_rounded,
                      isActive: false,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              // Map canvas
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(14),
                  ),
                  child: Stack(
                    children: [
                      CustomPaint(
                        painter: _MapCanvasPainter(
                          mapType: widget.mapType,
                          selectedIdx: _selectedFacilityIdx,
                          trafficOn: _trafficOn,
                        ),
                        child: Container(),
                      ),
                      // Legend
                      Positioned(
                        bottom: 14,
                        left: 14,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xE5060F1C),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'LEGEND',
                                style: TextStyle(
                                  color: AppColors.secondaryText,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(height: 4),
                              ...[
                                (AppColors.success, 'Govt. Hospital'),
                                (AppColors.primaryLight, 'Private Hospital'),
                                (AppColors.error, 'Emergency Active'),
                                (AppColors.secondaryAccent, 'Your Location'),
                              ].map(
                                (item) => Padding(
                                  padding: const EdgeInsets.only(bottom: 2),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 10,
                                        height: 10,
                                        decoration: BoxDecoration(
                                          color: item.$1,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        item.$2,
                                        style: const TextStyle(
                                          color: AppColors.secondaryText,
                                          fontSize: 10,
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
                      // Location badge
                      Positioned(
                        top: 14,
                        right: 14,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryLight.withValues(
                              alpha: 0.15,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: AppColors.primaryLight.withValues(
                                alpha: 0.4,
                              ),
                            ),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.my_location_rounded,
                                size: 12,
                                color: AppColors.primaryLight,
                              ),
                              SizedBox(width: 5),
                              Text(
                                '📍 Rishikesh, Uttarakhand',
                                style: TextStyle(
                                  color: AppColors.primaryLight,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
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
            ],
          ),
        ),

        const SizedBox(height: AppSpacing.md),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.93,
              child: Column(
                children: [
                  // Search + facility list
                  _PanelBox(
                    title: 'Search Location',
                    icon: Icons.search_rounded,
                    iconColor: AppColors.primaryLight,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 36,
                                decoration: BoxDecoration(
                                  color: AppColors.surface,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: AppColors.border),
                                ),
                                child: TextField(
                                  controller: _searchCtrl,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 8,
                                    ),
                                    border: InputBorder.none,
                                    hintText: 'Search hospital, pharmacy…',
                                    hintStyle: TextStyle(
                                      color: AppColors.secondaryText,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: 36,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      AppColors.primaryLight,
                                      Color(0xFF4361EE),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.search_rounded,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Nearby facilities within 10 km radius:',
                            style: TextStyle(
                              color: AppColors.secondaryText,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 210,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: _facilities.length,
                            itemBuilder: (ctx, i) {
                              final f = _facilities[i];
                              final isSel = i == _selectedFacilityIdx;
                              return GestureDetector(
                                onTap: () =>
                                    setState(() => _selectedFacilityIdx = i),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 150),
                                  margin: const EdgeInsets.only(bottom: 7),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 11,
                                    vertical: 9,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.surface,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: isSel
                                          ? AppColors.success
                                          : AppColors.border,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        f['name'] as String,
                                        style: TextStyle(
                                          color: isSel
                                              ? AppColors.primaryText
                                              : AppColors.primaryText,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on_rounded,
                                            size: 10,
                                            color: AppColors.secondaryText,
                                          ),
                                          const SizedBox(width: 3),
                                          Text(
                                            f['dist'] as String,
                                            style: const TextStyle(
                                              color: AppColors.secondaryText,
                                              fontSize: 10,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          const Icon(
                                            Icons.access_time_rounded,
                                            size: 10,
                                            color: AppColors.secondaryText,
                                          ),
                                          const SizedBox(width: 3),
                                          Text(
                                            f['eta'] as String,
                                            style: const TextStyle(
                                              color: AppColors.secondaryText,
                                              fontSize: 10,
                                            ),
                                          ),
                                          const Spacer(),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 7,
                                              vertical: 1,
                                            ),
                                            decoration: BoxDecoration(
                                              color: (f['badgeColor'] as Color)
                                                  .withValues(alpha: 0.15),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              f['badge'] as String,
                                              style: TextStyle(
                                                color: f['badgeColor'] as Color,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Route info
                  _PanelBox(
                    title: 'Route to AIIMS Rishikesh',
                    icon: Icons.route_rounded,
                    iconColor: AppColors.success,
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            _RouteStatBox(
                              value: '4.2',
                              label: 'km Distance',
                              color: AppColors.primaryLight,
                            ),
                            SizedBox(width: 8),
                            _RouteStatBox(
                              value: '12',
                              label: 'min ETA',
                              color: AppColors.success,
                            ),
                            SizedBox(width: 8),
                            _RouteStatBox(
                              value: 'Via',
                              label: 'Haridwar Rd',
                              color: AppColors.secondaryAccent,
                            ),
                            SizedBox(width: 8),
                            _RouteStatBox(
                              value: 'Low',
                              label: 'Traffic',
                              color: Color(0xFFC77DFF),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.success,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 7,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  elevation: 0,
                                ),
                                icon: const Icon(
                                  Icons.navigation_rounded,
                                  size: 14,
                                  color: Colors.white,
                                ),
                                label: const Text(
                                  'Start Navigation',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                onPressed: () {},
                              ),
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 7,
                                  ),
                                  side: const BorderSide(
                                    color: AppColors.border,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.share_rounded,
                                  size: 14,
                                  color: AppColors.secondaryText,
                                ),
                                label: const Text(
                                  'Share',
                                  style: TextStyle(
                                    color: AppColors.secondaryText,
                                    fontSize: 11,
                                  ),
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Map filters
                  _PanelBox(
                    title: 'Map Filters',
                    icon: Icons.filter_list_rounded,
                    iconColor: const Color(0xFFC77DFF),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...[
                          (AppColors.success, 'Government Hospitals', true),
                          (AppColors.primaryLight, 'Private Hospitals', true),
                          (AppColors.error, 'Live Ambulances', true),
                          (
                            AppColors.secondaryAccent,
                            'PHC / Sub-Centres',
                            false,
                          ),
                          (const Color(0xFFC77DFF), 'AYUSH Centres', false),
                        ].map(
                          (item) => Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: Checkbox(
                                    value: item.$3,
                                    onChanged: (_) {},
                                    activeColor: AppColors.primaryLight,
                                    checkColor: Colors.white,
                                    side: const BorderSide(
                                      color: AppColors.border,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Icon(Icons.circle, size: 10, color: item.$1),
                                const SizedBox(width: 6),
                                Text(
                                  item.$2,
                                  style: const TextStyle(
                                    color: AppColors.primaryText,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Radius:',
                              style: TextStyle(
                                color: AppColors.secondaryText,
                                fontSize: 11,
                              ),
                            ),
                            Text(
                              '${_radius.round()} km',
                              style: const TextStyle(
                                color: AppColors.primaryLight,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            trackHeight: 3,
                            thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 7,
                            ),
                            overlayShape: const RoundSliderOverlayShape(
                              overlayRadius: 12,
                            ),
                          ),
                          child: Slider(
                            value: _radius,
                            min: 2,
                            max: 50,
                            divisions: 48,
                            activeColor: AppColors.primaryLight,
                            inactiveColor: AppColors.border,
                            onChanged: (v) => setState(() => _radius = v),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ─────────────────────── Helper Widgets ───────────────────────

class _LayerBtn extends StatelessWidget {
  const _LayerBtn({
    required this.label,
    required this.isActive,
    required this.onTap,
    this.icon,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: icon != null ? 8 : 10,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.primaryLight.withValues(alpha: 0.15)
              : AppColors.surface,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isActive ? AppColors.primaryLight : AppColors.border,
          ),
        ),
        child: icon != null
            ? Icon(icon, size: 14, color: AppColors.secondaryText)
            : Text(
                label,
                style: TextStyle(
                  color: isActive
                      ? AppColors.primaryLight
                      : AppColors.secondaryText,
                  fontSize: 11,
                ),
              ),
      ),
    );
  }
}

class _RouteStatBox extends StatelessWidget {
  const _RouteStatBox({
    required this.value,
    required this.label,
    required this.color,
  });

  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.secondaryText,
                fontSize: 9,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PanelBox extends StatelessWidget {
  const _PanelBox({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.child,
  });

  final String title;
  final IconData icon;
  final Color iconColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 14),
              const SizedBox(width: 6),
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

// ─────────────────────── Map Canvas Painter ───────────────────────

class _MapCanvasPainter extends CustomPainter {
  const _MapCanvasPainter({
    required this.mapType,
    required this.selectedIdx,
    required this.trafficOn,
  });

  final String mapType;
  final int selectedIdx;
  final bool trafficOn;

  static const _hospitals = [
    (0.45, 0.45, AppColors.success, 'AIIMS Rishikesh'),
    (0.38, 0.62, AppColors.primaryLight, 'District Hospital'),
    (0.65, 0.32, Color(0xFFC77DFF), 'Swami Ram'),
    (0.28, 0.75, AppColors.success, 'Dehradun Gen.'),
    (0.72, 0.68, Color(0xFFC77DFF), 'Himalayan Inst.'),
    (0.55, 0.22, AppColors.success, 'CHC Rishikesh'),
    (0.35, 0.52, AppColors.primaryLight, 'Max Superspec.'),
    (0.70, 0.55, AppColors.success, 'Yatra Nagar PHC'),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    // Dark background
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = const Color(0xFF060F1C),
    );

    // Grid lines
    final gridPaint = Paint()
      ..color = AppColors.border.withValues(alpha: 0.3)
      ..strokeWidth = 0.5;
    for (double x = 0; x < size.width; x += 40) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += 40) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // River simulation (winding path)
    final riverPath = Path()
      ..moveTo(0, size.height * 0.4)
      ..cubicTo(
        size.width * 0.2,
        size.height * 0.35,
        size.width * 0.5,
        size.height * 0.5,
        size.width * 0.8,
        size.height * 0.45,
      )
      ..cubicTo(
        size.width * 0.9,
        size.height * 0.43,
        size.width,
        size.height * 0.42,
        size.width,
        size.height * 0.42,
      );
    canvas.drawPath(
      riverPath,
      Paint()
        ..color = AppColors.primaryLight.withValues(alpha: 0.12)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 12,
    );

    // Road network
    final roadPaint = Paint()
      ..color = AppColors.border.withValues(alpha: 0.6)
      ..strokeWidth = 2;
    final roads = [
      [Offset(0, size.height * 0.5), Offset(size.width, size.height * 0.5)],
      [Offset(size.width * 0.45, 0), Offset(size.width * 0.45, size.height)],
      [
        Offset(0, size.height * 0.25),
        Offset(size.width * 0.7, size.height * 0.7),
      ],
      [Offset(size.width * 0.2, 0), Offset(size.width, size.height * 0.6)],
    ];
    for (final road in roads) {
      canvas.drawLine(road[0], road[1], roadPaint);
    }

    // Traffic overlay
    if (trafficOn) {
      canvas.drawLine(
        Offset(0, size.height * 0.5),
        Offset(size.width * 0.4, size.height * 0.5),
        Paint()
          ..color = AppColors.error.withValues(alpha: 0.5)
          ..strokeWidth = 4,
      );
      canvas.drawLine(
        Offset(size.width * 0.4, size.height * 0.5),
        Offset(size.width, size.height * 0.5),
        Paint()
          ..color = AppColors.success.withValues(alpha: 0.5)
          ..strokeWidth = 4,
      );
    }

    // Route line (for route type)
    if (mapType == 'route') {
      final routePath = Path()
        ..moveTo(size.width * 0.5, size.height * 0.55)
        ..lineTo(size.width * 0.47, size.height * 0.50)
        ..lineTo(size.width * 0.45, size.height * 0.45);
      canvas.drawPath(
        routePath,
        Paint()
          ..color = AppColors.primaryLight
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4,
      );
    }

    // Disease heatmap circles
    if (mapType == 'disease') {
      for (final spot in [
        (0.55, 0.42, 60.0),
        (0.62, 0.36, 40.0),
        (0.40, 0.56, 30.0),
        (0.70, 0.30, 50.0),
      ]) {
        canvas.drawCircle(
          Offset(size.width * spot.$1, size.height * spot.$2),
          spot.$3,
          Paint()
            ..color = AppColors.secondaryAccent.withValues(alpha: 0.2)
            ..style = PaintingStyle.fill,
        );
        canvas.drawCircle(
          Offset(size.width * spot.$1, size.height * spot.$2),
          spot.$3,
          Paint()
            ..color = const Color(0xFFF77F00).withValues(alpha: 0.4)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.5,
        );
      }
    }

    // Facility markers
    for (var i = 0; i < _hospitals.length; i++) {
      final h = _hospitals[i];
      final pt = Offset(size.width * h.$1, size.height * h.$2);
      final isSel = i == selectedIdx;
      final color = h.$3;

      if (isSel) {
        canvas.drawCircle(
          pt,
          18,
          Paint()..color = color.withValues(alpha: 0.2),
        );
      }

      canvas.drawCircle(
        pt,
        isSel ? 12 : 9,
        Paint()
          ..color = color
          ..style = PaintingStyle.fill,
      );
      canvas.drawCircle(
        pt,
        isSel ? 12 : 9,
        Paint()
          ..color = Colors.white.withValues(alpha: 0.4)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      );
      canvas.drawCircle(pt, isSel ? 4 : 3, Paint()..color = Colors.white);

      if (isSel) {
        final tp = TextPainter(
          text: TextSpan(
            text: h.$4,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 9,
              fontWeight: FontWeight.w600,
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: 90);
        final bg = Rect.fromCenter(
          center: Offset(pt.dx, pt.dy - 22),
          width: tp.width + 10,
          height: 16,
        );
        canvas.drawRRect(
          RRect.fromRectAndRadius(bg, const Radius.circular(4)),
          Paint()..color = color.withValues(alpha: 0.85),
        );
        tp.paint(canvas, Offset(bg.left + 5, bg.top + 2));
      }
    }

    // User location
    final userPt = Offset(size.width * 0.5, size.height * 0.55);
    canvas
      ..drawCircle(
        userPt,
        20,
        Paint()..color = AppColors.secondaryAccent.withValues(alpha: 0.15),
      )
      ..drawCircle(
        userPt,
        10,
        Paint()..color = AppColors.secondaryAccent.withValues(alpha: 0.35),
      )
      ..drawCircle(userPt, 6, Paint()..color = AppColors.secondaryAccent)
      ..drawCircle(userPt, 3, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant _MapCanvasPainter old) =>
      old.mapType != mapType ||
      old.selectedIdx != selectedIdx ||
      old.trafficOn != trafficOn;
}
