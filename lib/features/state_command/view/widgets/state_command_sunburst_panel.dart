import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class StateCommandSunburstPanel extends StatefulWidget {
  const StateCommandSunburstPanel({
    required this.title,
    required this.hierarchyData,
    super.key,
  });

  final String title;
  final Map<String, dynamic> hierarchyData;

  @override
  State<StateCommandSunburstPanel> createState() =>
      _StateCommandSunburstPanelState();
}

class _StateCommandSunburstPanelState extends State<StateCommandSunburstPanel> {
  final List<String> _navigationPath = ['State'];
  late Map<String, dynamic> _currentNode;

  @override
  void initState() {
    super.initState();
    _currentNode = widget.hierarchyData;
  }

  void _drillDown(String childName) {
    final children = (_currentNode['children'] as List<dynamic>?) ?? [];
    final match = children.firstWhere(
      (c) => (c as Map<String, dynamic>)['name'] == childName,
      orElse: () => null,
    );

    if (match != null) {
      setState(() {
        _navigationPath.add(childName);
        _currentNode = match as Map<String, dynamic>;
      });
    }
  }

  void _resetToLevel(int index) {
    if (index == 0) {
      setState(() {
        _navigationPath
          ..clear()
          ..add('State');
        _currentNode = widget.hierarchyData;
      });
      return;
    }

    var temp = widget.hierarchyData;
    final newPath = ['State'];

    for (var i = 1; i <= index; i++) {
      final step = _navigationPath[i];
      final children = (temp['children'] as List<dynamic>?) ?? [];
      final match = children.firstWhere(
        (c) => (c as Map<String, dynamic>)['name'] == step,
        orElse: () => null,
      );
      if (match != null) {
        temp = match as Map<String, dynamic>;
        newPath.add(step);
      } else {
        break;
      }
    }

    setState(() {
      _navigationPath
        ..clear()
        ..addAll(newPath);
      _currentNode = temp;
    });
  }

  Color _getLevelColor(int level) {
    switch (level) {
      case 0:
        return const Color(0xFF1565C0);
      case 1:
        return const Color(0xFF1976D2);
      case 2:
        return const Color(0xFF42A5F5);
      case 3:
        return const Color(0xFF90CAF9);
      default:
        return const Color(0xFFBBDEFB);
    }
  }

  @override
  Widget build(BuildContext context) {
    final children = _currentNode['children'] as List<dynamic>? ?? [];
    final level = _navigationPath.length - 1;
    final color = _getLevelColor(level);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.4)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: AppTextStyles.labelLarge.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Text(
                '🌀 Sunburst',
                style: TextStyle(
                  color: AppColors.primaryLight,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Breadcrumb Navigation
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            width: double.infinity,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 4,
              children: List.generate(_navigationPath.length, (idx) {
                final isLast = idx == _navigationPath.length - 1;
                return GestureDetector(
                  onTap: isLast ? null : () => _resetToLevel(idx),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _navigationPath[idx],
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: isLast
                              ? AppColors.secondaryAccent
                              : AppColors.primaryLight,
                          decoration: isLast
                              ? TextDecoration.none
                              : TextDecoration.underline,
                          fontFamily: AppTextStyles.fontFamily,
                        ),
                      ),
                      if (!isLast)
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            '➔',
                            style: TextStyle(
                              color: Colors.white24,
                              fontSize: 8,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 16),
          // Ring drill-down visualizer
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ring graphic representation
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: color.withValues(alpha: 0.25),
                        width: 18,
                      ),
                    ),
                  ),
                  Container(
                    width: 66,
                    height: 66,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color.withValues(alpha: 0.15),
                      border: Border.all(
                        color: color.withValues(alpha: 0.5),
                        width: 1.5,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      _currentNode['name'] as String,
                      style: const TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              // Segment lists (Drillable options)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'AVAILABLE DRILL-DOWNS:',
                      style: TextStyle(
                        fontSize: 8.5,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondaryText,
                        letterSpacing: 0.4,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (children.isEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            const Text('✨', style: TextStyle(fontSize: 14)),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                _currentNode['value'] != null
                                    ? 'Terminal metric unit value: ${_currentNode['value']}'
                                    : 'End of hierarchical drill-down.',
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.white60,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: children.map((c) {
                          final cMap = c as Map<String, dynamic>;
                          final name = cMap['name'] as String;
                          final hasValue =
                              cMap['value'] != null &&
                              (cMap['value'] as num) > 0;
                          final valueText = hasValue
                              ? ' (${cMap['value']})'
                              : '';

                          return InkWell(
                            onTap: () => _drillDown(name),
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: _getLevelColor(
                                  level + 1,
                                ).withValues(alpha: 0.08),
                                border: Border.all(
                                  color: _getLevelColor(
                                    level + 1,
                                  ).withValues(alpha: 0.3),
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '$name$valueText',
                                    style: TextStyle(
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.bold,
                                      color: _getLevelColor(level + 1),
                                      fontFamily: AppTextStyles.fontFamily,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Icon(
                                    Icons.arrow_right_rounded,
                                    size: 14,
                                    color: _getLevelColor(level + 1),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
