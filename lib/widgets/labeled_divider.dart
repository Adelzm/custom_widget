import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

class LabeledDivider extends LeafRenderObjectWidget {
  final String label;
  final double thickness;
  final Color color;

  const LabeledDivider({
    super.key,
    required this.label,
    this.thickness = 1,
    this.color = Colors.black,
  });

  @override
  RenderLabeledDivider createRenderObject(BuildContext context) {
    return RenderLabeledDivider(
      label: label,
      thickness: thickness,
      color: color,
    );
  }

  @override
  void updateRenderObject(BuildContext context, covariant RenderLabeledDivider renderObject) {
    renderObject
      ..label = label
      ..thickness = thickness
      ..color = color;
    super.updateRenderObject(context, renderObject);
  }
}

class RenderLabeledDivider extends RenderBox {
  String _label;
  double _thickness;
  Color _color;

  late final TextPainter _textPainter;

  RenderLabeledDivider({required String label, required double thickness, required Color color})
      : _label = label,
        _thickness = thickness,
        _color = color,
        _textPainter = TextPainter(textDirection: TextDirection.ltr);

  set label(String value) {
    if (_label != value) {
      _label = value;
      markNeedsLayout();
      markNeedsSemanticsUpdate();
    }
  }

  String get label => _label;

  set thickness(double value) {
    if (_thickness != value) {
      _thickness = value;
      markNeedsLayout();
    }
  }

  double get thickness => _thickness;

  set color(Color value) {
    if (_color != value) {
      _color = value;
      markNeedsPaint();
    }
  }

  Color get color => _color;

  @override
  void performLayout() {
    _textPainter.text = TextSpan(text: _label, style: TextStyle(color: _color));
    _textPainter.layout();
    final double textHeight = _textPainter.size.height;
    size = constraints.constrain(Size(double.maxFinite, _thickness + textHeight));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final paint = Paint()..color = _color;
    final double yCenter = offset.dy + size.height / 2;
    final double lineWidth = (size.width - _textPainter.size.width) / 2;
    const double padding = 10;

    // Draw the line
    context.canvas.drawLine(
      Offset(offset.dx, yCenter),
      Offset(offset.dx + lineWidth - padding, yCenter),
      paint,
    );
    context.canvas.drawLine(
      Offset(offset.dx + lineWidth + _textPainter.size.width + padding, yCenter),
      Offset(offset.dx + size.width, yCenter),
      paint,
    );

    // Draw the text
    final double textStart = offset.dx + (size.width - _textPainter.size.width) / 2;
    _textPainter.paint(context.canvas, Offset(textStart, yCenter - _textPainter.size.height / 2));
  }

  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    super.describeSemanticsConfiguration(config);
    config
      ..isSemanticBoundary = true
      ..label = "Divider with Test: $_label"
      ..textDirection = TextDirection.ltr;
  }
}
