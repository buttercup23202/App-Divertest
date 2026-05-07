import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const DivergentTestApp());
}

class DivergentTestApp extends StatelessWidget {
  const DivergentTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'El Mundo de Divergente',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const WelcomeScreen(),
    );
  }
}

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
        child: Stack(
          children: [
            // Fondo estático con partículas
            const BackgroundParticles(),
            
            // Contenido principal
            SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    
                    // Título
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
                      ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
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

                    // Gran hexágono central
                    SizedBox(
                      width: 360,
                      height: 360,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Hexágono base de fondo
                          Container(
                            width: 340,
                            height: 340,
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
                          
                          // Hexágonos de facciones alrededor
                          ..._buildFactionHexagons(),
                          
                          // Botón central hexagonal con animación de pulso
                          AnimatedBuilder(
                            animation: _pulseAnimation,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: _pulseAnimation.value,
                                child: GestureDetector(
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Test comenzará pronto')),
                                    );
                                  },
                                  child: Container(
                                    width: 130,
                                    height: 130,
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
                                          color: const Color(0xFF4A6A8A).withOpacity(0.4),
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

                    // Footer
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
          ],
        ),
      ),
    );
  }

  List<Widget> _buildFactionHexagons() {
    const List<FactionHexData> factions = [
      FactionHexData('OSADÍA', Icons.flash_on, Color(0xFFB84A2A)),
      FactionHexData('ERUDICIÓN', Icons.menu_book, Color(0xFF144A7A)),
      FactionHexData('ABNEGACIÓN', Icons.handshake, Color(0xFF7A7870)),
      FactionHexData('VERDAD', Icons.account_balance, Color(0xFF4A4290)),
      FactionHexData('AMABILIDAD', Icons.eco, Color(0xFF2A5A10)),
      FactionHexData('DIVERGENTE', Icons.brightness_auto, Color(0xFFA09050)),
    ];

    // Posiciones para los hexágonos alrededor del centro
    const List<Offset> positions = [
      Offset(0, -125),     // Osadía (arriba)
      Offset(108, -62),    // Erudición (derecha arriba)
      Offset(108, 62),     // Abnegación (derecha abajo)
      Offset(0, 125),      // Verdad (abajo)
      Offset(-108, 62),    // Amabilidad (izquierda abajo)
      Offset(-108, -62),   // Divergente (izquierda arriba)
    ];

    List<Widget> hexagons = [];
    for (int i = 0; i < positions.length; i++) {
      hexagons.add(
        Positioned(
          left: 180 + positions[i].dx - 40,
          top: 180 + positions[i].dy - 40,
          child: FloatingHexagon(
            faction: factions[i],
            delay: Duration(milliseconds: i * 200),
          ),
        ),
      );
    }
    return hexagons;
  }
}

class FactionHexData {
  final String name;
  final IconData icon;
  final Color color;

  const FactionHexData(this.name, this.icon, this.color);
}

class FloatingHexagon extends StatefulWidget {
  final FactionHexData faction;
  final Duration delay;

  const FloatingHexagon({super.key, required this.faction, required this.delay});

  @override
  State<FloatingHexagon> createState() => _FloatingHexagonState();
}

class _FloatingHexagonState extends State<FloatingHexagon>
    with SingleTickerProviderStateMixin {
  late AnimationController _floatController;
  late Animation<double> _floatAnimation;
  bool isHovered = false;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..repeat(reverse: true);
    _floatAnimation = Tween<double>(begin: -5, end: -15).animate(
      CurvedAnimation(
        parent: _floatController,
        curve: Curves.easeInOut,
      ),
    );
    Future.delayed(widget.delay, () {
      if (mounted) _floatController.forward();
    });
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _floatAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatAnimation.value),
          child: MouseRegion(
            onEnter: (_) => setState(() => isHovered = true),
            onExit: (_) => setState(() => isHovered = false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: isHovered ? 85 : 80,
              height: isHovered ? 85 : 80,
              decoration: ShapeDecoration(
                shape: const HexagonShape(),
                color: widget.faction.color.withOpacity(0.7),
                shadows: [
                  BoxShadow(
                    color: widget.faction.color.withOpacity(isHovered ? 0.6 : 0.3),
                    blurRadius: isHovered ? 18 : 10,
                    spreadRadius: isHovered ? 3 : 0,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    widget.faction.icon,
                    color: Colors.white.withOpacity(0.9),
                    size: isHovered ? 30 : 26,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.faction.name,
                    style: TextStyle(
                      fontSize: isHovered ? 10 : 9,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withOpacity(0.9),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// HexagonShape corregido y completo
class HexagonShape extends ShapeBorder {
  const HexagonShape();

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final double width = rect.width;
    final double height = rect.height;
    final double side = width / 2;
    final Path path = Path();
    path.moveTo(rect.left + side, rect.top);
    path.lineTo(rect.right, rect.top + height * 0.25);
    path.lineTo(rect.right, rect.top + height * 0.75);
    path.lineTo(rect.left + side, rect.bottom);
    path.lineTo(rect.left, rect.top + height * 0.75);
    path.lineTo(rect.left, rect.top + height * 0.25);
    path.close();
    return path;
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return getOuterPath(rect, textDirection: textDirection);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => const HexagonShape();
}

// Fondo estático con partículas (sin animación compleja)
class BackgroundParticles extends StatelessWidget {
  const BackgroundParticles({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ParticlePainter(),
      size: Size.infinite,
    );
  }
}

class ParticlePainter extends CustomPainter {
  final Random random = Random(42);
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF4A6A8A).withOpacity(0.06)
      ..style = PaintingStyle.fill;
    
    // Dibujar partículas estáticas en toda la pantalla
    for (int i = 0; i < 100; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      
      canvas.drawCircle(
        Offset(x, y),
        1 + random.nextDouble() * 2,
        paint,
      );
    }
  }
  
  @override
  bool shouldRepaint(ParticlePainter oldDelegate) => false;
}