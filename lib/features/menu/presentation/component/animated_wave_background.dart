import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_animations/animation_builder/loop_animation_builder.dart';

/// 波のアニメーションで背景を表現するウィジェット
class AnimatedWaveBackground extends StatelessWidget {
  const AnimatedWaveBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: Container(
          color: Theme.of(context).primaryColorLight,
        )),
        onBottom(const AnimatedWave(
          height: 180,
          speed: 1.0,
        )),
        onBottom(const AnimatedWave(
          height: 120,
          speed: 0.9,
          offset: pi,
        )),
        onBottom(const AnimatedWave(
          height: 220,
          speed: 1.2,
          offset: pi / 2,
        )),
        child,
      ],
    );
  }

  onBottom(Widget child) => Positioned.fill(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: child,
        ),
      );
}

class AnimatedWave extends StatelessWidget {
  const AnimatedWave(
      {super.key,
      required this.height,
      required this.speed,
      this.offset = 0.0});

  final double height;
  final double speed;
  final double offset;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SizedBox(
        height: height,
        width: constraints.biggest.width,
        child: LoopAnimationBuilder<double>(
            duration: Duration(milliseconds: (5000 / speed).round()),
            tween: Tween(begin: 0.0, end: 2 * pi),
            builder: (context, value, child) {
              return CustomPaint(
                foregroundPainter: WaveCurvePainter(value + offset),
              );
            }),
      );
    });
  }
}

class WaveCurvePainter extends CustomPainter {
  final double value;

  WaveCurvePainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    final white = Paint()..color = Colors.white.withAlpha(60);
    final path = Path();

    final y1 = sin(value);
    final y2 = sin(value + pi / 2);
    final y3 = sin(value + pi);

    final startPointY = size.height * (0.5 + 0.4 * y1);
    final controlPointY = size.height * (0.5 + 0.4 * y2);
    final endPointY = size.height * (0.5 + 0.4 * y3);

    path.moveTo(size.width * 0, startPointY);
    path.quadraticBezierTo(
        size.width * 0.5, controlPointY, size.width, endPointY);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, white);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
