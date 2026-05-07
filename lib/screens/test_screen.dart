import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  int selectedOption = -1;
  int currentQuestion = 1;
  final int totalQuestions = 1; // Por ahora solo una pregunta

  final Map<String, dynamic> questionData = {
    'id': 'P1',
    'title': 'La mesa',
    'description': 'Frente a ti hay una mesa con tres objetos: un cuchillo, un libro y una mano extendida.',
    'question': '¿Qué haces?',
    'imageIcon': Icons.table_restaurant,
    'options': [
      {
        'text': 'Tomo el cuchillo',
        'description': 'Instinto de defensa y poder',
        'factionPoints': {'Osadía': 4},
        'color': Color(0xFFD85A30),
      },
      {
        'text': 'Tomo el libro',
        'description': 'Instinto de conocer antes de actuar',
        'factionPoints': {'Erudición': 4},
        'color': Color(0xFF185FA5),
      },
      {
        'text': 'Tomo la mano',
        'description': 'Confiar en otro como primer acto',
        'factionPoints': {'Amabilidad': 3, 'Abnegación': 2},
        'color': Color(0xFF3B6D11),
      },
      {
        'text': 'No tomo nada, observo',
        'description': 'Observar primero, sin comprometerse',
        'factionPoints': {'Verdad': 3, 'Erudición': 1},
        'color': Color(0xFF534AB7),
      },
    ],
  };

  void _selectOption(int index) {
    setState(() {
      selectedOption = index;
    });
  }

  void _nextQuestion() {
    if (selectedOption == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selecciona una opción antes de continuar'),
          backgroundColor: Color(0xFFD85A30),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // Aquí guardaremos los puntos más tarde
    final selectedOptionData = questionData['options'][selectedOption];
    print('Opción seleccionada: ${selectedOptionData['text']}');
    print('Puntos: ${selectedOptionData['factionPoints']}');

    // Por ahora solo mostramos un mensaje
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Respuesta guardada. Puntuación calculada.'),
        backgroundColor: const Color(0xFF185FA5),
        duration: const Duration(seconds: 2),
      ),
    );

    // Aquí luego navegaremos a la siguiente pregunta
    // Navigator.push(context, MaterialPageRoute(builder: (_) => const NextQuestionScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080F1A),
      body: Stack(
        children: [
          // Fondo con círculos difusos
          CustomPaint(
            size: MediaQuery.of(context).size,
            painter: TestBackgroundPainter(),
          ),

          // Contenido principal
          SafeArea(
            child: Column(
              children: [
                // Header con progreso
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                  child: Row(
                    children: [
                      // Botón de volver
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
                      // Indicador de pregunta
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A2E42),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.1),
                            width: 0.5,
                          ),
                        ),
                        child: Text(
                          'PREGUNTA $currentQuestion DE $totalQuestions',
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.5,
                            color: Color(0xFF8A9BB0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Barra de progreso
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: LinearProgressIndicator(
                    value: currentQuestion / totalQuestions,
                    backgroundColor: Colors.white.withOpacity(0.1),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFF185FA5),
                    ),
                    minHeight: 2,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),

                const SizedBox(height: 32),

                // Título de la pregunta
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // Icono decorativo
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: const RadialGradient(
                            colors: [
                              Color(0xFF1A2E42),
                              Color(0xFF0F1E2E),
                            ],
                          ),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withOpacity(0.1),
                            width: 0.5,
                          ),
                        ),
                        child: Icon(
                          questionData['imageIcon'],
                          size: 28,
                          color: const Color(0xFF8A9BB0),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        questionData['title'],
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        questionData['description'],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: Color(0xFF8899AA),
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: 40,
                        height: 1,
                        color: Colors.white.withOpacity(0.2),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        questionData['question'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFC4D8E8),
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Opciones de respuesta
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: questionData['options'].length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final option = questionData['options'][index];
                      final bool isSelected = selectedOption == index;
                      final Color optionColor = option['color'] as Color;

                      return GestureDetector(
                        onTap: () => _selectOption(index),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            gradient: isSelected
                                ? LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      optionColor.withOpacity(0.2),
                                      optionColor.withOpacity(0.05),
                                    ],
                                  )
                                : const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(0xFF111E2B),
                                      Color(0xFF0D1620),
                                    ],
                                  ),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected
                                  ? optionColor.withOpacity(0.6)
                                  : Colors.white.withOpacity(0.05),
                              width: isSelected ? 1.5 : 0.5,
                            ),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: optionColor.withOpacity(0.3),
                                      blurRadius: 16,
                                      spreadRadius: -2,
                                    ),
                                  ]
                                : [
                                    const BoxShadow(
                                      color: Colors.black54,
                                      blurRadius: 8,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 16,
                            ),
                            child: Row(
                              children: [
                                // Indicador circular de selección
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isSelected
                                          ? optionColor
                                          : Colors.white.withOpacity(0.3),
                                      width: 2,
                                    ),
                                  ),
                                  child: isSelected
                                      ? Center(
                                          child: Container(
                                            width: 12,
                                            height: 12,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: optionColor,
                                            ),
                                          ),
                                        )
                                      : null,
                                ),
                                const SizedBox(width: 16),
                                // Texto de la opción
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        option['text'],
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: isSelected
                                              ? FontWeight.w700
                                              : FontWeight.w500,
                                          color: isSelected
                                              ? optionColor
                                              : Colors.white,
                                          letterSpacing: 0.3,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        option['description'],
                                        style: const TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w300,
                                          color: Color(0xFF8899AA),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Flecha indicadora
                                if (isSelected)
                                  Icon(
                                    Icons.check_circle,
                                    size: 20,
                                    color: optionColor,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Botón Siguiente
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
                  child: Column(
                    children: [
                      Container(
                        height: 0.5,
                        color: Colors.white.withOpacity(0.1),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: _nextQuestion,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            side: BorderSide(
                              color: selectedOption != -1
                                  ? const Color(0xFF185FA5).withOpacity(0.5)
                                  : Colors.white.withOpacity(0.1),
                              width: 1,
                            ),
                            elevation: 0,
                          ),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: selectedOption != -1
                                  ? const LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Color(0xFF1A2E42),
                                        Color(0xFF185FA5),
                                      ],
                                    )
                                  : const LinearGradient(
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    currentQuestion == totalQuestions
                                        ? 'VER RESULTADOS'
                                        : 'SIGUIENTE',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 3,
                                      color: selectedOption != -1
                                          ? Colors.white
                                          : Colors.white.withOpacity(0.5),
                                    ),
                                  ),
                                  if (currentQuestion != totalQuestions) ...[
                                    const SizedBox(width: 12),
                                    Icon(
                                      Icons.arrow_forward_rounded,
                                      size: 18,
                                      color: selectedOption != -1
                                          ? Colors.white
                                          : Colors.white.withOpacity(0.5),
                                    ),
                                  ],
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

// Painter para círculos difusos del test
class TestBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 120.0);

    paint.color = const Color(0xFF185FA5).withOpacity(0.15);
    canvas.drawCircle(Offset(size.width * 0.2, size.height * 0.2), 150, paint);

    paint.color = const Color(0xFFD85A30).withOpacity(0.10);
    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.7), 140, paint);

    paint.color = const Color(0xFF534AB7).withOpacity(0.12);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.9), 120, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}