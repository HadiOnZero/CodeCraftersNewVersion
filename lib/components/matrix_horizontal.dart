import 'package:flutter/material.dart';
import 'dart:math';

class MatrixHorizontal extends StatefulWidget {
  const MatrixHorizontal({super.key});

  @override
  State<MatrixHorizontal> createState() => _MatrixHorizontalState();
}

class _MatrixHorizontalState extends State<MatrixHorizontal>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Random _random = Random();
  final List<String> _attackers = [
    'r0073r',
    'Hmei7',
    'MisterSpy',
    'Kedans-Dz',
    'x264',
    'xNot_Found',
    '404R!p',
    'JengkolDotID',
    'IndoXploit',
    'M4tr!x',
    'N30',
    'Tr!n!ty',
    'M0rpheus',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60, // Fixed safe height
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return ClipRect(
            child: Stack(
              children: [
                // Simple matrix background
                _buildSimpleMatrix(),
                // Safe moving text
                _buildSafeMovingText(),
                // Fade overlay
                _buildFadeOverlay(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSimpleMatrix() {
    return Row(
      children: List.generate(10, (index) {
        return Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(3, (row) {
              return Text(
                String.fromCharCode(_random.nextInt(94) + 33),
                style: TextStyle(
                  color: Colors.greenAccent.withValues(alpha: 0.2),
                  fontFamily: 'monospace',
                  fontSize: 8,
                ),
              );
            }),
          ),
        );
      }),
    );
  }

  Widget _buildSafeMovingText() {
    return Positioned(
      left: -50 + (_controller.value * 100),
      top: 20,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: _attackers.take(3).map((attacker) {
          return Container(
            width: 60,
            height: 20,
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    attacker,
                    style: TextStyle(
                      color: Colors.greenAccent.withValues(alpha: 0.9),
                      fontFamily: 'monospace',
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    attacker.toLowerCase(),
                    style: TextStyle(
                      color: Colors.greenAccent.withValues(alpha: 0.3),
                      fontFamily: 'monospace',
                      fontSize: 6,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFadeOverlay() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.grey[900]!.withValues(alpha: 0.8),
            Colors.transparent,
            Colors.transparent,
            Colors.grey[900]!.withValues(alpha: 0.8),
          ],
          stops: [0.0, 0.1, 0.9, 1.0],
        ),
      ),
    );
  }
}
