import 'package:flutter/material.dart';

enum DividerWidgetType {
  normal,
}

class DividerWidget extends StatelessWidget {
  const DividerWidget(
      {super.key,
      this.height,
      this.indent,
      this.endIndent,
      this.color,
      this.thickness,
      this.type});

  final double? height;
  final double? indent;
  final DividerWidgetType? type;
  final double? endIndent;
  final double? thickness;
  final Color? color;

  const DividerWidget.normal({
    super.key,
    this.height,
    this.indent,
    this.endIndent,
    this.color,
    this.thickness,
  }) : type = DividerWidgetType.normal;

  Widget _buildView() {
    return Divider(
      height: height ?? 0.5,
      indent: indent ?? 50,
      endIndent: endIndent ?? 15,
      thickness: thickness ?? 1,
      color: color ?? Colors.grey,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildView();
  }
}
