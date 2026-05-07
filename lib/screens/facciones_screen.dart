import 'package:flutter/material.dart';
import 'test_screen.dart';

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
          // Fondo con blobs difusos
          CustomPaint(
            size: MediaQuery.of(context).size,
            painter: FactionsBackgroundPainter(),
          ),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 48),

                // Header con flecha back
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: const Icon(
                            Icons.arrow_back_ios_rounded,
                            size: 18,
                            color: Color(0x61FFFFFF),
                          ),
                        ),
                      ),
                      const Spacer(),
                      // Píldora sutil
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white10),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.auto_awesome,
                              size: 10,
                              color: Color(0x4DFFFFFF),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'LAS FACCIONES',
                              style: TextStyle(
                                fontSize: 10,
                                letterSpacing: 4,
                                fontWeight: FontWeight.w400,
                                color: const Color(0x66FFFFFF),
                                fontFamily: 'Georgia',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      const SizedBox(width: 50),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // Título principal
                Text(
                  'Conoce tu mundo',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 1,
                    fontFamily: 'Georgia',
                  ),
                ),

                const SizedBox(height: 12),

                // Separador diamante
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 30,
                      height: 1,
                      color: Colors.white.withOpacity(0.2),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '◆',
                      style: TextStyle(
                        fontSize: 8,
                        color: Colors.white.withOpacity(0.3),
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

                const SizedBox(height: 32),

                // Lista de facciones
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: facciones.length,
                    itemBuilder: (context, index) {
                      final faccion = facciones[index];
                      final Color colorFaccion = faccion['color'] as Color;
                      final String nombre = faccion['nombre'] as String;
                      final String descripcion = faccion['desc'] as String;
                      final String lema = faccion['lema'] as String;
                      final IconData icono = faccion['icon'] as IconData;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xFF0D1E30),
                                Color(0xFF080F1A),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: colorFaccion.withOpacity(0.2),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: colorFaccion.withOpacity(0.1),
                                blurRadius: 24,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                // Icono grande
                                Container(
                                  width: 64,
                                  height: 64,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        colorFaccion.withOpacity(0.3),
                                        colorFaccion.withOpacity(0.08),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: colorFaccion.withOpacity(0.5),
                                      width: 1,
                                    ),
                                  ),
                                  child: Icon(
                                    icono,
                                    size: 30,
                                    color: colorFaccion,
                                  ),
                                ),
                                const SizedBox(width: 18),
                                // Textos
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        lema,
                                        style: TextStyle(
                                          fontSize: 9,
                                          letterSpacing: 2,
                                          fontWeight: FontWeight.w500,
                                          color: colorFaccion.withOpacity(0.6),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        nombre,
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                          color: colorFaccion,
                                          fontFamily: 'Georgia',
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        descripcion,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF7A8FA6),
                                          height: 1.5,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 16),

                // Botón COMENZAR TEST
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const TestScreen(),
                        ),
                      );
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xFF1A3050),
                            Color(0xFF0D1E30),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.15),
                          width: 1,
                        ),
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
                          Icon(
                            Icons.hexagon_outlined,
                            size: 16,
                            color: Color(0x4DFFFFFF),
                          ),
                          SizedBox(width: 8),
                          Text(
                            'COMENZAR TEST',
                            style: TextStyle(
                              fontSize: 13,
                              letterSpacing: 3,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward_rounded,
                            size: 16,
                            color: Color(0x80FFFFFF),
                          ),
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
}

class FactionsBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 140.0);

    paint.color = const Color(0xFF185FA5).withOpacity(0.15);
    canvas.drawCircle(Offset(0, 0), 180, paint);

    paint.color = const Color(0xFF534AB7).withOpacity(0.10);
    canvas.drawCircle(
      Offset(size.width * 0.7, size.height * 0.4), 150, paint);

    paint.color = const Color(0xFFD85A30).withOpacity(0.08);
    canvas.drawCircle(
      Offset(size.width * 0.3, size.height), 160, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}