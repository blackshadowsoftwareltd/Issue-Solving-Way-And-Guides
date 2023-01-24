import 'dart:math' as math;
import 'package:flutter/widgets.dart';

class PouringHourGlassIndicator extends StatefulWidget {
  const PouringHourGlassIndicator({
    Key? key,
    required this.color,
    this.size = 50.0,
    this.duration = const Duration(milliseconds: 2400),
    this.strokeWidth,
    this.controller,
  }) : super(key: key);

  final double size;
  final Color color;
  final Duration duration;
  final double? strokeWidth;
  final AnimationController? controller;

  @override
  _PouringHourGlassIndicatorState createState() =>
      _PouringHourGlassIndicatorState();
}

class _PouringHourGlassIndicatorState extends State<PouringHourGlassIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pouringAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    _controller = (widget.controller ??
        AnimationController(vsync: this, duration: widget.duration))
      ..addListener(() => setState(() {}))
      ..repeat();
    _pouringAnimation =
        CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.9))
          ..addListener(() => setState(() {}));
    _rotationAnimation = Tween(begin: 0.0, end: 0.5).animate(CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.9, 1.0, curve: Curves.fastOutSlowIn)));
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RotationTransition(
        turns: _rotationAnimation,
        child: SizedBox.fromSize(
          size: Size.square(widget.size * math.sqrt1_2),
          child: CustomPaint(
            painter: _HourGlassPaint(
              poured: _pouringAnimation.value,
              color: widget.color,
              strokeWidth: widget.strokeWidth,
            ),
          ),
        ),
      ),
    );
  }
}

class _HourGlassPaint extends CustomPainter {
  _HourGlassPaint({this.strokeWidth, this.poured, required Color color})
      : _paint = Paint()
          ..style = PaintingStyle.stroke
          ..color = color,
        _powderPaint = Paint()
          ..style = PaintingStyle.fill
          ..color = color;

  final double? strokeWidth;
  final double? poured;
  final Paint _paint;
  final Paint _powderPaint;

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final halfHeight = size.height / 2;
    final hourglassWidth = math.min(centerX * 0.8, halfHeight);
    final gapWidth = math.max(3.0, hourglassWidth * 0.05);
    final yPadding = gapWidth / 2;
    final top = yPadding;
    final bottom = size.height - yPadding;
    _paint.strokeWidth = strokeWidth ?? gapWidth;

    final hourglassPath = Path()
      ..moveTo(centerX - hourglassWidth, top)
      ..lineTo(centerX + hourglassWidth, top)
      ..lineTo(centerX + gapWidth, halfHeight)
      ..lineTo(centerX + hourglassWidth, bottom)
      ..lineTo(centerX - hourglassWidth, bottom)
      ..lineTo(centerX - gapWidth, halfHeight)
      ..close();
    canvas.drawPath(hourglassPath, _paint);

    final upperPart = Path()
      ..moveTo(0.0, top)
      ..addRect(
          Rect.fromLTRB(0.0, halfHeight * poured!, size.width, halfHeight));
    canvas.drawPath(
        Path.combine(PathOperation.intersect, hourglassPath, upperPart),
        _powderPaint);

    final lowerPartPath = Path()
      ..moveTo(centerX, bottom)
      ..relativeLineTo(hourglassWidth * poured!, 0.0)
      ..lineTo(centerX, bottom - poured! * halfHeight - gapWidth)
      ..lineTo(centerX - hourglassWidth * poured!, bottom)
      ..close();
    final lowerPart = Path.combine(
      PathOperation.intersect,
      lowerPartPath,
      Path()..addRect(Rect.fromLTRB(0.0, halfHeight, size.width, size.height)),
    );
    canvas.drawPath(lowerPart, _powderPaint);

    canvas.drawLine(
        Offset(centerX, halfHeight), Offset(centerX, bottom), _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
//////////////////////////////////////////////////////!

class FadingCircle extends StatefulWidget {
  const FadingCircle({
    Key? key,
    this.color,
    this.size = 50.0,
    this.itemBuilder,
    this.duration = const Duration(milliseconds: 1200),
    this.controller,
  })  : assert(
            !(itemBuilder is IndexedWidgetBuilder && color is Color) &&
                !(itemBuilder == null && color == null),
            'You should specify either a itemBuilder or a color'),
        super(key: key);

  final Color? color;
  final double size;
  final IndexedWidgetBuilder? itemBuilder;
  final Duration duration;
  final AnimationController? controller;

  @override
  _FadingCircleState createState() => _FadingCircleState();
}

class _FadingCircleState extends State<FadingCircle>
    with SingleTickerProviderStateMixin {
  final List<double> delays = [
    .0,
    -1.1,
    -1.0,
    -0.9,
    -0.8,
    -0.7,
    -0.6,
    -0.5,
    -0.4,
    -0.3,
    -0.2,
    -0.1
  ];
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = (widget.controller ??
        AnimationController(vsync: this, duration: widget.duration))
      ..repeat();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.fromSize(
        size: Size.square(widget.size),
        child: Stack(
          children: List.generate(12, (i) {
            final _position = widget.size * .5;
            return Positioned.fill(
              left: _position,
              top: _position,
              child: Transform(
                transform: Matrix4.rotationZ(30.0 * i * 0.0174533),
                child: Align(
                  alignment: Alignment.center,
                  child: FadeTransition(
                    opacity: DelayTween(begin: 0.0, end: 1.0, delay: delays[i])
                        .animate(_controller),
                    child: SizedBox.fromSize(
                        size: Size.square(widget.size * 0.15),
                        child: _itemBuilder(i)),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _itemBuilder(int index) => widget.itemBuilder != null
      ? widget.itemBuilder!(context, index)
      : DecoratedBox(
          decoration:
              BoxDecoration(color: widget.color, shape: BoxShape.circle));
}

class DelayTween extends Tween<double> {
  DelayTween({double? begin, double? end, required this.delay})
      : super(begin: begin, end: end);

  final double delay;

  @override
  double lerp(double t) =>
      super.lerp((math.sin((t - delay) * 2 * math.pi) + 1) / 2);

  @override
  double evaluate(Animation<double> animation) => lerp(animation.value);
}
