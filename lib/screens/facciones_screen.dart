import 'dart:ui';
import 'package:flutter/material.dart';
import 'test_screen.dart';

class FaccionesScreen extends StatelessWidget {
  const FaccionesScreen({super.key});

  final List<Map<String, dynamic>> facciones = const [
    {'nombre': 'OSADÍA', 'frase': 'El miedo es el enemigo', 'descripcion': 'El miedo es el enemigo. Vivir es conquistarlo cada día.', 'color': Color(0xFFD85A30), 'icon': Icons.bolt},
    {'nombre': 'ERUDICIÓN', 'frase': 'El conocimiento es poder', 'descripcion': 'La ignorancia es la raíz de todos los males. El conocimiento es la única salvación.', 'color': Color(0xFF185FA5), 'icon': Icons.menu_book},
    {'nombre': 'ABNEGACIÓN', 'frase': 'Vivir para servir', 'descripcion': 'El egoísmo destruye la sociedad. Existir para los demás, no para uno mismo.', 'color': Color(0xFF9E9B94), 'icon': Icons.handshake},
    {'nombre': 'VERDAD', 'frase': 'La honestidad ante todo', 'descripcion': 'La mentira corrompe todo. La honestidad radical, aunque duela, es el único camino.', 'color': Color(0xFF534AB7), 'icon': Icons.balance},
    {'nombre': 'AMABILIDAD', 'frase': 'La paz es el camino', 'descripcion': 'La agresión nace de la ignorancia. La paz y la armonía son la respuesta a todo conflicto.', 'color': Color(0xFF3B6D11), 'icon': Icons.spa},
    {'nombre': 'DIVERGENTE', 'frase': 'No cabes en una caja', 'descripcion': 'No cabe en una sola caja. Su mente pertenece a varios mundos a la vez, y por eso el sistema los teme.', 'color': Color(0xFFC0A060), 'icon': Icons.all_inclusive},
  ];

  void _showFactionDialog(BuildContext context, Map<String, dynamic> faccion) {
    final Color colorFaccion = faccion['color'] as Color;
    final String nombre = faccion['nombre'] as String;
    final String descripcion = faccion['descripcion'] as String;
    final IconData icono = faccion['icon'] as IconData;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 24),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      colorFaccion.withOpacity(0.3),
                      colorFaccion.withOpacity(0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: colorFaccion.withOpacity(0.4),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: colorFaccion.withOpacity(0.3),
                      blurRadius: 24,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(24, 48, 24, 28),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              gradient: RadialGradient(
                                colors: [
                                  colorFaccion.withOpacity(0.35),
                                  colorFaccion.withOpacity(0.1),
                                ],
                              ),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: colorFaccion.withOpacity(0.5),
                                width: 1.5,
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                icono,
                                size: 34,
                                color: colorFaccion,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            nombre,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 3,
                              color: colorFaccion,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            width: 50,
                            height: 1,
                            color: colorFaccion.withOpacity(0.4),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            descripcion,
                            style: const TextStyle(
                              fontSize: 14,
                              height: 1.5,
                              color: Color(0xFFD0D8E8),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 28),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    colorFaccion.withOpacity(0.2),
                                    colorFaccion.withOpacity(0.05),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: colorFaccion.withOpacity(0.3),
                                  width: 0.8,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.close,
                                    size: 16,
                                    color: Colors.white70,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'CERRAR',
                                    style: TextStyle(
                                      fontSize: 11,
                                      letterSpacing: 2,
                                      color: colorFaccion.withOpacity(0.8),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: -12,
                right: -12,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: colorFaccion.withOpacity(0.9),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: colorFaccion.withOpacity(0.5),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final hexSize = screenWidth / 2.8;
    final hexHeight = hexSize * 0.87;
    
    // Posiciones para el panal completo (6 hexágonos)
    final double centerX = screenWidth / 2;
    final double centerY = 240;
    final double offsetX = hexSize * 0.75;
    final double offsetY = hexHeight * 0.75;

    return Scaffold(
      backgroundColor: const Color(0xFF080F1A),
      body: Stack(
        children: [
          CustomPaint(
            size: MediaQuery.of(context).size,
            painter: AuroraBackgroundPainter(),
          ),
          
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 8),

                // Botón de volver
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_ios, size: 18, color: Color(0xFF7A8FA6)),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                
                const SizedBox(height: 4),

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
                        letterSpacing: 5,
                        fontWeight: FontWeight.w300,
                        color: const Color(0xFF7A8FA6),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 4),
                
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
                
                const SizedBox(height: 6),
                
                // Línea decorativa
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(width: 30, height: 1, color: Colors.white.withOpacity(0.2)),
                  const SizedBox(width: 6),
                  const Text('◆', style: TextStyle(fontSize: 7, color: Colors.white30)),
                  const SizedBox(width: 6),
                  Container(width: 30, height: 1, color: Colors.white.withOpacity(0.2)),
                ]),
                
                const SizedBox(height: 24),

                // PANAL DE HEXÁGONOS (6 facciones)
                SizedBox(
                  height: 380,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Arriba - Osadía
                      Positioned(
                        left: centerX - hexSize / 2,
                        top: centerY - hexHeight - 4,
                        child: _buildHexagonCard(
                          icono: facciones[0]['icon'] as IconData,
                          nombre: facciones[0]['nombre'] as String,
                          color: facciones[0]['color'] as Color,
                          onTap: () => _showFactionDialog(context, facciones[0]),
                        ),
                      ),
                      
                      // Arriba Derecha - Erudición
                      Positioned(
                        left: centerX + offsetX - hexSize / 2,
                        top: centerY - offsetY - 4,
                        child: _buildHexagonCard(
                          icono: facciones[1]['icon'] as IconData,
                          nombre: facciones[1]['nombre'] as String,
                          color: facciones[1]['color'] as Color,
                          onTap: () => _showFactionDialog(context, facciones[1]),
                        ),
                      ),
                      
                      // Derecha - Abnegación
                      Positioned(
                        left: centerX + offsetX - hexSize / 2,
                        top: centerY + offsetY - 4,
                        child: _buildHexagonCard(
                          icono: facciones[2]['icon'] as IconData,
                          nombre: facciones[2]['nombre'] as String,
                          color: facciones[2]['color'] as Color,
                          onTap: () => _showFactionDialog(context, facciones[2]),
                        ),
                      ),
                      
                      // Abajo - Verdad
                      Positioned(
                        left: centerX - hexSize / 2,
                        top: centerY + hexHeight + 4,
                        child: _buildHexagonCard(
                          icono: facciones[3]['icon'] as IconData,
                          nombre: facciones[3]['nombre'] as String,
                          color: facciones[3]['color'] as Color,
                          onTap: () => _showFactionDialog(context, facciones[3]),
                        ),
                      ),
                      
                      // Abajo Izquierda - Amabilidad
                      Positioned(
                        left: centerX - offsetX - hexSize / 2,
                        top: centerY + offsetY - 4,
                        child: _buildHexagonCard(
                          icono: facciones[4]['icon'] as IconData,
                          nombre: facciones[4]['nombre'] as String,
                          color: facciones[4]['color'] as Color,
                          onTap: () => _showFactionDialog(context, facciones[4]),
                        ),
                      ),
                      
                      // Centro - Divergente
                      Positioned(
                        left: centerX - hexSize / 2,
                        top: centerY - hexHeight / 2,
                        child: _buildHexagonCard(
                          icono: facciones[5]['icon'] as IconData,
                          nombre: facciones[5]['nombre'] as String,
                          color: facciones[5]['color'] as Color,
                          onTap: () => _showFactionDialog(context, facciones[5]),
                          isCenter: true,
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Botón COMENZAR TEST
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TestScreen())),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Color(0xFF1A2E42), Color(0xFF0F1E2E)],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white.withOpacity(0.15), width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF185FA5).withOpacity(0.2),
                            blurRadius: 20,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.hexagon_outlined, size: 14, color: Color(0x4DFFFFFF)),
                          SizedBox(width: 6),
                          Text(
                            'COMENZAR TEST',
                            style: TextStyle(
                              fontSize: 11,
                              letterSpacing: 2.5,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 6),
                          Icon(Icons.arrow_forward_rounded, size: 14, color: Color(0x80FFFFFF)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHexagonCard({
    required IconData icono,
    required String nombre,
    required Color color,
    required VoidCallback onTap,
    bool isCenter = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: isCenter ? 110 : 95,
        height: isCenter ? 127 : 110,
        child: ClipPath(
          clipper: HexagonClipper(),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  color.withOpacity(isCenter ? 0.35 : 0.25),
                  color.withOpacity(isCenter ? 0.15 : 0.08),
                ],
              ),
              border: Border.all(
                color: color.withOpacity(isCenter ? 0.5 : 0.35),
                width: isCenter ? 1.5 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(isCenter ? 0.3 : 0.15),
                  blurRadius: isCenter ? 16 : 12,
                  spreadRadius: isCenter ? 2 : 0,
                ),
              ],
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icono,
                    size: isCenter ? 30 : 26,
                    color: color.withOpacity(0.9),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    nombre,
                    style: TextStyle(
                      fontSize: isCenter ? 10 : 8.5,
                      fontWeight: FontWeight.w600,
                      color: color.withOpacity(0.9),
                      letterSpacing: 0.8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Clipper para forma de hexágono
class HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final double width = size.width;
    final double height = size.height;
    final double side = width / 2;
    final Path path = Path();
    
    path.moveTo(side, 0);
    path.lineTo(width, height * 0.25);
    path.lineTo(width, height * 0.75);
    path.lineTo(side, height);
    path.lineTo(0, height * 0.75);
    path.lineTo(0, height * 0.25);
    path.close();
    
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class AuroraBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..maskFilter = const MaskFilter.blur(BlurStyle.normal, 140.0);
    
    paint.color = const Color(0xFF185FA5).withOpacity(0.15);
    canvas.drawCircle(const Offset(0, 0), 180, paint);
    
    paint.color = const Color(0xFF534AB7).withOpacity(0.10);
    canvas.drawCircle(Offset(size.width * 0.7, size.height * 0.4), 150, paint);
    
    paint.color = const Color(0xFFD85A30).withOpacity(0.08);
    canvas.drawCircle(Offset(size.width * 0.3, size.height), 160, paint);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}