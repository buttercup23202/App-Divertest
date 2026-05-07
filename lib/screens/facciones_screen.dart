import 'package:flutter/material.dart';

class FaccionesScreen extends StatelessWidget {
  const FaccionesScreen({super.key});

  final List<Map<String, dynamic>> facciones = const [
    {
      'nombre': 'Osadía',
      'desc': 'El miedo es el enemigo. Vivir es conquistarlo cada día.',
      'lema': 'AUDACES FORTUNA IUVAT',
      'color': Color(0xFFD85A30),
      'icon': Icons.bolt,
    },
    {
      'nombre': 'Erudición',
      'desc': 'La ignorancia es la raíz de todos los males. El conocimiento es la única salvación.',
      'lema': 'PALLAS ATENA',
      'color': Color(0xFF185FA5),
      'icon': Icons.menu_book_outlined,
    },
    {
      'nombre': 'Abnegación',
      'desc': 'El egoísmo destruye la sociedad. Existir para los demás, no para uno mismo.',
      'lema': 'ABNEGATIO IN AETERNA',
      'color': Color(0xFF9E9B94),
      'icon': Icons.volunteer_activism_outlined,
    },
    {
      'nombre': 'Verdad',
      'desc': 'La mentira corrompe todo. La honestidad radical, aunque duela, es el único camino.',
      'lema': 'VERITAS ET LUX',
      'color': Color(0xFF534AB7),
      'icon': Icons.balance_outlined,
    },
    {
      'nombre': 'Amabilidad',
      'desc': 'La agresión nace de la ignorancia. La paz y la armonía son la respuesta a todo conflicto.',
      'lema': 'PAX ET CONCORDIA',
      'color': Color(0xFF3B6D11),
      'icon': Icons.spa_outlined,
    },
    {
      'nombre': 'Divergente',
      'desc': 'No cabe en una sola caja. Su mente pertenece a varios mundos a la vez, y por eso el sistema los teme.',
      'lema': 'SINE FACTIONE',
      'color': Color(0xFFC0A060),
      'icon': Icons.all_inclusive_outlined,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080F1A),
      body: Stack(
        children: [
          // Fondo con círculos difusos
          CustomPaint(
            size: MediaQuery.of(context).size,
            painter: AuroraBackgroundPainter(),
          ),

          // Contenido principal
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 24),

                // Botón de volver
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          size: 18,
                          color: Color(0xFF7A8FA6),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                const SizedBox(height: 8),

                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.auto_awesome,
                      size: 14,
                      color: Color(0x4D7A8FA6),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'LAS FACCIONES',
                      style: TextStyle(
                        fontSize: 11,
                        letterSpacing: 5,
                        fontWeight: FontWeight.w300,
                        color: const Color(0xFF7A8FA6),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFFFFFFF),
                      Color(0xFF8FA8C0),
                    ],
                  ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                  child: const Text(
                    'Conoce tu mundo',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Línea decorativa con diamante
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 30,
                      height: 1,
                      color: Colors.white.withOpacity(0.2),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      '◆',
                      style: TextStyle(
                        fontSize: 8,
                        color: Colors.white30,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 30,
                      height: 1,
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Lista de facciones
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: facciones.length,
                    separatorBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 1,
                              color: Colors.white.withOpacity(0.04),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              '·',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withOpacity(0.15),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 1,
                              color: Colors.white.withOpacity(0.04),
                            ),
                          ),
                        ],
                      ),
                    ),
                    itemBuilder: (context, index) {
                      final faccion = facciones[index];
                      final Color colorFaccion = faccion['color'] as Color;
                      final String nombre = faccion['nombre'] as String;
                      final String descripcion = faccion['desc'] as String;
                      final String lema = faccion['lema'] as String;
                      final IconData icono = faccion['icon'] as IconData;

                      final Color colorClaro = Color.lerp(
                        colorFaccion,
                        Colors.white,
                        0.4,
                      )!;

                      return Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF111E2B),
                              Color(0xFF0D1620),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.05),
                            width: 0.5,
                          ),
                          boxShadow: [
                            const BoxShadow(
                              color: Colors.black54,
                              blurRadius: 16,
                              offset: Offset(0, 6),
                            ),
                            BoxShadow(
                              color: colorFaccion.withOpacity(0.12),
                              blurRadius: 20,
                              spreadRadius: -4,
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            // Borde izquierdo
                            Positioned(
                              left: 0,
                              top: 0,
                              bottom: 0,
                              child: Container(
                                width: 3,
                                decoration: BoxDecoration(
                                  color: colorFaccion,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    bottomLeft: Radius.circular(16),
                                  ),
                                ),
                              ),
                            ),
                            // Contenido
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 18,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Círculo con icono
                                  Container(
                                    width: 56,
                                    height: 56,
                                    decoration: BoxDecoration(
                                      gradient: RadialGradient(
                                        colors: [
                                          colorFaccion.withOpacity(0.25),
                                          colorFaccion.withOpacity(0.08),
                                        ],
                                      ),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: colorFaccion.withOpacity(0.4),
                                        width: 1,
                                      ),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        icono,
                                        size: 28,
                                        color: colorFaccion.withOpacity(0.9),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  // Textos
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ShaderMask(
                                          shaderCallback: (bounds) => LinearGradient(
                                            colors: [
                                              colorFaccion,
                                              colorClaro,
                                            ],
                                          ).createShader(bounds),
                                          child: Text(
                                            nombre,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          descripcion,
                                          style: const TextStyle(
                                            fontSize: 12.5,
                                            fontWeight: FontWeight.w300,
                                            color: Color(0xFF8899AA),
                                            height: 1.6,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          lema,
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 1.5,
                                            color: colorFaccion.withOpacity(0.6),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // Botón Comenzar Test
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
                  child: Column(
                    children: [
                      Container(
                        height: 0.5,
                        color: Colors.white.withOpacity(0.1),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('El test comenzará pronto'),
                                backgroundColor: Color(0xFFD85A30),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            side: const BorderSide(
                              color: Colors.white12,
                              width: 1,
                            ),
                            elevation: 0,
                          ),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xFF1A2E42),
                                  Color(0xFF0F1E2E),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'COMENZAR TEST',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 3,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Icon(
                                    Icons.arrow_forward_rounded,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Painter para círculos difusos
class AuroraBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 120.0);

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