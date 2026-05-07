import 'package:flutter/material.dart';

class FaccionesScreen extends StatelessWidget {
  const FaccionesScreen({super.key});

  final List<Map<String, dynamic>> facciones = const [
    {
      'nombre': 'Osadía',
      'desc':
          'El miedo es el enemigo. Vivir es conquistarlo cada día.',
      'color': Color(0xFFD85A30),
      'icon': Icons.bolt,
    },
    {
      'nombre': 'Erudición',
      'desc':
          'La ignorancia es la raíz de todos los males. El conocimiento es la única salvación.',
      'color': Color(0xFF185FA5),
      'icon': Icons.menu_book_outlined,
    },
    {
      'nombre': 'Abnegación',
      'desc':
          'El egoísmo destruye la sociedad. Existir para los demás, no para uno mismo.',
      'color': Color(0xFF9E9B94),
      'icon': Icons.volunteer_activism_outlined,
    },
    {
      'nombre': 'Verdad',
      'desc':
          'La mentira corrompe todo. La honestidad radical, aunque duela, es el único camino.',
      'color': Color(0xFF534AB7),
      'icon': Icons.balance_outlined,
    },
    {
      'nombre': 'Amabilidad',
      'desc':
          'La agresión nace de la ignorancia. La paz y la armonía son la respuesta a todo conflicto.',
      'color': Color(0xFF3B6D11),
      'icon': Icons.spa_outlined,
    },
    {
      'nombre': 'Divergente',
      'desc':
          'No cabe en una sola caja. Su mente pertenece a varios mundos a la vez, y por eso el sistema los teme.',
      'color': Color(0xFFC0A060),
      'icon': Icons.all_inclusive_outlined,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),
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
                      color: Color(0xFF8A9BB0),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'LAS FACCIONES',
              style: TextStyle(
                fontSize: 11,
                letterSpacing: 5,
                fontWeight: FontWeight.w300,
                color: Colors.white.withOpacity(0.5),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Conoce tu mundo',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              width: 40,
              height: 1.5,
              color: Colors.white.withOpacity(0.25),
            ),
            const SizedBox(height: 24),

            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: facciones.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final faccion = facciones[index];
                  final Color colorFaccion = faccion['color'] as Color;
                  final String nombre = faccion['nombre'] as String;
                  final String descripcion = faccion['desc'] as String;
                  final IconData icono = faccion['icon'] as IconData;

                  return Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF111E2B),
                      borderRadius: BorderRadius.circular(14),
                      border: Border(
                        left: BorderSide(
                          color: colorFaccion,
                          width: 3,
                        ),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: colorFaccion.withOpacity(0.15),
                          blurRadius: 12,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 16,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color: colorFaccion.withOpacity(0.18),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Icon(
                              icono,
                              size: 26,
                              color: colorFaccion,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                nombre,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: colorFaccion,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                descripcion,
                                style: const TextStyle(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w300,
                                  color: Color(0xFFB0BEC5),
                                  height: 1.55,
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

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
              child: SizedBox(
                width: double.infinity,
                height: 54,
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
                    backgroundColor: const Color(0xFF1A2E42),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    side: const BorderSide(
                      color: Colors.white24,
                      width: 1,
                    ),
                    elevation: 0,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'COMENZAR TEST',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2.5,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 14,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}