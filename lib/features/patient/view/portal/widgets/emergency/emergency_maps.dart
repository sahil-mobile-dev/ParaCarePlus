import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';

class EmergencyMaps extends StatelessWidget {
  const EmergencyMaps({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = AppSpacing.md;
        final isLargeScreen = constraints.maxWidth > 900;

        final maps = [
          _buildMapCard(
            title: 'Nearest Hospitals & ERs',
            icon: Icons.local_hospital_rounded,
            iconColor: AppColors.error,
            child: SizedBox(
              height: 200,
              child: CustomPaint(
                painter: HospitalsMapPainter(),
                child: Container(),
              ),
            ),
          ),
          _buildMapCard(
            title: 'Live Ambulance Positions',
            icon: Icons.airport_shuttle_rounded,
            iconColor: AppColors.success,
            child: SizedBox(
              height: 200,
              child: CustomPaint(
                painter: AmbulancesMapPainter(),
                child: Container(),
              ),
            ),
          ),
          _buildMapCard(
            title: 'Emergency Route to AIIMS',
            icon: Icons.route_rounded,
            iconColor: AppColors.primaryLight,
            child: SizedBox(
              height: 200,
              child: CustomPaint(
                painter: RouteMapPainter(),
                child: Container(),
              ),
            ),
          ),
        ];

        if (isLargeScreen) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: maps[0]),
              const SizedBox(width: spacing),
              Expanded(child: maps[1]),
              const SizedBox(width: spacing),
              Expanded(child: maps[2]),
            ],
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              maps[0],
              const SizedBox(height: spacing),
              maps[1],
              const SizedBox(height: spacing),
              maps[2],
            ],
          );
        }
      },
    );
  }

  Widget _buildMapCard({
    required String title,
    required IconData icon,
    required Color iconColor,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: const BoxDecoration(
              color: AppColors.surface,
              border: Border(bottom: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              children: [
                Icon(icon, color: iconColor, size: 16),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class HospitalsMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Grid representation of a dark GIS map
    final paintGrid = Paint()
      ..color = AppColors.border.withValues(alpha: 0.15)
      ..strokeWidth = 1;

    for (double i = 0; i < size.width; i += 20) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paintGrid);
    }
    for (double i = 0; i < size.height; i += 20) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paintGrid);
    }

    final cx = size.width / 2;
    final cy = size.height / 2;

    // Draw user coordinates marker
    canvas
      ..drawCircle(
        Offset(cx, cy),
        15,
        Paint()..color = AppColors.primaryLight.withValues(alpha: 0.2),
      )
      ..drawCircle(Offset(cx, cy), 5, Paint()..color = AppColors.primaryLight);

    // Draw nearest hospitals
    _drawMarker(canvas, cx - 40, cy - 30, 'AIIMS Rishikesh', AppColors.error);
    _drawMarker(
      canvas,
      cx + 50,
      cy - 50,
      'Himalayan Hospital',
      AppColors.secondaryAccent,
    );
    _drawMarker(
      canvas,
      cx - 50,
      cy + 40,
      'Doon Hospital',
      AppColors.secondaryAccent,
    );
    _drawMarker(canvas, cx + 30, cy + 30, 'Swami Ram Nagar', AppColors.success);
  }

  void _drawMarker(
    Canvas canvas,
    double x,
    double y,
    String label,
    Color color,
  ) {
    canvas
      ..drawCircle(
        Offset(x, y),
        8,
        Paint()..color = color.withValues(alpha: 0.25),
      )
      ..drawCircle(Offset(x, y), 3.5, Paint()..color = color);

    final textPainter = TextPainter(
      text: TextSpan(
        text: label,
        style: TextStyle(
          color: Colors.white.withValues(alpha: 0.65),
          fontSize: 7,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(canvas, Offset(x - textPainter.width / 2, y + 8));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class AmbulancesMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintGrid = Paint()
      ..color = AppColors.border.withValues(alpha: 0.15)
      ..strokeWidth = 1;

    for (double i = 0; i < size.width; i += 20) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paintGrid);
    }
    for (double i = 0; i < size.height; i += 20) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paintGrid);
    }

    final cx = size.width / 2;
    final cy = size.height / 2;

    // Draw user pin
    canvas
      ..drawCircle(
        Offset(cx, cy),
        15,
        Paint()..color = AppColors.primaryLight.withValues(alpha: 0.2),
      )
      ..drawCircle(Offset(cx, cy), 5, Paint()..color = AppColors.primaryLight);

    // Draw active ambulances
    _drawAmbMarker(
      canvas,
      cx - 25,
      cy - 20,
      'UK-AMB-04 (En Route)',
      AppColors.error,
    );
    _drawAmbMarker(
      canvas,
      cx + 55,
      cy + 20,
      'UK-AMB-07 (Available)',
      AppColors.success,
    );
    _drawAmbMarker(
      canvas,
      cx - 45,
      cy + 45,
      'UK-AMB-12 (Busy)',
      AppColors.secondaryAccent,
    );
  }

  void _drawAmbMarker(
    Canvas canvas,
    double x,
    double y,
    String label,
    Color color,
  ) {
    canvas
      ..drawCircle(
        Offset(x, y),
        9,
        Paint()..color = color.withValues(alpha: 0.25),
      )
      ..drawCircle(Offset(x, y), 4, Paint()..color = color);

    final textPainter = TextPainter(
      text: TextSpan(
        text: label,
        style: TextStyle(
          color: Colors.white.withValues(alpha: 0.65),
          fontSize: 7,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(canvas, Offset(x - textPainter.width / 2, y + 8));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class RouteMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintGrid = Paint()
      ..color = AppColors.border.withValues(alpha: 0.15)
      ..strokeWidth = 1;

    for (double i = 0; i < size.width; i += 20) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paintGrid);
    }
    for (double i = 0; i < size.height; i += 20) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paintGrid);
    }

    final cx = size.width / 2;
    final cy = size.height / 2;

    // Draw starting point (You)
    // Draw starting point (You) and ending point (AIIMS ER)
    canvas
      ..drawCircle(
        Offset(cx - 50, cy + 30),
        12,
        Paint()..color = AppColors.primaryLight.withValues(alpha: 0.25),
      )
      ..drawCircle(
        Offset(cx - 50, cy + 30),
        4,
        Paint()..color = AppColors.primaryLight,
      )
      ..drawCircle(
        Offset(cx + 40, cy - 30),
        15,
        Paint()..color = AppColors.error.withValues(alpha: 0.25),
      )
      ..drawCircle(
        Offset(cx + 40, cy - 30),
        5,
        Paint()..color = AppColors.error,
      );

    // Draw route path line
    final routePaint = Paint()
      ..color = AppColors.error
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(cx - 50, cy + 30)
      ..lineTo(cx - 20, cy + 20)
      ..lineTo(cx - 10, cy - 10)
      ..lineTo(cx + 20, cy - 20)
      ..lineTo(cx + 40, cy - 30);

    canvas.drawPath(path, routePaint);

    // Label coordinates
    final tp1 = TextPainter(
      text: const TextSpan(
        text: 'You',
        style: TextStyle(
          color: Colors.white,
          fontSize: 7.5,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp1.paint(canvas, Offset(cx - 50 - tp1.width / 2, cy + 44));

    final tp2 = TextPainter(
      text: const TextSpan(
        text: 'AIIMS Rishikesh ER',
        style: TextStyle(
          color: AppColors.error,
          fontSize: 7.5,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp2.paint(canvas, Offset(cx + 40 - tp2.width / 2, cy - 46));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
