import 'package:flutter/material.dart';
import '../widgets/hexagon_shape.dart';
import 'facciones_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.03).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0D1520),
              Color(0xFF000000),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'EL MUNDO DE',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 4,
                    color: Color(0xFF8A9BB0),
                  ),
                ),
                const SizedBox(height: 6),
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [
                      Color(0xFFD0D8E8),
                      Color(0xFF8A9BB0),
                      Color(0xFFD0D8E8),
                    ],
                  ).createShader(
                    Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                  ),
                  child: const Text(
                    'DIVERGENTE',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 8,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 50),

                // HEXÁGONO CENTRAL
                SizedBox(
                  width: 280,
                  height: 280,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 260,
                        height: 260,
                        decoration: ShapeDecoration(
                          shape: const HexagonShape(),
                          color: const Color(0xFF0A1520).withOpacity(0.5),
                          shadows: [
                            BoxShadow(
                              color: const Color(0xFF1A3A5A).withOpacity(0.3),
                              blurRadius: 30,
                              spreadRadius: 10,
                            ),
                          ],
                        ),
                      ),
                      AnimatedBuilder(
                        animation: _pulseAnimation,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _pulseAnimation.value,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const FaccionesScreen(),
                                  ),
                                );
                              },
                              child: Container(
                                width: 140,
                                height: 140,
                                decoration: ShapeDecoration(
                                  shape: const HexagonShape(),
                                  gradient: const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(0xFF2A3A4A),
                                      Color(0xFF1A2A3A),
                                    ],
                                  ),
                                  shadows: [
                                    BoxShadow(
                                      color: const Color(0xFF4A6A8A)
                                          .withOpacity(0.4),
                                      blurRadius: 15,
                                      spreadRadius: 3,
                                    ),
                                  ],
                                ),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.hexagon,
                                      size: 30,
                                      color: Color(0xFF8A9BB0),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'TEST DE\nAPTITUD',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    Text(
                                      'COMENZAR',
                                      style: TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.w300,
                                        letterSpacing: 1.5,
                                        color: Color(0xFF8A9BB0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 60),
                const Column(
                  children: [
                    Text(
                      'Una elección puede transformarte',
                      style: TextStyle(
                        fontSize: 10,
                        fontStyle: FontStyle.italic,
                        letterSpacing: 1,
                        color: Color(0x80A0B8CC),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '#DIVERGENTE',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 4,
                        color: Color(0x60A0B8CC),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}