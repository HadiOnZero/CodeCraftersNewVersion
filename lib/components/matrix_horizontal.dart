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
    // Zone-H.org attackers
    'r0073r', 'Hmei7', 'MisterSpy', 'Kedans-Dz', 'x264', 'Inj3ct0r',
    'Sn!p3r', 'Dz0ne', 'Dr.S4M007', 'T3rror1st', 'SyRiAn', 'P4r4d0x',
    'An0nC0d3', 'Cr3w', 'D4rkC0d3r', 'Pr0xy', 'L0g1c', 'V10l3t',
    'Ph4nt0m', 'Gh0st', 'Sk!d', 'N!ght', 'Sh4d0w', 'C0d3r',

    // Haxor.id attackers
    'xNot_Found', '404R!p', 'JengkolDotID', 'IndoXploit', 'L0calH0st',
    'R3v3ng3', 'D3str0y3r', 'Pwn3d', '0wn3d', 'H4x0r', 'Cr4ck3r',
    'Br34k3r', 'D3v!l', 'S4t4n', 'Luc!f3r', 'D4rkN3t', 'D33pW3b',
    'An0nym0us', 'G!g4Byt3', 'T3rabyt3', 'P3tabyt3', '3xplo!t',
    'Vuln3r', 'P4yL04d', 'Sh3ll', 'B4ckd00r', 'R00tk!t',

    // Additional hacker names
    'M4tr!x', 'N30', 'Tr!n!ty', 'M0rpheus', 'C0mm4nd3r', 'N!0b3',
    'S3r4ph', 'Ag3nt', 'Sm!th', 'Or4cl3', 'Arch!t3ct', 'M3r0v!ng!4n',
    'K3r0s', 'B4n3', 'D3us', '3x!l3', 'R3b3l', 'Fr33d0m',
    'F!ght3r', 'W4rr!0r', 'H4ck3r', 'Cr4ck3r', 'Phr34k', 'Z3r0',
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
      height: 40, // Fixed height to prevent overflow
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return ClipRect(
            child: Stack(
              children: [
                // Background matrix rain effect
                _buildMatrixRain(),
                // Moving attacker names with trail effect
                _buildAttackerNamesWithTrail(),
                // Overlay gradient for fade effect
                _buildFadeOverlay(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMatrixRain() {
    return Row(
      children: List.generate(30, (index) {
        return Expanded(
          child: Column(
            children: List.generate(5, (row) {
              return Text(
                String.fromCharCode(_random.nextInt(94) + 33),
                style: TextStyle(
                  color: Colors.greenAccent.withValues(
                    alpha: 0.1 + (_random.nextDouble() * 0.2),
                  ),
                  fontFamily: 'monospace',
                  fontSize: 8.0 + _random.nextInt(4).toDouble(),
                ),
              );
            }),
          ),
        );
      }),
    );
  }

  Widget _buildAttackerNamesWithTrail() {
    return Positioned(
      left: -400 + (_controller.value * 800), // Reduced movement range
      top: 8, // Adjusted position
      child: Row(
        children: _attackers.take(12).map((attacker) {
          // Reduced to 12 items
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20), // Reduced padding
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Main attacker name
                Text(
                  attacker,
                  style: TextStyle(
                    color: Colors.greenAccent.withValues(alpha: 0.9),
                    fontFamily: 'monospace',
                    fontSize: 10, // Reduced font size
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    shadows: [
                      Shadow(
                        color: Colors.greenAccent.withValues(alpha: 0.8),
                        blurRadius: 4, // Reduced blur
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                ),
                // Trail effect
                Text(
                  attacker.toLowerCase(),
                  style: TextStyle(
                    color: Colors.greenAccent.withValues(alpha: 0.3),
                    fontFamily: 'monospace',
                    fontSize: 7, // Reduced font size
                    letterSpacing: 1,
                  ),
                ),
              ],
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
