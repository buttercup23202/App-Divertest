import 'package:flutter/material.dart';

void main() {
  runApp(const DivergentTestApp());
}

class DivergentTestApp extends StatelessWidget {
  const DivergentTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test Divergente',
      theme: ThemeData(
        fontFamily: 'Georgia',
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      home: const WelcomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A2A3A), // Azul sobrio profundo
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Título
                  const Text(
                    'EL MUNDO DE',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 4,
                      color: Color(0xFFA0B8CC),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'DIVERGENTE',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 6,
                      color: Color(0xFFE8F0F8),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Círculo cromático con facciones
                  SizedBox(
                    width: 340,
                    height: 340,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Anillo exterior de facciones
                        ..._buildFactionCircles(),
                        
                        // Círculo central (el test)
                        GestureDetector(
                          onTap: () {
                            // Aquí navegaremos al test
                          },
                          child: Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                              color: const Color(0xFF2A3A4A),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFF5A7A9A),
                                width: 0.8,
                              ),
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '✧',
                                  style: TextStyle(
                                    fontSize: 28,
                                    color: Color(0xFFC4D8E8),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'TEST DE\nAPTITUD',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 1.5,
                                    color: Color(0xFFC4D8E8),
                                  ),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  'comenzar',
                                  style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w300,
                                    letterSpacing: 1,
                                    color: Color(0xFF8AACCA),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 48),

                  // Frase inferior
                  const Text(
                    'UNA ELECCIÓN PUEDE TRANSFORMARTE',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 2,
                      color: Color(0xFF6A8AAA),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    '#DIVERGENTE',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 2,
                      color: Color(0xFF4A6A8A),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildFactionCircles() {
    const List<FactionData> factions = [
      FactionData('AMABILIDAD', '🌿', Color(0xFF6B9E7A)),
      FactionData('ERUDICIÓN', '📖', Color(0xFF5B8BB0)),
      FactionData('OSADÍA', '⚡', Color(0xFFC47A5A)),
      FactionData('VERDAD', '⚖️', Color(0xFFB8A45A)),
      FactionData('ABNEGACIÓN', '🕯️', Color(0xFF9B8B70)),
      FactionData('DIVERGENTE', '🌀', Color(0xFFC49A8B)),
    ];

    List<Widget> circles = [];
    
    // Posiciones manuales para mejor distribución circular
    const List<Offset> positions = [
      Offset(0, -130),     // Amabilidad (arriba)
      Offset(112, -65),    // Erudición (derecha arriba)
      Offset(112, 65),     // Osadía (derecha abajo)
      Offset(0, 130),      // Verdad (abajo)
      Offset(-112, 65),    // Abnegación (izquierda abajo)
      Offset(-112, -65),   // Divergente (izquierda arriba)
    ];
    
    for (int i = 0; i < positions.length; i++) {
      circles.add(
        Positioned(
          left: 170 + positions[i].dx - 40,
          top: 170 + positions[i].dy - 40,
          child: _FactionCircle(
            faction: factions[i],
          ),
        ),
      );
    }
    
    return circles;
  }
}

class FactionData {
  final String name;
  final String emoji;
  final Color color;
  
  const FactionData(this.name, this.emoji, this.color);
}

class _FactionCircle extends StatelessWidget {
  final FactionData faction;
  
  const _FactionCircle({required this.faction});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: faction.color.withOpacity(0.85), // Mucho menos transparente
        border: Border.all(
          color: faction.color.withOpacity(0.9),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: faction.color.withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            faction.emoji,
            style: const TextStyle(fontSize: 28),
          ),
          const SizedBox(height: 6),
          Text(
            faction.name,
            style: TextStyle(
              fontSize: 10,
              fontWeight: faction.name == 'DIVERGENTE' ? FontWeight.w700 : FontWeight.w600,
              letterSpacing: 1,
              color: faction.name == 'DIVERGENTE' 
                  ? Colors.white 
                  : const Color(0xFFF0F4F8),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}