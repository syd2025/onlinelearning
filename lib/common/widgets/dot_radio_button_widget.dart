import 'package:flutter/material.dart';

typedef DotRadioButtonFunction = void Function(bool value);

class DotRadioButtonWidget extends StatefulWidget {
  final double radius;
  final Color strokeColor;
  final double strokeWidth;
  final Color dotColor;
  final DotRadioButtonFunction? onChanged;
  final bool? value;
  final bool? enabled;

  const DotRadioButtonWidget({
    super.key,
    required this.radius,
    required this.strokeColor,
    required this.strokeWidth,
    required this.dotColor,
    this.onChanged,
    this.value,
    this.enabled,
  });

  @override
  State<DotRadioButtonWidget> createState() => _DotRadioButtonWidgetState();
}

class _DotRadioButtonWidgetState extends State<DotRadioButtonWidget> {
  late bool _showDot;
  late bool _enabled;

  @override
  void initState() {
    super.initState();
    _showDot = widget.value ?? false;
    _enabled = widget.enabled ?? true;
  }

  @override
  void didUpdateWidget(covariant DotRadioButtonWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _showDot = widget.value ?? false;
    }
    if (widget.enabled != oldWidget.enabled) {
      _enabled = widget.enabled ?? true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _enabled ? _tapAction : null,
      child: CustomPaint(
        size: Size(widget.radius * 2, widget.radius * 2),
        painter: _DotRadioButtonPainter(
          showDot: _showDot,
          strokeColor: widget.strokeColor,
          strokeWidth: widget.strokeWidth,
          dotColor: widget.dotColor,
        ),
      ),
    );
  }

  void _tapAction() {
    setState(() {
      _showDot = !_showDot;
      widget.onChanged?.call(_showDot);
    });
  }
}

class _DotRadioButtonPainter extends CustomPainter {
  final bool showDot;
  final Color strokeColor;
  final double strokeWidth;
  final Color dotColor;
  _DotRadioButtonPainter({
    required this.showDot,
    required this.strokeColor,
    required this.strokeWidth,
    required this.dotColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = showDot ? dotColor : strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2, paint);

    if (showDot) {
      final dotPaint = Paint()
        ..color = dotColor
        ..style = PaintingStyle.fill;
      canvas.drawCircle(size.center(Offset.zero), size.width / 2 * 0.75, dotPaint);
    }
  }

  @override
  bool shouldRepaint(_DotRadioButtonPainter oldDelegate) {
    return oldDelegate.showDot != showDot;
  }
}
