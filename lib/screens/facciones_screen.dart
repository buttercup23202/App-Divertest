import 'package:flutter/material.dart';
import 'test_screen.dart';

class FaccionesScreen extends StatelessWidget {
  const FaccionesScreen({super.key});

  final List<Map<String, dynamic>> facciones = const [
    {'nombre': 'OSADÍA', 'desc': 'El miedo es el enemigo', 'color': Color(0xFFD85A30), 'icon': Icons.bolt},
    {'nombre': 'ERUDICIÓN', 'desc': 'El conocimiento es poder', 'color': Color(0xFF185FA5), 'icon': Icons.menu_book},
    {'nombre': 'ABNEGACIÓN', 'desc': 'Vivir para servir', 'color': Color(0xFF9E9B94), 'icon': Icons.handshake},
    {'nombre': 'VERDAD', 'desc': 'La honestidad ante todo', 'color': Color(0xFF534AB7), 'icon': Icons.balance},
    {'nombre': 'AMABILIDAD', 'desc': 'La paz es el camino', 'color': Color(0xFF3B6D11), 'icon': Icons.spa},
    {'nombre': 'DIVERGENTE', 'desc': 'No cabes en una sola caja', 'color': Color(0xFFC0A060), 'icon': Icons.all_inclusive},
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      backgroundColor: const Color(0xFF080F1A),
      body: Stack(
        children: [
          // Fondo con blobs difusos
          CustomPaint(
            size: MediaQuery.of(context).size,
            painter: AuroraBackgroundPainter(),
          ),
          
          // Letras flotantes de fondo
          ...List.generate(15, (index) => FloatingText(index)),
          
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 16),

                  // Botón de volver
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_ios, size: 18, color: Color(0xFF7A8FA6)),
                      ),
                      const Spacer(),
                    ],
                  ),
                  
                  const SizedBox(height: 8),

                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.auto_awesome, size: 12, color: Color(0x4D7A8FA6)),
                      const SizedBox(width: 6),
                      Text(
                        'LAS FACCIONES',
                        style: TextStyle(
                          fontSize: 10,
                          letterSpacing: 4,
                          fontWeight: FontWeight.w300,
                          color: const Color(0xFF7A8FA6),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 6),
                  
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFFFFFFFF), Color(0xFF8FA8C0)],
                    ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                    child: const Text(
                      'Conoce tu mundo',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Línea decorativa
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Container(width: 30, height: 1, color: Colors.white.withOpacity(0.2)),
                    const SizedBox(width: 6),
                    const Text('◆', style: TextStyle(fontSize: 7, color: Colors.white30)),
                    const SizedBox(width: 6),
                    Container(width: 30, height: 1, color: Colors.white.withOpacity(0.2)),
                  ]),
                  
                  const SizedBox(height: 20),

                  // Grid de facciones TAMAÑO REDUCIDO - 2 columnas, 3 filas
                  SizedBox(
                    height: screenHeight * 0.55,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 1.2,
                      ),
                      itemCount: facciones.length,
                      itemBuilder: (context, index) {
                        final faccion = facciones[index];
                        final Color colorFaccion = faccion['color'] as Color;
                        final String nombre = faccion['nombre'] as String;
                        final String desc = faccion['desc'] as String;
                        final IconData icono = faccion['icon'] as IconData;
                        
                        return TweenAnimationBuilder(
                          tween: Tween<double>(begin: 0, end: 1),
                          duration: Duration(milliseconds: 400 + (index * 80)),
                          builder: (context, double value, child) {
                            return Transform.scale(
                              scale: value,
                              child: Opacity(
                                opacity: value,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        colorFaccion.withOpacity(0.3),
                                        colorFaccion.withOpacity(0.12),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(color: colorFaccion.withOpacity(0.4), width: 1),
                                    boxShadow: [
                                      BoxShadow(color: colorFaccion.withOpacity(0.15), blurRadius: 12, spreadRadius: 0),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(icono, size: 32, color: colorFaccion),
                                      const SizedBox(height: 8),
                                      Text(
                                        nombre,
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: colorFaccion,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8),
                                        child: Text(
                                          desc,
                                          style: const TextStyle(fontSize: 9, color: Color(0xFF8899AA)),
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),

                  const Spacer(),

                  // Botón COMENZAR TEST
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TestScreen())),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [Color(0xFF1A2E42), Color(0xFF0F1E2E)]),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.white.withOpacity(0.15), width: 1),
                          boxShadow: [BoxShadow(color: const Color(0xFF185FA5).withOpacity(0.2), blurRadius: 16)],
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.hexagon_outlined, size: 14, color: Color(0x4DFFFFFF)),
                            SizedBox(width: 8),
                            Text('COMENZAR TEST', style: TextStyle(fontSize: 11, letterSpacing: 3, fontWeight: FontWeight.w500, color: Colors.white)),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward_rounded, size: 14, color: Color(0x80FFFFFF)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FloatingText extends StatelessWidget {
  final int index;
  const FloatingText(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    final texts = ['⚡', '📖', '🤝', '⚖️', '🌿', '∞'];
    final text = texts[index % texts.length];
    final size = MediaQuery.of(context).size;
    final left = (index * 37) % (size.width - 50);
    final top = (index * 23) % (size.height - 100);
    
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(seconds: 4 + (index % 3)),
      curve: Curves.easeInOut,
      builder: (context, double value, child) {
        return Positioned(
          left: left,
          top: top - (value * 30),
          child: Opacity(
            opacity: 0.12,
            child: Text(
              text,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w300, color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}

class AuroraBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..maskFilter = const MaskFilter.blur(BlurStyle.normal, 120.0);
    paint.color = const Color(0xFF185FA5).withOpacity(0.18);
    canvas.drawCircle(const Offset(0, 0), 180, paint);
    paint.color = const Color(0xFF534AB7).withOpacity(0.12);
    canvas.drawCircle(Offset(size.width, size.height * 0.4), 150, paint);
    paint.color = const Color(0xFFD85A30).withOpacity(0.10);
    canvas.drawCircle(Offset(0, size.height), 130, paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}