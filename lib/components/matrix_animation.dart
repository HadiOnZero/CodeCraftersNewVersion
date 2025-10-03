import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

class MatrixAnimation extends StatefulWidget {
  final double width;
  final double height;

  const MatrixAnimation({super.key, required this.width, required this.height});

  @override
  State<MatrixAnimation> createState() => _MatrixAnimationState();
}

class _MatrixAnimationState extends State<MatrixAnimation> {
  late Timer _timer;
  final Random _random = Random();
  final List<MatrixColumn> _columns = [];
  final List<String> _hackerNames = [
    'Neo',
    'Trinity',
    'Morpheus',
    'Niobe',
    'Ghost',
    'Lock',
    'Commander',
    'Oracle',
    'Architect',
    'Merovingian',
    'Persephone',
    'Seraph',
    'Smith',
    'Link',
    'Tank',
    'Dozer',
    'Apoc',
    'Switch',
    'Mouse',
    'Cypher',
    'Agent',
    'Sentinel',
    'Zion',
    'Matrix',
    'Code',
    'Hack',
    'Root',
    'Admin',
    'System',
    'Kernel',
    'Binary',
    'Logic',
    'Syntax',
    'Compile',
    'Debug',
    'Execute',
    'Overflow',
    'Injection',
    'Exploit',
    'Payload',
    'Buffer',
    'Stack',
    'Heap',
    'Memory',
    'Pointer',
    'Register',
    'Cache',
    'Thread',
    'Process',
    'Signal',
    'Interrupt',
    'Handler',
  ];

  @override
  void initState() {
    super.initState();
    _initializeColumns();
    _startAnimation();
  }

  void _initializeColumns() {
    const columnWidth = 20.0;
    final columnCount = (widget.width / columnWidth).floor();

    for (int i = 0; i < columnCount; i++) {
      _columns.add(
        MatrixColumn(
          x: i * columnWidth.toDouble(),
          characters: _generateRandomCharacters(),
          speed: _random.nextDouble() * 0.5 + 0.2,
          length: _random.nextInt(15) + 5,
        ),
      );
    }
  }

  List<String> _generateRandomCharacters() {
    return List.generate(50, (index) {
      if (_random.nextDouble() < 0.1) {
        // 10% chance to show hacker names
        return _hackerNames[_random.nextInt(_hackerNames.length)];
      } else {
        // 90% chance to show matrix characters
        return String.fromCharCode(_random.nextInt(94) + 33); // ASCII 33-126
      }
    });
  }

  void _startAnimation() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        for (var column in _columns) {
          column.update();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: CustomPaint(painter: MatrixPainter(_columns)),
    );
  }
}

class MatrixColumn {
  final double x;
  final List<String> characters;
  final double speed;
  final int length;
  double y = -50;
  int headPosition = 0;
  double opacity = 1.0;

  MatrixColumn({
    required this.x,
    required this.characters,
    required this.speed,
    required this.length,
  });

  void update() {
    y += speed * 20;
    headPosition++;

    if (y > 300) {
      y = -50;
      headPosition = 0;
      opacity = 1.0;
    }

    // Fade out effect
    if (y > 200) {
      opacity = max(0.0, 1.0 - (y - 200) / 100);
    }
  }
}

class MatrixPainter extends CustomPainter {
  final List<MatrixColumn> columns;

  MatrixPainter(this.columns);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    for (var column in columns) {
      for (int i = 0; i < column.length; i++) {
        final charY = column.y - (i * 15);
        if (charY < 0 || charY > size.height) continue;

        // Head character (brightest)
        if (i == 0) {
          paint.color = Colors.greenAccent.withOpacity(column.opacity);
          _drawCharacter(
            canvas,
            column.characters[column.headPosition % column.characters.length],
            column.x,
            charY,
            paint,
            16,
            true,
          );
        }
        // Body characters (fading)
        else {
          final fadeOpacity =
              column.opacity * (1.0 - (i / column.length)) * 0.7;
          paint.color = Colors.green.withOpacity(fadeOpacity);
          final charIndex =
              (column.headPosition - i) % column.characters.length;
          if (charIndex >= 0) {
            _drawCharacter(
              canvas,
              column.characters[charIndex],
              column.x,
              charY,
              paint,
              14,
              false,
            );
          }
        }
      }
    }
  }

  void _drawCharacter(
    Canvas canvas,
    String character,
    double x,
    double y,
    Paint paint,
    double fontSize,
    bool isBold,
  ) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: character,
        style: TextStyle(
          color: paint.color,
          fontSize: fontSize,
          fontFamily: 'monospace',
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(x, y));
  }

  @override
  bool shouldRepaint(MatrixPainter oldDelegate) => true;
}
