import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';
import 'profile_setup_chrome.dart';

typedef ValueFormatter = String Function(double value);

class RulerValuePicker extends StatefulWidget {
  final double min;
  final double max;
  final double value;
  final double step;
  final ValueChanged<double> onChanged;
  final ValueFormatter formatValue;
  final ValueFormatter? formatTick;

  const RulerValuePicker({
    super.key,
    required this.min,
    required this.max,
    required this.value,
    required this.onChanged,
    required this.formatValue,
    this.step = 1,
    this.formatTick,
  });

  @override
  State<RulerValuePicker> createState() => _RulerValuePickerState();
}

class _RulerValuePickerState extends State<RulerValuePicker> {
  late ScrollController _controller;
  static const double _itemExtent = 28;

  int get _itemCount =>
      ((widget.max - widget.min) / widget.step).round() + 1;

  double _valueForIndex(int index) =>
      widget.min + (index * widget.step);

  int _indexForValue(double value) {
    final raw = ((value - widget.min) / widget.step).round();
    return raw.clamp(0, _itemCount - 1);
  }

  @override
  void initState() {
    super.initState();
    final initialIndex = _indexForValue(widget.value);
    _controller = ScrollController(
      initialScrollOffset: initialIndex * _itemExtent,
    );
  }

  @override
  void didUpdateWidget(covariant RulerValuePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    final rangeChanged = oldWidget.min != widget.min ||
        oldWidget.max != widget.max ||
        oldWidget.step != widget.step;
    if (rangeChanged) {
      final index = _indexForValue(widget.value);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_controller.hasClients) {
          _controller.jumpTo(index * _itemExtent);
        }
      });
    } else if ((oldWidget.value - widget.value).abs() > widget.step / 2) {
      final index = _indexForValue(widget.value);
      if (_controller.hasClients) {
        final target = index * _itemExtent;
        if ((_controller.offset - target).abs() > _itemExtent / 2) {
          _controller.animateTo(
            target,
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_controller.hasClients) return;
    final index =
        (_controller.offset / _itemExtent).round().clamp(0, _itemCount - 1);
    final next = _valueForIndex(index);
    if ((next - widget.value).abs() >= widget.step / 2) {
      widget.onChanged(next);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final sidePad = (constraints.maxWidth / 2) - (_itemExtent / 2);

        return NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification is ScrollUpdateNotification ||
                notification is ScrollEndNotification) {
              _onScroll();
            }
            return false;
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 110,
                child: ListView.builder(
                  controller: _controller,
                  scrollDirection: Axis.horizontal,
                  physics: const _SnapScrollPhysics(itemExtent: _itemExtent),
                  padding: EdgeInsets.symmetric(horizontal: sidePad),
                  itemCount: _itemCount,
                  itemBuilder: (context, index) {
                    final tickValue = _valueForIndex(index);
                    final isMajor = index % 2 == 0;
                    final isSelected =
                        (tickValue - widget.value).abs() < widget.step / 2;
                    final label = (widget.formatTick ?? widget.formatValue)(
                      tickValue,
                    );

                    return SizedBox(
                      width: _itemExtent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 28,
                            child: isMajor
                                ? Text(
                                    label,
                                    style: GoogleFonts.outfit(
                                      fontSize: isSelected ? 15 : 12,
                                      fontWeight: isSelected
                                          ? FontWeight.w700
                                          : FontWeight.w500,
                                      color: ProfileSetupColors.ruler
                                          .withValues(
                                        alpha: isSelected ? 1 : 0.75,
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ),
                          Container(
                            width: 2,
                            height: isMajor ? 18 : 12,
                            decoration: BoxDecoration(
                              color: ProfileSetupColors.ruler.withValues(
                                alpha: isSelected ? 1 : 0.55,
                              ),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          Container(
                            width: _itemExtent,
                            height: 2,
                            color: ProfileSetupColors.ruler.withValues(
                              alpha: 0.7,
                            ),
                          ),
                          SizedBox(
                            height: 28,
                            child: !isMajor
                                ? Text(
                                    label,
                                    style: GoogleFonts.outfit(
                                      fontSize: isSelected ? 15 : 12,
                                      fontWeight: isSelected
                                          ? FontWeight.w700
                                          : FontWeight.w500,
                                      color: ProfileSetupColors.ruler
                                          .withValues(
                                        alpha: isSelected ? 1 : 0.75,
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              IgnorePointer(
                child: Container(
                  width: 2.5,
                  height: 54,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SnapScrollPhysics extends ScrollPhysics {
  final double itemExtent;

  const _SnapScrollPhysics({required this.itemExtent, super.parent});

  @override
  _SnapScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return _SnapScrollPhysics(
      itemExtent: itemExtent,
      parent: buildParent(ancestor),
    );
  }

  double _getTargetPixels(
    ScrollMetrics position,
    Tolerance tolerance,
    double velocity,
  ) {
    var page = position.pixels / itemExtent;
    if (velocity < -tolerance.velocity) {
      page -= 0.3;
    } else if (velocity > tolerance.velocity) {
      page += 0.3;
    }
    return page.roundToDouble() * itemExtent;
  }

  @override
  Simulation? createBallisticSimulation(
    ScrollMetrics position,
    double velocity,
  ) {
    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
        (velocity >= 0.0 && position.pixels >= position.maxScrollExtent)) {
      return super.createBallisticSimulation(position, velocity);
    }
    final tolerance = toleranceFor(position);
    final target = _getTargetPixels(position, tolerance, velocity);
    if (target != position.pixels) {
      return ScrollSpringSimulation(
        spring,
        position.pixels,
        target,
        velocity,
        tolerance: tolerance,
      );
    }
    return null;
  }

  @override
  bool get allowImplicitScrolling => false;
}
